import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webitel_portal_sdk/src/data/constants/constants.dart';
import 'package:webitel_portal_sdk/src/data/grpc/grpc_connect.dart';
import 'package:webitel_portal_sdk/src/data/service_impl/chat_service_impl.dart';
import 'package:webitel_portal_sdk/src/data/shared_preferences/shared_preferences_gateway.dart';
import 'package:webitel_portal_sdk/src/generated/portal/messages.pb.dart'
    as pmsg;
import 'package:webitel_portal_sdk/webitel_portal_sdk.dart';

import 'support/fakes.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const chatId = 'chat-1';

  late FakePortalServer server;
  late ChatServiceImpl chatService;

  DialogMessageRequest messageRequest(String requestId,
          [String content = 'hello']) =>
      DialogMessageRequest(
        requestId: requestId,
        content: content,
        uploadFile: UploadFile(id: '', name: '', type: ''),
      );

  /// Auto-acks every SendMessage with the given server-side message id.
  void autoAck({required int messageId}) {
    server.onRequest = (request, connection) {
      if (request.path == Constants.sendMessagePath) {
        connection.push(sendAck(
          requestId: request.id,
          messageId: messageId,
          chatId: chatId,
        ));
      }
    };
  }

  setUp(() async {
    SharedPreferences.setMockInitialValues({
      'userId': 'user-1',
      'accessToken': 'token-1',
    });
    server = FakePortalServer();

    final gateway = SharedPreferencesGateway();
    await gateway.init();

    final channel = TestGrpcChannel(server);
    chatService = ChatServiceImpl(channel, GrpcConnect(gateway, channel), gateway);
  });

  test('sendMessage resolves with the ack and puts the idempotency id on the wire',
      () async {
    autoAck(messageId: 100);

    final response = await chatService.sendMessage(
      chatId: chatId,
      message: messageRequest('req-1'),
    );

    expect(response.dialogMessageContent, 'ack');
    expect(response.requestId, 'req-1');
    expect(response.messageId, 100);

    final wire = server.sentRequests.single;
    expect(wire.id, 'req-1');
    final sendRequest = wire.data.unpackInto(pmsg.SendMessageRequest());
    expect(sendRequest.id, 'req-1',
        reason: 'SendMessageRequest.id must carry the idempotency key');
  });

  test('the same requestId in flight is sent over the wire only once',
      () async {
    // No auto-ack: keep the first send in flight while the duplicate arrives.
    final first = chatService.sendMessage(
      chatId: chatId,
      message: messageRequest('req-dup'),
    );
    final second = chatService.sendMessage(
      chatId: chatId,
      message: messageRequest('req-dup'),
    );
    await pumpEventQueue();

    expect(server.sentRequests, hasLength(1),
        reason: 'a duplicate in-flight send must not reach the wire');

    server.current
        .push(sendAck(requestId: 'req-dup', messageId: 101, chatId: chatId));

    final results = await Future.wait([first, second]);
    expect(identical(results[0], results[1]), isTrue,
        reason: 'both callers must get the same response instance');

    // After completion the requestId is free again: a deliberate retry works.
    autoAck(messageId: 102);
    final retry = await chatService.sendMessage(
      chatId: chatId,
      message: messageRequest('req-dup'),
    );
    expect(retry.messageId, 102);
  });

  test('a duplicate ack for the same request id completes once without errors',
      () async {
    final send = chatService.sendMessage(
      chatId: chatId,
      message: messageRequest('req-2'),
    );
    await pumpEventQueue();

    server.current
        .push(sendAck(requestId: 'req-2', messageId: 103, chatId: chatId));
    server.current
        .push(sendAck(requestId: 'req-2', messageId: 103, chatId: chatId));
    await pumpEventQueue();

    final response = await send;
    expect(response.messageId, 103);
    // An unhandled StateError from the second ack would fail this test.
  });

  test('a message pushed twice reaches onNewMessage only once', () async {
    final controller = await chatService.getControllerForNewMessage(chatId);
    final events = <DialogMessageResponse>[];
    final subscription = controller.stream.listen(events.add);

    await chatService.reconnectToStream();
    server.current.push(pushedMessage(messageId: 42, chatId: chatId));
    server.current.push(pushedMessage(messageId: 42, chatId: chatId));
    server.current.push(pushedMessage(messageId: 43, chatId: chatId));
    await pumpEventQueue();

    expect(events, hasLength(2),
        reason: 'the duplicate of message 42 must be dropped');
    expect(events.map((e) => e.messageId), [42, 43]);

    await subscription.cancel();
  });

  test('an acked own message pushed later as an update is not re-emitted',
      () async {
    final controller = await chatService.getControllerForNewMessage(chatId);
    final events = <DialogMessageResponse>[];
    final subscription = controller.stream.listen(events.add);

    autoAck(messageId: 77);
    await chatService.sendMessage(
      chatId: chatId,
      message: messageRequest('req-3'),
    );

    server.current.push(pushedMessage(messageId: 77, chatId: chatId));
    await pumpEventQueue();

    expect(events, isEmpty,
        reason: 'the echo of an already acked message must not reach the UI');

    await subscription.cancel();
  });

  test('a silent server yields a timeout error response, not an exception',
      () async {
    final response = await chatService.sendMessage(
      chatId: chatId,
      message: messageRequest('req-4'),
      timeout: 1,
    );

    expect(response.error?.errorMessage, contains('timeout'));
    expect(response.requestId, 'req-4');
  });

  test('timeout 0 is normalized and does not fail instantly', () async {
    server.onRequest = (request, connection) {
      if (request.path == Constants.sendMessagePath) {
        Future<void>.delayed(const Duration(milliseconds: 200), () {
          connection.push(sendAck(
            requestId: request.id,
            messageId: 104,
            chatId: chatId,
          ));
        });
      }
    };

    final response = await chatService.sendMessage(
      chatId: chatId,
      message: messageRequest('req-5'),
      timeout: 0,
    );

    expect(response.dialogMessageContent, 'ack',
        reason: 'timeout 0 used to fail every send instantly');
  });
}
