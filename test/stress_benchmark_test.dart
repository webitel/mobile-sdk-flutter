// Comparative stress benchmark: the pre-fix transport stack (test/support/
// legacy, extracted from git HEAD) versus the current one, driven through the
// same in-memory portal server. Run with:
//
//   flutter test test/stress_benchmark_test.dart
//
// The assertions double as regressions: the new stack must show zero wire
// duplicates and a single connection; the legacy stack demonstrably fails.
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webitel_portal_sdk/src/data/constants/constants.dart';
import 'package:webitel_portal_sdk/src/data/grpc/grpc_connect.dart';
import 'package:webitel_portal_sdk/src/data/service_impl/chat_service_impl.dart';
import 'package:webitel_portal_sdk/src/data/shared_preferences/shared_preferences_gateway.dart';
import 'package:webitel_portal_sdk/src/domain/services/chat_service.dart';
import 'package:webitel_portal_sdk/webitel_portal_sdk.dart';

import 'support/fakes.dart';
import 'support/legacy/legacy_chat_service.dart';
import 'support/legacy/legacy_grpc_connect.dart';

const chatId = 'chat-1';

DialogMessageRequest messageRequest(String requestId) => DialogMessageRequest(
      requestId: requestId,
      content: 'stress',
      uploadFile: UploadFile(id: '', name: '', type: ''),
    );

Future<(FakePortalServer, ChatService)> buildStack({
  required bool legacy,
}) async {
  SharedPreferences.setMockInitialValues({
    'userId': 'user-1',
    'accessToken': 'token-1',
  });
  final server = FakePortalServer();
  final gateway = SharedPreferencesGateway();
  await gateway.init();
  final channel = TestGrpcChannel(server);

  final ChatService service = legacy
      ? LegacyChatServiceImpl(
          channel, LegacyGrpcConnect(gateway, channel), gateway)
      : ChatServiceImpl(channel, GrpcConnect(gateway, channel), gateway);

  var nextMessageId = 0;
  server.onRequest = (request, connection) {
    if (request.path == Constants.sendMessagePath &&
        identical(connection, server.current)) {
      // Ack only from the newest connection: on the legacy stack the same
      // request reaches several live connections, and acking from each would
      // multiply responses on top of multiplying requests.
      connection.push(sendAck(
        requestId: request.id,
        messageId: ++nextMessageId,
        chatId: chatId,
      ));
    }
  };
  return (server, service);
}

/// Wire copies per logical request id, ignoring pings.
Map<String, int> wireCopies(FakePortalServer server) {
  final copies = <String, int>{};
  for (final request in server.sentRequests) {
    copies[request.id] = (copies[request.id] ?? 0) + 1;
  }
  return copies;
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('scenario A — reconnect churn (5 disconnects mid-session)', () {
    Future<void> run({required bool legacy}) async {
      final (server, service) = await buildStack(legacy: legacy);
      const rounds = 5;

      await service.sendMessage(
          chatId: chatId, message: messageRequest('warmup'), timeout: 30);

      for (var i = 0; i < rounds; i++) {
        server.current.push(disconnectUpdate());
        await pumpEventQueue();
        await service.sendMessage(
            chatId: chatId, message: messageRequest('churn-$i'), timeout: 30);
        await pumpEventQueue();
      }

      final copies = wireCopies(server);
      final logical = rounds + 1;
      final total = server.sentRequests.length;
      final label = legacy ? 'LEGACY' : 'NEW   ';
      // ignore: avoid_print
      print('BENCH churn   $label connections=${server.connectCount} '
          'logicalSends=$logical wireRequests=$total '
          'duplicates=${total - logical} '
          'copiesOfLast=${copies['churn-${rounds - 1}']}');

      if (legacy) {
        expect(total - logical, greaterThan(0),
            reason: 'legacy stack is expected to duplicate under churn');
      } else {
        expect(server.connectCount, rounds + 1);
        expect(total - logical, 0,
            reason: 'new stack must not duplicate a single request');
        expect(copies.values.every((n) => n == 1), isTrue);
      }
    }

    test('legacy', () async => run(legacy: true),
        timeout: const Timeout(Duration(minutes: 2)));
    test('new', () async => run(legacy: false));
  });

  group('scenario B — long session, 3 batches x 1000 sends', () {
    Future<void> run({required bool legacy}) async {
      final (server, service) = await buildStack(legacy: legacy);
      const batches = 3;
      const perBatch = 1000;

      await service.sendMessage(
          chatId: chatId, message: messageRequest('warmup'), timeout: 30);

      final times = <int>[];
      for (var b = 0; b < batches; b++) {
        final stopwatch = Stopwatch()..start();
        for (var i = 0; i < perBatch; i++) {
          await service.sendMessage(
              chatId: chatId, message: messageRequest('s$b-$i'), timeout: 30);
        }
        times.add(stopwatch.elapsedMilliseconds);
      }

      final label = legacy ? 'LEGACY' : 'NEW   ';
      // ignore: avoid_print
      print('BENCH session $label batchMs=$times '
          'degradation=${(times.last / times.first).toStringAsFixed(2)}x '
          'connections=${server.connectCount}');

      expect(server.sentRequests.length, batches * perBatch + 1,
          reason: 'sequential sends must not duplicate in either stack');
    }

    test('legacy', () async => run(legacy: true),
        timeout: const Timeout(Duration(minutes: 3)));
    test('new', () async => run(legacy: false),
        timeout: const Timeout(Duration(minutes: 3)));
  });

  group('scenario C — cold start, 8 concurrent sends', () {
    Future<void> run({required bool legacy}) async {
      final (server, service) = await buildStack(legacy: legacy);
      const burst = 8;

      final stopwatch = Stopwatch()..start();
      final results = await Future.wait([
        for (var i = 0; i < burst; i++)
          service.sendMessage(
              chatId: chatId, message: messageRequest('burst-$i'), timeout: 30),
      ]);
      stopwatch.stop();

      final failed = results.where((r) => r.error != null).length;
      final total = server.sentRequests.length;
      final label = legacy ? 'LEGACY' : 'NEW   ';
      // ignore: avoid_print
      print('BENCH burst   $label connections=${server.connectCount} '
          'wireRequests=$total duplicates=${total - burst} '
          'failed=$failed elapsedMs=${stopwatch.elapsedMilliseconds}');

      if (!legacy) {
        expect(server.connectCount, 1,
            reason: 'a cold burst must share a single connection');
        expect(total, burst);
        expect(failed, 0);
      }
    }

    test('legacy', () async => run(legacy: true),
        timeout: const Timeout(Duration(minutes: 2)));
    test('new', () async => run(legacy: false));
  });
}
