// Live smoke run of the public SDK surface against a real portal, over the
// transport given by WEBITEL_SMOKE_TRANSPORT (`grpc` or `websocket`).
//
// Skipped unless the environment is configured, so `flutter test` stays green
// without network access:
//
//   WEBITEL_STRESS_URL='grpcs://host' \
//   WEBITEL_STRESS_TOKEN='...' \
//   WEBITEL_STRESS_ISSUER='https://host/portal' \
//   WEBITEL_SMOKE_TRANSPORT=websocket \
//   flutter test test/live_transport_smoke_test.dart
//
// One transport per run: initClient configures process-wide singletons.
import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:webitel_portal_sdk/webitel_portal_sdk.dart';

// ignore: avoid_print
void _log(String line) => print('SMOKE $line');

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final url = Platform.environment['WEBITEL_STRESS_URL'];
  final token = Platform.environment['WEBITEL_STRESS_TOKEN'];
  final issuer = Platform.environment['WEBITEL_STRESS_ISSUER'];
  final transport = Platform.environment['WEBITEL_SMOKE_TRANSPORT'] == 'grpc'
      ? PortalTransport.grpc
      : PortalTransport.websocket;

  test(
    'live smoke run over ${transport.name}',
    () async {
      if (url == null || token == null || issuer == null) {
        markTestSkipped('WEBITEL_STRESS_* environment is not configured');
        return;
      }

      // flutter_test mocks HttpClient; the WebSocket transport needs a real one.
      HttpOverrides.global = null;
      SharedPreferences.setMockInitialValues({});
      PackageInfo.setMockInitialValues(
        appName: 'sdk-smoke',
        packageName: 'com.webitel.sdk.smoke',
        version: '1.0.0',
        buildNumber: '1',
        buildSignature: '',
      );

      const uuid = Uuid();
      final runId = uuid.v4().substring(0, 8);
      _log('transport=${transport.name} url=$url run=$runId');

      final client = await WebitelPortalSdk.instance.initClient(
        url: url,
        appToken: token,
        loggerLevel: LoggerLevel.error,
        transport: transport,
      );
      expect(client.error, isNull,
          reason: 'initClient failed: ${client.error?.errorMessage}');

      final channel = await client.getChannel();
      final connectEvents = <String>[];
      channel.onConnectStreamStatusChange
          .listen((c) => connectEvents.add(c.status.name));

      final login = await client.login(
        name: 'SDK Smoke $runId',
        sub: 'sdk-smoke-$runId',
        issuer: issuer,
        email: 'sdk-smoke-$runId@example.com',
        emailVerified: true,
        phoneNumber: '+380000000000',
        phoneNumberVerified: true,
      );
      _log('login -> ${login.status.name} ${login.message ?? ''}');
      expect(login.status, PortalResponseStatus.success);

      final user = await client.getUser();
      _log('getUser -> id=${user.id} name=${user.name} sub=${user.sub} '
          'issuer=${user.issuer} error=${user.error?.errorMessage}');
      expect(user.error, isNull);

      final dialog = await client.chat.fetchServiceDialog();
      _log('fetchServiceDialog -> id=${dialog.id} closed=${dialog.isClosed} '
          'error=${dialog.error?.errorMessage}');
      expect(dialog.error, isNull);

      final incoming = <DialogMessageResponse>[];
      dialog.onNewMessage.listen(incoming.add);

      final text = 'smoke:${transport.name}:$runId';
      final requestId = uuid.v4();
      final sent = await dialog.sendMessage(content: text, requestId: requestId);
      _log('sendMessage(requestId=$requestId, "$text") -> '
          'messageId=${sent.messageId} chatId=${sent.chatId} '
          'content="${sent.dialogMessageContent}" '
          'error=${sent.error?.errorMessage}');
      expect(sent.error, isNull);
      expect(sent.messageId, isNot(0));

      final history = await dialog.fetchMessages(limit: 10);
      _log('fetchMessages(limit: 10) -> ${history.length} messages, '
          'first error=${history.firstOrNull?.error?.errorMessage}');
      expect(history.map((m) => m.messageId), contains(sent.messageId));

      final pong = await client.ping();
      _log('ping -> "$pong"');

      await channel.reconnectToStream();
      final afterReconnect = await dialog.sendMessage(
        content: '$text:after-reconnect',
        requestId: uuid.v4(),
      );
      _log('sendMessage after reconnectToStream -> '
          'messageId=${afterReconnect.messageId} '
          'error=${afterReconnect.error?.errorMessage}');
      // Not asserted: test.webitel.me rejects every message after the first
      // one of a fresh user with 500 "user_contact NULL" over both transports.
      // The send must still resolve with a server response, not a timeout.
      expect(afterReconnect.error?.errorMessage ?? '',
          isNot(contains('timeout')));

      // File round-trip: upload, send as media, download back.
      final dir = await Directory.systemTemp.createTemp('sdk_smoke');
      // A real image: portals restrict uploads by MIME type and content.
      final content = base64Decode(_png1x1);
      final file = File('${dir.path}/smoke-$runId.png')
        ..writeAsBytesSync(content);

      final upload = dialog.uploadFile(
        file: file,
        mediaName: 'smoke-$runId.png',
        mediaType: 'image/png',
      );
      final events = await upload.onProgress.stream.toList();
      final stored = events.last;
      _log('uploadFile -> ${events.length} events, '
          'file id=${stored.id} size=${stored.size} type=${stored.type}');
      expect(stored.id, isNotEmpty);
      expect(stored.size, content.length);

      final media = await dialog.sendMessage(
        content: 'smoke file $runId',
        requestId: uuid.v4(),
        uploadFile:
            UploadFile(id: stored.id!, name: stored.name!, type: stored.type!),
      );
      _log('sendMessage(media) -> messageId=${media.messageId} '
          'file=${media.file.id}/${media.file.name}/${media.file.size} '
          'error=${media.error?.errorMessage}');
      // Not asserted: delivery of media messages depends on the chat backend
      // (test.webitel.me answers 500 "user_contact NULL" over both
      // transports); the transfer itself is verified by the download below.

      final savePath = '${dir.path}/downloaded.bin';
      final download =
          dialog.downloadFile(fileId: stored.id!, savePath: savePath);
      final chunks = await download.onData.stream.toList();
      final downloaded = File(savePath).readAsBytesSync();
      _log('downloadFile events=${chunks.length} '
          'reported size=${chunks.lastOrNull?.size} offset=${download.offset}');
      _log('downloadFile -> ${downloaded.length} bytes, '
          'identical=${_same(downloaded, content)}');
      expect(_same(downloaded, content), isTrue);

      await Future<void>.delayed(const Duration(seconds: 2));
      _log('onNewMessage received ${incoming.length} pushed messages: '
          '${incoming.map((m) => '${m.messageId}:"${m.dialogMessageContent}"').join(', ')}');
      _log('connect status events: ${connectEvents.join(' -> ')}');

      await dir.delete(recursive: true);
    },
    timeout: const Timeout(Duration(minutes: 3)),
  );
}

const _png1x1 = 'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mNk'
    'YPhfDwAChwGA60e6kgAAAABJRU5ErkJggg==';

bool _same(List<int> a, List<int> b) {
  if (a.length != b.length) return false;
  for (var i = 0; i < a.length; i++) {
    if (a[i] != b[i]) return false;
  }
  return true;
}
