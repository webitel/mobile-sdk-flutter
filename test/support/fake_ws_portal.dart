import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:protobuf/well_known_types/google/protobuf/any.pb.dart';
import 'package:webitel_portal_sdk/src/data/wss/proto_json.dart';
import 'package:webitel_portal_sdk/src/generated/portal/connect.pb.dart'
    as portal;

typedef WsRequestHandler = void Function(
  portal.Request request,
  FakeWsConnection connection,
);

typedef HttpHandler = Future<void> Function(
  HttpRequest request,
  List<int> body,
);

/// One accepted `/portal/ws` connection.
class FakeWsConnection {
  FakeWsConnection(this.socket, this.headers);

  final WebSocket socket;
  final HttpHeaders headers;
  final List<portal.Request> requestLog = [];

  void push(portal.Update update) => pushRaw(ProtoJson.encode(update));

  void pushRaw(String json) {
    try {
      socket.add(json);
    } on StateError {
      // The socket is already closing; late replies are dropped.
    }
  }

  Future<void> close(int code, [String reason = '']) =>
      socket.close(code, reason);
}

/// One recorded REST / file request.
class FakeHttpCall {
  FakeHttpCall(this.method, this.uri, this.headers, this.body);

  final String method;
  final Uri uri;
  final HttpHeaders headers;
  final List<int> body;

  String get text => utf8.decode(body);
}

/// In-process portal speaking the WebSocket + REST protocol on loopback.
///
/// Requests on the socket are JSON `Connect.Request`s; anything that is not
/// a ping is routed to [onRequest]. Other paths are routed to [routes] by
/// `"<METHOD> <path>"` key.
class FakeWsPortal {
  late final HttpServer _server;

  final List<FakeWsConnection> connections = [];
  final List<FakeHttpCall> httpCalls = [];
  final Map<String, HttpHandler> routes = {};

  WsRequestHandler? onRequest;

  /// When set, the WebSocket upgrade is refused with this HTTP status.
  int? rejectUpgradeWith;

  int get port => _server.port;
  int get connectCount => connections.length;
  FakeWsConnection get current => connections.last;

  List<portal.Request> get sentRequests => [
        for (final connection in connections)
          ...connection.requestLog
              .where((r) => r.path != '/webitel.portal.Customer/Ping'),
      ];

  Future<void> start() async {
    _server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
    _server.listen(_handle);
  }

  Future<void> stop() => _server.close(force: true);

  Future<void> _handle(HttpRequest request) async {
    if (request.uri.path == '/portal/ws') {
      final reject = rejectUpgradeWith;
      if (reject != null) {
        request.response
          ..statusCode = reject
          ..write('{"code":$reject,"message":"rejected"}');
        await request.response.close();
        return;
      }

      final socket = await WebSocketTransformer.upgrade(request);
      final connection = FakeWsConnection(socket, request.headers);
      connections.add(connection);
      socket.listen((data) {
        final message = ProtoJson.decode(data as String, portal.Request());
        connection.requestLog.add(message);
        if (message.path == '/webitel.portal.Customer/Ping') {
          // The Connect stream ping carries no id; an id means a unary ping.
          connection.push(portal.Update(
            data: Any.pack(portal.Response(id: message.id, data: message.data)),
          ));
          return;
        }
        onRequest?.call(message, connection);
      });
      return;
    }

    final body = await request.fold<List<int>>([], (a, b) => a..addAll(b));
    httpCalls.add(
        FakeHttpCall(request.method, request.uri, request.headers, body));

    final route = routes['${request.method} ${request.uri.path}'];
    if (route == null) {
      request.response.statusCode = HttpStatus.notFound;
      await request.response.close();
      return;
    }
    await route(request, body);
  }
}
