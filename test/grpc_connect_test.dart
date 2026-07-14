import 'package:flutter_test/flutter_test.dart';
import 'package:grpc/grpc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webitel_portal_sdk/src/data/grpc/grpc_connect.dart';
import 'package:webitel_portal_sdk/src/data/shared_preferences/shared_preferences_gateway.dart';
import 'package:webitel_portal_sdk/src/generated/portal/connect.pb.dart'
    as portal;
import 'package:webitel_portal_sdk/src/generated/portal/messages.pb.dart';

import 'support/fakes.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late FakePortalServer server;
  late GrpcConnect grpcConnect;

  setUp(() async {
    SharedPreferences.setMockInitialValues({
      'userId': 'user-1',
      'accessToken': 'token-1',
    });
    server = FakePortalServer();

    final gateway = SharedPreferencesGateway();
    await gateway.init();

    grpcConnect = GrpcConnect(gateway, TestGrpcChannel(server));
  });

  test('a burst of concurrent sends opens exactly one stream and delivers each request once',
      () async {
    await Future.wait([
      grpcConnect.sendRequest(testRequest('r1')),
      grpcConnect.sendRequest(testRequest('r2')),
      grpcConnect.sendRequest(testRequest('r3')),
    ]);
    await pumpEventQueue();

    expect(server.connectCount, 1,
        reason: 'concurrent sends must share one Connect stream');
    expect(server.sentRequests.map((r) => r.id).toList()..sort(),
        ['r1', 'r2', 'r3'],
        reason: 'each request must be delivered exactly once');
  });

  test('reconnect closes the previous call before opening a new one',
      () async {
    await grpcConnect.sendRequest(testRequest('r1'));
    final first = server.current;

    await grpcConnect.reconnect();
    await pumpEventQueue();

    expect(server.connectCount, 2);
    expect(first.clientClosedRequests, isTrue,
        reason: 'the old request sink must be closed on reconnect');

    await grpcConnect.sendRequest(testRequest('r2'));
    await pumpEventQueue();

    expect(first.requestLog.where((r) => r.id == 'r2'), isEmpty,
        reason: 'a request must never reach a torn-down stream');
    expect(server.current.requestLog.where((r) => r.id == 'r2'), hasLength(1));
  });

  test('an error on a stale stream does not affect the current one', () async {
    await grpcConnect.sendRequest(testRequest('r1'));
    final first = server.current;

    await grpcConnect.reconnect();
    first.fail(GrpcError.unavailable('stale stream blew up'));
    await pumpEventQueue();

    await grpcConnect.sendRequest(testRequest('r2'));
    await pumpEventQueue();

    expect(server.connectCount, 2,
        reason: 'a stale error must not force another reconnect');
    expect(server.current.requestLog.where((r) => r.id == 'r2'), hasLength(1));
  });

  test('a disconnect update closes the call and the next send reconnects',
      () async {
    await grpcConnect.sendRequest(testRequest('r1'));
    server.current.push(disconnectUpdate());
    await pumpEventQueue();

    await grpcConnect.sendRequest(testRequest('r2'));
    await pumpEventQueue();

    expect(server.connectCount, 2);
    expect(server.current.requestLog.where((r) => r.id == 'r2'), hasLength(1));
  });

  test('chatComplete update does not break the update stream', () async {
    await grpcConnect.sendRequest(testRequest('r1'));
    final messages = <UpdateNewMessage>[];
    final subscription = grpcConnect.updateStream.listen(messages.add);

    server.current.push(chatCompleteUpdate());
    server.current.push(pushedMessage(messageId: 7, chatId: 'chat-1'));
    await pumpEventQueue();

    expect(server.connectCount, 1,
        reason: 'chatComplete must not tear down the transport');
    expect(messages, hasLength(1));
    expect(messages.single.message.id.toInt(), 7);

    await subscription.cancel();
  });

  test('routes Response envelopes and pushed messages to separate streams',
      () async {
    await grpcConnect.sendRequest(testRequest('r1'));

    final responses = <portal.Response>[];
    final messages = <UpdateNewMessage>[];
    final responseSub = grpcConnect.responseStream.listen(responses.add);
    final updateSub = grpcConnect.updateStream.listen(messages.add);

    server.current
        .push(sendAck(requestId: 'r1', messageId: 5, chatId: 'chat-1'));
    server.current.push(pushedMessage(messageId: 6, chatId: 'chat-1'));
    await pumpEventQueue();

    expect(responses.map((r) => r.id), contains('r1'));
    expect(messages, hasLength(1));
    expect(messages.single.message.id.toInt(), 6);

    await responseSub.cancel();
    await updateSub.cancel();
  });

  test('server accepting the stream (headers) marks it open without any update',
      () async {
    server.replyToPing = false;
    server.onConnect = (connection) => connection.acceptStream();

    await grpcConnect.sendRequest(testRequest('r1'));
    await pumpEventQueue();

    expect(server.connectCount, 1);
    expect(server.sentRequests.map((r) => r.id), contains('r1'),
        reason: 'initial metadata alone must be enough to unblock sending');
  });

  test('sendRequest throws a GrpcError when the stream fails to establish',
      () async {
    server.replyToPing = false;
    server.onConnect =
        (connection) => connection.fail(GrpcError.unauthenticated('bad token'));

    await expectLater(
      grpcConnect.sendRequest(testRequest('r1')),
      throwsA(isA<GrpcError>()),
    );
  });
}
