import 'dart:async';

import 'package:fixnum/fixnum.dart';
import 'package:grpc/grpc.dart';
import 'package:protobuf/well_known_types/google/protobuf/any.pb.dart';
import 'package:webitel_portal_sdk/src/data/grpc/grpc_channel.dart';
import 'package:webitel_portal_sdk/src/generated/chat/messages/chat.pb.dart'
    as chatpb;
import 'package:webitel_portal_sdk/src/generated/chat/messages/message.pb.dart'
    as msgpb;
import 'package:webitel_portal_sdk/src/generated/portal/connect.pb.dart'
    as portal;
import 'package:webitel_portal_sdk/src/generated/portal/customer.pbgrpc.dart';
import 'package:webitel_portal_sdk/src/generated/portal/messages.pb.dart'
    as pmsg;

typedef RequestHandler = void Function(
  portal.Request request,
  FakeConnection connection,
);

/// One accepted Connect call: logs incoming requests and lets the test push
/// updates or errors back to the client.
class FakeConnection {
  FakeConnection(Stream<portal.Request> requests, RequestHandler onRequest) {
    _requestSubscription = requests.listen(
      (request) {
        requestLog.add(request);
        onRequest(request, this);
      },
      onDone: () => clientClosedRequests = true,
    );
  }

  final List<portal.Request> requestLog = [];
  final StreamController<portal.Update> updates =
      StreamController<portal.Update>();
  final Completer<Map<String, String>> _headers =
      Completer<Map<String, String>>();
  late final StreamSubscription<portal.Request> _requestSubscription;
  bool clientClosedRequests = false;
  bool cancelled = false;

  Future<Map<String, String>> get headers => _headers.future;

  /// Marks the stream as accepted by the server: initial HTTP/2 metadata is
  /// sent to the client. Real servers do this explicitly (SendHeader) or
  /// implicitly together with their first message.
  void acceptStream() {
    if (!_headers.isCompleted) _headers.complete(const {});
  }

  void push(portal.Update update) {
    acceptStream();
    if (!updates.isClosed) updates.add(update);
  }

  void fail(Object error) {
    if (!updates.isClosed) updates.addError(error);
  }

  Future<void> _cancel() async {
    cancelled = true;
    await _requestSubscription.cancel();
  }
}

/// In-memory stand-in for the portal backend behind Customer/Connect.
/// Replies to pings automatically (connection verification round-trip);
/// everything else is routed to [onRequest].
class FakePortalServer {
  static const pingPath = '/webitel.portal.Customer/Ping';

  final List<FakeConnection> connections = [];
  RequestHandler? onRequest;
  void Function(FakeConnection connection)? onConnect;
  bool replyToPing = true;

  int get connectCount => connections.length;
  FakeConnection get current => connections.last;

  /// All non-ping requests across every connection ever opened.
  List<portal.Request> get sentRequests => [
        for (final connection in connections)
          ...connection.requestLog.where((r) => r.path != pingPath),
      ];

  ResponseStream<portal.Update> connect(Stream<portal.Request> requests) {
    final connection = FakeConnection(requests, (request, conn) {
      if (request.path == pingPath) {
        if (replyToPing) conn.push(pingReply());
        return;
      }
      onRequest?.call(request, conn);
    });
    connections.add(connection);
    onConnect?.call(connection);
    return FakeResponseStream(connection.updates.stream,
        headers: connection.headers, onCancel: connection._cancel);
  }
}

class FakeResponseStream extends StreamView<portal.Update>
    implements ResponseStream<portal.Update> {
  FakeResponseStream(super.stream, {required this.headers, this.onCancel});

  final Future<void> Function()? onCancel;

  @override
  final Future<Map<String, String>> headers;

  @override
  Future<void> cancel() async => onCancel?.call();

  @override
  Future<Map<String, String>> get trailers async => {};

  @override
  ResponseFuture<portal.Update> get single =>
      throw UnsupportedError('not used in tests');
}

class FakeCustomerClient extends CustomerClient {
  FakeCustomerClient(this.server) : super(ClientChannel('localhost', port: 0));

  final FakePortalServer server;

  @override
  ResponseStream<portal.Update> connect(
    Stream<portal.Request> request, {
    CallOptions? options,
  }) =>
      server.connect(request);
}

class TestGrpcChannel extends GrpcChannel {
  TestGrpcChannel(FakePortalServer server)
      : _client = FakeCustomerClient(server);

  final FakeCustomerClient _client;

  @override
  CustomerClient get customerStub => _client;

  @override
  Future<void> setAccessToken(String accessToken) async {}
}

// ---------------------------------------------------------------------------
// Update builders
// ---------------------------------------------------------------------------

portal.Update pingReply() => portal.Update(
      data: Any.pack(portal.Response(id: 'ping')),
    );

/// A message pushed by the server outside of any request/response pair.
portal.Update pushedMessage({
  required int messageId,
  required String chatId,
  String text = 'incoming',
  String requestId = '',
}) =>
    portal.Update(
      data: Any.pack(
        pmsg.UpdateNewMessage(
          id: requestId,
          message: msgpb.Message(
            id: Int64(messageId),
            text: text,
            chat: chatpb.Chat(id: chatId),
            date: Int64(1752451200000),
          ),
        ),
      ),
    );

/// The server's ack for a sent message: a Response envelope with the client's
/// request id, wrapping the created message.
portal.Update sendAck({
  required String requestId,
  required int messageId,
  required String chatId,
  String text = 'ack',
}) =>
    portal.Update(
      data: Any.pack(
        portal.Response(
          id: requestId,
          data: Any.pack(
            pmsg.UpdateNewMessage(
              id: requestId,
              message: msgpb.Message(
                id: Int64(messageId),
                text: text,
                chat: chatpb.Chat(id: chatId),
                date: Int64(1752451200000),
              ),
            ),
          ),
        ),
      ),
    );

portal.Update disconnectUpdate() => portal.Update(
      data: Any.pack(portal.UpdateDisconnect()),
    );

portal.Update chatCompleteUpdate() => portal.Update(
      data: Any.pack(pmsg.UpdateChatComplete()),
    );

portal.Request testRequest(String id, {String path = '/test/Echo'}) =>
    portal.Request(id: id, path: path);
