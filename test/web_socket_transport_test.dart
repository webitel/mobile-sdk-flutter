import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:fixnum/fixnum.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:grpc/grpc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webitel_portal_sdk/src/data/constants/constants.dart';
import 'package:webitel_portal_sdk/src/data/grpc/grpc_channel.dart';
import 'package:webitel_portal_sdk/src/data/grpc/grpc_connect.dart';
import 'package:webitel_portal_sdk/src/data/service_impl/chat_service_impl.dart';
import 'package:webitel_portal_sdk/src/data/shared_preferences/shared_preferences_gateway.dart';
import 'package:webitel_portal_sdk/src/data/wss/proto_json.dart';
import 'package:webitel_portal_sdk/src/domain/entities/connect.dart';
import 'package:webitel_portal_sdk/src/domain/services/chat_service.dart';
import 'package:webitel_portal_sdk/src/generated/portal/account.pb.dart';
import 'package:webitel_portal_sdk/src/generated/portal/auth.pb.dart';
import 'package:webitel_portal_sdk/src/generated/portal/connect.pb.dart'
    as portal;
import 'package:webitel_portal_sdk/src/generated/portal/customer.pb.dart';
import 'package:webitel_portal_sdk/src/generated/portal/media.pb.dart';
import 'package:webitel_portal_sdk/src/generated/portal/messages.pb.dart'
    as pmsg;
import 'package:webitel_portal_sdk/src/generated/portal/push.pb.dart';
import 'package:webitel_portal_sdk/src/injection/injection.dart';
import 'package:webitel_portal_sdk/webitel_portal_sdk.dart';

import 'support/fake_ws_portal.dart';
import 'support/fakes.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const chatId = 'chat-1';
  const appToken = 'test-token-app';
  const deviceId = 'test-device-1';
  const accessToken = 'test-token-access';

  late FakeWsPortal server;
  late GrpcChannel channel;
  late GrpcConnect connect;
  late ChatServiceImpl chatService;

  setUp(() async {
    // flutter_test mocks every HttpClient with 400 responses; these tests
    // talk to a real loopback server.
    HttpOverrides.global = null;

    SharedPreferences.setMockInitialValues({'userId': 'user-1'});
    server = FakeWsPortal();
    await server.start();

    final gateway = SharedPreferencesGateway();
    await gateway.init();

    channel = GrpcChannel();
    await channel.init(
      url: InternetAddress.loopbackIPv4.address,
      appToken: appToken,
      deviceId: deviceId,
      userAgent: 'test-agent',
      port: server.port,
      secure: false,
      transport: PortalTransport.websocket,
    );
    await channel.setAccessToken(accessToken);

    connect = GrpcConnect(gateway, channel);
    chatService = ChatServiceImpl(channel, connect, gateway);
  });

  tearDown(() async {
    // Shutting the channel down closes the live socket; GrpcConnect stays
    // undisposed like in the app, where it lives for the whole process.
    await channel.init(
      url: InternetAddress.loopbackIPv4.address,
      appToken: appToken,
      deviceId: deviceId,
      userAgent: 'test-agent',
      port: server.port,
      secure: false,
    );
    await server.stop();
  });

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

  DialogMessageRequest messageRequest(String requestId) => DialogMessageRequest(
        requestId: requestId,
        content: 'hello',
        uploadFile: UploadFile(id: '', name: '', type: ''),
      );

  group('Connect stream over WebSocket', () {
    test('sendMessage goes over the socket with portal headers and gets the ack',
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
      expect(wire.path, Constants.sendMessagePath);
      expect(wire.data.unpackInto(pmsg.SendMessageRequest()).id, 'req-1');

      final headers = server.current.headers;
      expect(headers.value('x-portal-client'), appToken);
      expect(headers.value('x-portal-device'), deviceId);
      expect(headers.value('x-portal-access'), accessToken);
      expect(headers.value(HttpHeaders.userAgentHeader), 'test-agent');
    });

    test('concurrent sends share one socket and each request is sent once',
        () async {
      await Future.wait([
        connect.sendRequest(testRequest('r1')),
        connect.sendRequest(testRequest('r2')),
        connect.sendRequest(testRequest('r3')),
      ]);
      await _settle();

      expect(server.connectCount, 1);
      expect(server.sentRequests.map((r) => r.id).toList()..sort(),
          ['r1', 'r2', 'r3']);
    });

    test('pushed messages reach the update stream', () async {
      final updates = <pmsg.UpdateNewMessage>[];
      final subscription = connect.updateStream.listen(updates.add);

      await connect.sendRequest(testRequest('r1'));
      server.current.push(pushedMessage(messageId: 42, chatId: chatId));
      await _settle();

      expect(updates.single.message.id.toInt(), 42);
      await subscription.cancel();
    });

    test('an abnormal server close is reported and the next send reconnects',
        () async {
      final statuses = <Connect>[];
      final errors = <CallError>[];
      final channelStates = <ChannelStatus>[];
      final s1 = connect.connectStatusStream.stream.listen(statuses.add);
      final s2 = connect.errorStream.stream.listen(errors.add);
      final s3 = connect.chanelStatusStream.stream.listen(channelStates.add);

      await connect.sendRequest(testRequest('r1'));
      await server.current.close(WebSocketStatus.internalServerError, 'boom');
      await _settle();

      expect(statuses.map((s) => s.status),
          [ConnectStatus.opened, ConnectStatus.closed]);
      expect(errors, isNotEmpty);
      expect(channelStates, contains(ChannelStatus.transientFailure));
      expect(connect.connectClosed, isTrue);

      await connect.sendRequest(testRequest('r2'));
      await _settle();
      expect(server.connectCount, 2);
      expect(server.current.requestLog.map((r) => r.id), contains('r2'));

      await s1.cancel();
      await s2.cancel();
      await s3.cancel();
    });

    test('a disconnect update closes the socket and the next send reconnects',
        () async {
      await connect.sendRequest(testRequest('r1'));
      server.current.push(disconnectUpdate());
      await _settle();

      expect(connect.connectClosed, isTrue);

      await connect.sendRequest(testRequest('r2'));
      await _settle();
      expect(server.connectCount, 2);
    });

    test('reconnect closes the previous socket before opening a new one',
        () async {
      await connect.sendRequest(testRequest('r1'));
      final first = server.current;

      await connect.reconnect();
      await _settle();

      expect(server.connectCount, 2);
      expect(first.socket.closeCode, isNotNull,
          reason: 'the old socket must be closed on reconnect');
    });

    test('a rejected upgrade fails the send with the mapped gRPC code',
        () async {
      server.rejectUpgradeWith = HttpStatus.unauthorized;

      await expectLater(
        connect.sendRequest(testRequest('r1')),
        throwsA(isA<GrpcError>()
            .having((e) => e.code, 'code', StatusCode.unauthenticated)),
      );
    });

    test('ping round-trips through the open socket', () async {
      await connect.sendRequest(testRequest('r1'));

      expect(await chatService.ping(), 'Client ping');
    });

    test('ping without an open socket reports unavailable', () async {
      expect(await chatService.ping(), startsWith('GRPC Error'));
    });
  });

  group('REST calls', () {
    test('token posts the request as proto JSON and parses the access token',
        () async {
      server.routes['POST /api/portal/token'] = (request, body) async {
        request.response
          ..headers.contentType = ContentType.json
          ..write(jsonEncode({
            'access_token': 'test-token-issued',
            'expires_in': '3600',
            'chat': {
              'user': {'id': 'user-42', 'name': 'Test User'}
            },
          }));
        await request.response.close();
      };

      final token = await channel.customerStub.token(TokenRequest(
        grantType: 'identity',
        appToken: appToken,
        identity: Identity(sub: 'sub-1', iss: 'https://example.com', name: 'A'),
      ));

      expect(token.accessToken, 'test-token-issued');
      expect(token.expiresIn.toInt(), 3600);
      expect(token.chat.user.id, 'user-42');

      final call = server.httpCalls.single;
      expect(call.headers.value('x-portal-client'), appToken);
      final sent = ProtoJson.decode(call.text, TokenRequest());
      expect(sent.identity.sub, 'sub-1');
      expect(sent.grantType, 'identity');
    });

    test('inspect carries the access token set on the channel', () async {
      server.routes['GET /api/portal/token'] = (request, body) async {
        request.response.write('{"accessToken":"$accessToken"}');
        await request.response.close();
      };

      await channel.setAccessToken('test-token-rotated');
      await channel.customerStub.inspect(InspectRequest());

      expect(server.httpCalls.single.headers.value('x-portal-access'),
          'test-token-rotated');
    });

    test('registerDevice posts the push token', () async {
      server.routes['POST /api/portal/device'] = (request, body) async {
        request.response.write('{}');
        await request.response.close();
      };

      await channel.customerStub.registerDevice(
        RegisterDeviceRequest(push: DevicePush(fCM: 'test-token-fcm')),
      );

      final sent = ProtoJson.decode(
          server.httpCalls.single.text, RegisterDeviceRequest());
      expect(sent.push.fCM, 'test-token-fcm');
    });

    test('an HTTP error becomes a GrpcError with the mapped code', () async {
      server.routes['GET /api/portal/token'] = (request, body) async {
        request.response
          ..statusCode = HttpStatus.unauthorized
          ..write('{"code":16,"message":"token expired"}');
        await request.response.close();
      };

      await expectLater(
        channel.customerStub.inspect(InspectRequest()),
        throwsA(isA<GrpcError>()
            .having((e) => e.code, 'code', StatusCode.unauthenticated)
            .having((e) => e.message, 'message', contains('token expired'))),
      );
    });
  });

  group('Files over HTTP', () {
    late Directory tmp;

    setUp(() async {
      tmp = await Directory.systemTemp.createTemp('ws_transport_test');
      // Upload/Download handles resolve the chat service through GetIt.
      getIt.allowReassignment = true;
      getIt.registerSingleton<ChatService>(chatService);
    });

    tearDown(() async {
      await tmp.delete(recursive: true);
    });

    test('uploadFile creates the upload, PUTs the content and reports the file',
        () async {
      final content = List<int>.generate(5000, (i) => i % 251);
      final file = File('${tmp.path}/image.png')..writeAsBytesSync(content);
      final stored = <int>[];

      server.routes['POST /portal/files'] = (request, body) async {
        request.response.write('{"upload_id":"up-1"}');
        await request.response.close();
      };
      server.routes['PUT /portal/files'] = (request, body) async {
        stored.addAll(body);
        request.response.write(jsonEncode({
          'file_id': 'file-1',
          'name': 'image.png',
          'mime_type': 'image/png',
          'size': body.length,
          'hash': 'abc',
        }));
        await request.response.close();
      };

      final upload = chatService.uploadFile(
        mediaType: 'image/png',
        mediaName: 'image.png',
        file: file,
      );
      final events = await upload.onProgress.stream.toList();

      expect(stored, content);
      expect(events.last.id, 'file-1');
      expect(events.last.size, content.length);
      expect(events.where((e) => e.progress?.progressId == 'up-1'), isNotEmpty);

      final create = server.httpCalls.first;
      expect(jsonDecode(create.text),
          {'mime_type': 'image/png', 'name': 'image.png'});
      final put = server.httpCalls.last;
      expect(put.uri.queryParameters['uploadId'], 'up-1');
      expect(put.headers.contentType?.mimeType, 'image/png');
    });

    test('getFile sends Range from the offset and streams metadata then data',
        () async {
      final content = List<int>.generate(1000, (i) => i % 256);
      server.routes['GET /portal/files/file-1'] = (request, body) async {
        final range = request.headers.value(HttpHeaders.rangeHeader)!;
        final start = int.parse(range.split('=').last.split('-').first);
        request.response
          ..statusCode = HttpStatus.partialContent
          ..headers.contentType = ContentType('image', 'png')
          ..headers.set(HttpHeaders.contentRangeHeader,
              'bytes $start-${content.length - 1}/${content.length}')
          ..headers.set('content-disposition', 'attachment; filename="a.png"')
          ..add(content.sublist(start));
        await request.response.close();
      };

      final events = await channel.mediaStorageStub
          .getFile(GetFileRequest(fileId: 'file-1', offset: Int64(400)))
          .toList();

      expect(events.first.file.size.toInt(), 1000);
      expect(events.first.file.name, 'a.png');
      expect(events.first.file.type, 'image/png');
      expect(events.skip(1).expand((e) => e.data).toList(),
          content.sublist(400));
      expect(server.httpCalls.single.headers.value(HttpHeaders.rangeHeader),
          'bytes=400-');
    });

    test('getFile skips the prefix when the server ignores Range', () async {
      final content = List<int>.generate(1000, (i) => i % 256);
      server.routes['GET /portal/files/file-1'] = (request, body) async {
        request.response.add(content);
        await request.response.close();
      };

      final events = await channel.mediaStorageStub
          .getFile(GetFileRequest(fileId: 'file-1', offset: Int64(400)))
          .toList();

      expect(events.skip(1).expand((e) => e.data).toList(),
          content.sublist(400));
    });

    // Serves [content] honouring `Range: bytes=<start>-`.
    void serveFile(List<int> content) {
      server.routes['GET /portal/files/file-1'] = (request, body) async {
        final range = request.headers.value(HttpHeaders.rangeHeader);
        final start =
            range == null ? 0 : int.parse(range.split('=').last.split('-').first);
        request.response
          ..statusCode =
              start > 0 ? HttpStatus.partialContent : HttpStatus.ok
          ..headers.contentType = ContentType('image', 'png')
          ..headers.set(HttpHeaders.contentRangeHeader,
              'bytes $start-${content.length - 1}/${content.length}')
          ..add(content.sublist(start));
        await request.response.close();
      };
    }

    test('the file is complete on disk as soon as onData is done', () async {
      final content = List<int>.generate(300000, (i) => i % 256);
      serveFile(content);
      final savePath = '${tmp.path}/out.png';

      final download =
          chatService.downloadFile(fileId: 'file-1', savePath: savePath);
      await download.onData.stream.drain<void>();

      expect(File(savePath).readAsBytesSync(), content,
          reason: 'onData used to close before the file sink was flushed');
    });

    test('a download resumed from an offset appends to the saved bytes',
        () async {
      final content = List<int>.generate(1000, (i) => i % 256);
      serveFile(content);
      final savePath = '${tmp.path}/out.png';
      File(savePath).writeAsBytesSync(content.sublist(0, 400));

      final download = chatService.downloadFile(
          fileId: 'file-1', savePath: savePath, offset: 400);
      await download.onData.stream.drain<void>();

      expect(File(savePath).readAsBytesSync(), content,
          reason: 'resume used to truncate the bytes saved before');
      expect(download.offset, 1000);
    });

    test('an interrupted download continues from the received offset',
        () async {
      final content = List<int>.generate(1000, (i) => i % 256);
      var calls = 0;
      server.routes['GET /portal/files/file-1'] = (request, body) async {
        calls++;
        if (calls == 1) {
          // Promise the whole file, send half, drop the connection.
          request.response
            ..contentLength = content.length
            ..headers.set(HttpHeaders.contentRangeHeader,
                'bytes 0-${content.length - 1}/${content.length}');
          final socket = await request.response.detachSocket();
          socket.add(content.sublist(0, 500));
          await socket.flush();
          socket.destroy();
          return;
        }
        final range = request.headers.value(HttpHeaders.rangeHeader)!;
        final start = int.parse(range.split('=').last.split('-').first);
        request.response
          ..statusCode = HttpStatus.partialContent
          ..headers.set(HttpHeaders.contentRangeHeader,
              'bytes $start-${content.length - 1}/${content.length}')
          ..add(content.sublist(start));
        await request.response.close();
      };
      final savePath = '${tmp.path}/out.png';

      final download =
          chatService.downloadFile(fileId: 'file-1', savePath: savePath);
      await download.onData.stream.drain<void>();

      expect(calls, 2);
      expect(server.httpCalls.last.headers.value(HttpHeaders.rangeHeader),
          'bytes=500-');
      expect(File(savePath).readAsBytesSync(), content);
    });

    test('pause flushes the received bytes and resume appends the rest',
        () async {
      final content = List<int>.generate(1000, (i) => i % 256);
      final release = Completer<void>();
      server.routes['GET /portal/files/file-1'] = (request, body) async {
        final range = request.headers.value(HttpHeaders.rangeHeader);
        if (range == null) {
          // First request: half the file, then hold the connection open.
          request.response.contentLength = content.length;
          final socket = await request.response.detachSocket();
          socket.add(content.sublist(0, 500));
          await socket.flush();
          await release.future;
          socket.destroy();
          return;
        }
        final start = int.parse(range.split('=').last.split('-').first);
        request.response
          ..statusCode = HttpStatus.partialContent
          ..headers.set(HttpHeaders.contentRangeHeader,
              'bytes $start-${content.length - 1}/${content.length}')
          ..add(content.sublist(start));
        await request.response.close();
      };
      final savePath = '${tmp.path}/out.png';

      final download =
          chatService.downloadFile(fileId: 'file-1', savePath: savePath);
      final done = download.onData.stream.drain<void>();
      while (download.offset < 500) {
        await Future<void>.delayed(const Duration(milliseconds: 10));
      }

      await download.pause();
      expect(File(savePath).readAsBytesSync(), content.sublist(0, 500));

      await download.resume();
      await done;
      release.complete();

      expect(File(savePath).readAsBytesSync(), content);
    });

    test('cancel stops the active upload and the queue moves on', () async {
      final file = File('${tmp.path}/a.png')..writeAsBytesSync([1, 2, 3]);
      final hold = Completer<void>();
      var created = 0;
      server.routes['POST /portal/files'] = (request, body) async {
        created++;
        request.response.write('{"upload_id":"up-$created"}');
        await request.response.close();
      };
      server.routes['PUT /portal/files'] = (request, body) async {
        if (request.uri.queryParameters['uploadId'] == 'up-1') {
          await hold.future; // the first upload never finishes by itself
        }
        request.response.write(jsonEncode({
          'file_id': 'file-${request.uri.queryParameters['uploadId']}',
          'name': 'a.png',
          'mime_type': 'image/png',
          'size': body.length,
        }));
        try {
          await request.response.close();
        } on Object {
          // The client aborted.
        }
      };

      final first = chatService.uploadFile(
          mediaType: 'image/png', mediaName: 'a.png', file: file);
      final skipped = chatService.uploadFile(
          mediaType: 'image/png', mediaName: 'a.png', file: file);
      final last = chatService.uploadFile(
          mediaType: 'image/png', mediaName: 'a.png', file: file);
      final firstEvents = first.onProgress.stream.toList();
      final lastEvents = last.onProgress.stream.toList();

      while (created < 1) {
        await Future<void>.delayed(const Duration(milliseconds: 10));
      }
      await skipped.cancel(); // still queued: must never reach the server
      await first.cancel(); // active: must free the queue

      final events = await lastEvents.timeout(const Duration(seconds: 5));
      expect(events.last.id, 'file-up-2',
          reason: 'the cancelled queued upload must not be sent');
      expect(created, 2);
      await firstEvents.timeout(const Duration(seconds: 5));
      hold.complete();
    });
  });

  group('ProtoJson', () {
    test('decodes Go protojson updates with nested Any and int64 strings', () {
      const json = '''
{"data":{"@type":"type.googleapis.com/webitel.portal.Response","id":"r1",
 "data":{"@type":"type.googleapis.com/webitel.portal.UpdateNewMessage","id":"r1",
  "message":{"id":"9007199254740993","text":"hi","chat":{"id":"chat-1"}}}}}''';

      final update = ProtoJson.decode(json, portal.Update());
      final response = update.data.unpackInto(portal.Response());
      final message = response.data.unpackInto(pmsg.UpdateNewMessage());

      expect(response.id, 'r1');
      expect(message.message.id, Int64.parseInt('9007199254740993'));
      expect(message.message.chat.id, 'chat-1');
    });

    test('drops Any values of unknown types instead of failing', () {
      const json = '''
{"data":{"@type":"type.googleapis.com/webitel.portal.Response","id":"r2",
 "err":{"code":16,"message":"denied",
  "details":[{"@type":"type.googleapis.com/google.rpc.ErrorInfo","reason":"X"}]}}}''';

      final response = ProtoJson.decode(json, portal.Update())
          .data
          .unpackInto(portal.Response());

      expect(response.err.code, 16);
      expect(response.err.message, 'denied');
      expect(response.err.details, isEmpty);
    });
  });
}

Future<void> _settle() =>
    Future<void>.delayed(const Duration(milliseconds: 100));
