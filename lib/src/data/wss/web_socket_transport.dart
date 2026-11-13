import 'dart:async';

import 'package:grpc/grpc.dart';
import 'package:protobuf/protobuf.dart';
import 'package:protobuf/well_known_types/google/protobuf/any.pb.dart';
import 'package:uuid/uuid.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as ws_status;
import 'package:webitel_portal_sdk/src/data/logger/logger.dart';
import 'package:webitel_portal_sdk/src/data/wss/error_code_mapper.dart';
import 'package:webitel_portal_sdk/src/data/wss/portal_http.dart';
import 'package:webitel_portal_sdk/src/data/wss/proto_json.dart';
import 'package:webitel_portal_sdk/src/data/wss/responses.dart';
import 'package:webitel_portal_sdk/src/generated/portal/connect.pb.dart'
    as portal;

/// Shared state of the WebSocket transport: the HTTP client, the live socket
/// and its connection state.
///
/// One instance lives per `GrpcChannel.init`. Stubs are rebuilt on every
/// access token change; the transport and its live socket survive that, the
/// same way a gRPC channel outlives its stubs.
final class WebSocketTransport {
  WebSocketTransport({
    required this.http,
    required this.wsUri,
    this.pingInterval = const Duration(seconds: 10),
    this.connectTimeout = const Duration(seconds: 15),
    this.pingTimeout = const Duration(seconds: 10),
  });

  /// Realtime endpoint of the portal.
  static const wsPath = '/portal/ws';

  static const pingPath = '/webitel.portal.Customer/Ping';

  final PortalHttp http;

  /// `wss://host[:port]/portal/ws`.
  final Uri wsUri;

  /// Interval of WebSocket ping frames; a missing pong closes the socket.
  final Duration pingInterval;
  final Duration connectTimeout;
  final Duration pingTimeout;

  final log = CustomLogger.getLogger('WebSocketTransport');

  final _state = StreamController<ConnectionState>.broadcast();

  late final WebSocketClientChannel clientChannel =
      WebSocketClientChannel(_state.stream);

  WebSocketSession? _active;

  /// Connection state of the socket, in gRPC terms.
  Stream<ConnectionState> get onConnectionStateChanged => _state.stream;

  /// Opens a socket that carries [requests] to the server and returns its
  /// updates — the WebSocket counterpart of the gRPC `Customer/Connect` call.
  ///
  /// The socket is opened when the returned stream is listened to and closed
  /// when the subscription is cancelled.
  ResponseStream<portal.Update> connect(
    Stream<portal.Request> requests,
    Map<String, String> headers,
  ) =>
      WebSocketSession(this, requests, headers).response;

  /// Round-trips [echo] through the open socket.
  Future<portal.Echo> ping(portal.Echo echo) async {
    final session = _active;
    if (session == null || !session.isOpen) {
      throw GrpcError.unavailable('WebSocket stream is not open');
    }
    return session.ping(echo);
  }

  /// Sends a REST request and decodes its JSON response into [response].
  Future<T> unary<T extends GeneratedMessage>(
    String method,
    String path,
    Map<String, String> headers,
    T response, {
    GeneratedMessage? body,
  }) async {
    final text = await http.sendJson(
      method,
      path,
      headers,
      body: body == null ? null : ProtoJson.encode(body),
    );
    try {
      return text.trim().isEmpty ? response : ProtoJson.decode(text, response);
    } catch (err) {
      throw ErrorCodeMapper.toGrpcError(err);
    }
  }

  /// Closes the live socket and releases the HTTP client.
  Future<void> shutdown() async {
    await _active?.close();
    _active = null;
    await _state.close();
    http.client.close(force: true);
  }

  void _emit(ConnectionState state) {
    log.info('WebSocket state changed: $state');
    if (!_state.isClosed) _state.add(state);
  }
}

/// One WebSocket connection, exposed as a gRPC [ResponseStream].
final class WebSocketSession {
  WebSocketSession(this._transport, this._requests, this._headers) {
    _updates = StreamController<portal.Update>(
      onListen: () => unawaited(_open()),
      onCancel: close,
    );
    response = StreamResponse(
      _updates.stream,
      headers: _opened.future..ignore(),
      onCancel: close,
    );
  }

  final WebSocketTransport _transport;
  final Stream<portal.Request> _requests;
  final Map<String, String> _headers;

  // Completes once the socket is open — the counterpart of the initial
  // HTTP/2 headers of a gRPC call.
  final _opened = Completer<Map<String, String>>();

  late final StreamController<portal.Update> _updates;
  late final StreamResponse<portal.Update> response;

  IOWebSocketChannel? _channel;
  StreamSubscription<dynamic>? _socketSubscription;
  StreamSubscription<portal.Request>? _requestSubscription;

  // Pending pings keyed by request id; their responses are consumed here
  // and never reach the update stream.
  final Map<String, Completer<portal.Echo>> _pings = {};

  bool _closed = false;

  bool get isOpen => _channel != null && !_closed;

  Future<void> _open() async {
    _transport._emit(ConnectionState.connecting);
    _transport.log.info('Opening WebSocket: ${_transport.wsUri}');

    final channel = IOWebSocketChannel.connect(
      _transport.wsUri,
      // The user agent is set on the HTTP client itself.
      headers: _headers,
      pingInterval: _transport.pingInterval,
      connectTimeout: _transport.connectTimeout,
      customClient: _transport.http.client,
    );

    try {
      await channel.ready;
    } catch (err) {
      _finish(ErrorCodeMapper.toGrpcError(err), ConnectionState.transientFailure);
      return;
    }

    if (_closed) {
      unawaited(channel.sink.close(ws_status.normalClosure));
      return;
    }

    _channel = channel;
    _transport._active = this;
    _opened.complete(const {});
    _transport._emit(ConnectionState.ready);

    _socketSubscription = channel.stream.listen(
      _onFrame,
      onError: (Object err) => _finish(
          ErrorCodeMapper.toGrpcError(err), ConnectionState.transientFailure),
      onDone: _onDone,
      cancelOnError: true,
    );
    _requestSubscription = _requests.listen(
      _send,
      // The client half-closed the call: nothing more will be sent.
      onDone: () => unawaited(close()),
    );
  }

  void _send(portal.Request request) {
    final channel = _channel;
    if (channel == null || _closed) return;
    try {
      channel.sink.add(ProtoJson.encode(request));
      _transport.log.info('Request sent over WebSocket: ${request.path}');
    } catch (err) {
      _finish(
        GrpcError.unavailable('Failed to write to WebSocket: $err'),
        ConnectionState.transientFailure,
      );
    }
  }

  void _onFrame(dynamic data) {
    final portal.Update update;
    try {
      update = data is String
          ? ProtoJson.decode(data, portal.Update())
          : portal.Update.fromBuffer(data as List<int>);
    } catch (err) {
      _transport.log.warning('Skipping undecodable WebSocket frame: $err');
      return;
    }

    if (_completePing(update)) return;
    if (!_updates.isClosed) _updates.add(update);
  }

  void _onDone() {
    final code = _channel?.closeCode;
    final reason = _channel?.closeReason ?? '';
    if (code == null || code == ws_status.normalClosure) {
      _finish(null, ConnectionState.idle);
    } else {
      _finish(
        GrpcError.custom(
          ErrorCodeMapper.fromCloseCode(code),
          'WebSocket closed: $code $reason',
        ),
        ConnectionState.transientFailure,
      );
    }
  }

  /// Ends the session after a server-side close or a failure: the error (if
  /// any) is delivered to the update stream before it is closed.
  void _finish(GrpcError? error, ConnectionState state) {
    if (_closed) return;
    _release(error ?? GrpcError.unavailable('WebSocket stream was closed'));

    if (error != null) {
      _transport.log.warning('WebSocket failed: ${error.message}');
      if (!_updates.isClosed) _updates.addError(error);
    }
    unawaited(_updates.close());
    _transport._emit(state);
  }

  /// Closes the session on the client's initiative.
  Future<void> close() async {
    if (_closed) return;
    _release(GrpcError.cancelled('WebSocket stream was closed by the client'));

    unawaited(_updates.close());
    _transport._emit(ConnectionState.idle);
  }

  void _release(GrpcError reason) {
    _closed = true;

    if (!_opened.isCompleted) _opened.completeError(reason);

    for (final ping in _pings.values) {
      if (!ping.isCompleted) ping.completeError(reason);
    }
    _pings.clear();

    unawaited(_requestSubscription?.cancel());
    _requestSubscription = null;

    final channel = _channel;
    final subscription = _socketSubscription;
    _socketSubscription = null;
    if (channel != null) {
      // Do not wait for the close handshake of an unresponsive server.
      unawaited(channel.sink
          .close(ws_status.normalClosure)
          .timeout(const Duration(seconds: 5))
          .then((_) {}, onError: (_) {})
          .whenComplete(() => subscription?.cancel()));
    }

    if (_transport._active == this) _transport._active = null;
  }

  Future<portal.Echo> ping(portal.Echo echo) {
    final id = const Uuid().v4();
    final completer = Completer<portal.Echo>();
    _pings[id] = completer;

    _send(portal.Request(id: id, path: WebSocketTransport.pingPath)
      ..data = Any.pack(echo));

    return completer.future
        .timeout(
          _transport.pingTimeout,
          onTimeout: () => throw GrpcError.deadlineExceeded('Ping timed out'),
        )
        .whenComplete(() => _pings.remove(id));
  }

  bool _completePing(portal.Update update) {
    if (_pings.isEmpty || !update.data.canUnpackInto(portal.Response())) {
      return false;
    }

    final response = update.data.unpackInto(portal.Response());
    final completer = _pings.remove(response.id);
    if (completer == null) return false;

    if (response.err.hasMessage()) {
      completer.completeError(
          GrpcError.custom(response.err.code, response.err.message));
    } else {
      completer.complete(response.data.canUnpackInto(portal.Echo())
          ? response.data.unpackInto(portal.Echo())
          : portal.Echo());
    }
    return true;
  }
}
