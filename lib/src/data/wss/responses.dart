import 'dart:async';

import 'package:grpc/grpc.dart' hide ClientChannel;
import 'package:grpc/service_api.dart' as $grpc show ClientChannel;

/// [ResponseFuture] backed by a plain [Future], so WebSocket/HTTP calls
/// can be returned from the generated gRPC stubs unchanged.
final class UnaryResponse<R> implements ResponseFuture<R> {
  UnaryResponse(this._future);

  final Future<R> _future;

  @override
  Future<Map<String, String>> get headers async => const {};

  @override
  Future<Map<String, String>> get trailers async => const {};

  @override
  Future<void> cancel() async {}

  @override
  Stream<R> asStream() => _future.asStream();

  @override
  Future<R> catchError(Function onError, {bool Function(Object error)? test}) =>
      _future.catchError(onError, test: test);

  @override
  Future<S> then<S>(FutureOr<S> Function(R value) onValue,
          {Function? onError}) =>
      _future.then(onValue, onError: onError);

  @override
  Future<R> timeout(Duration timeLimit, {FutureOr<R> Function()? onTimeout}) =>
      _future.timeout(timeLimit, onTimeout: onTimeout);

  @override
  Future<R> whenComplete(FutureOr<void> Function() action) =>
      _future.whenComplete(action);
}

/// [ResponseStream] backed by a plain [Stream].
final class StreamResponse<R> extends StreamView<R>
    implements ResponseStream<R> {
  StreamResponse(
    super.stream, {
    Future<Map<String, String>>? headers,
    Future<void> Function()? onCancel,
  })  : headers = headers ?? Future.value(const {}),
        _onCancel = onCancel;

  final Future<void> Function()? _onCancel;

  @override
  final Future<Map<String, String>> headers;

  @override
  Future<Map<String, String>> get trailers async => const {};

  @override
  Future<void> cancel() async => _onCancel?.call();

  @override
  ResponseFuture<R> get single => UnaryResponse(super.single);
}

/// [$grpc.ClientChannel] for stubs whose calls never go through gRPC.
///
/// It only exposes the connection state of the WebSocket transport, so
/// `GrpcChannel` observes it exactly like a real gRPC channel.
final class WebSocketClientChannel implements $grpc.ClientChannel {
  WebSocketClientChannel(this.onConnectionStateChanged);

  @override
  final Stream<ConnectionState> onConnectionStateChanged;

  @override
  ClientCall<Q, R> createCall<Q, R>(
    ClientMethod<Q, R> method,
    Stream<Q> requests,
    CallOptions options,
  ) =>
      throw GrpcError.unimplemented(
          '${method.path} is not available over the WebSocket transport');

  @override
  Future<void> shutdown() async {}

  @override
  Future<void> terminate() async {}
}
