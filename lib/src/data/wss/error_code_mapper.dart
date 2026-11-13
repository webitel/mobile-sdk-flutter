import 'dart:async';
import 'dart:io';

import 'package:grpc/grpc.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

/// Maps HTTP / WebSocket failures to gRPC status codes, so every transport
/// reports errors the same way (mirrors `ErrorCodeMapper` of the Android SDK).
final class ErrorCodeMapper {
  ErrorCodeMapper._();

  static int fromHttpStatus(int status) => switch (status) {
        400 => StatusCode.failedPrecondition,
        401 => StatusCode.unauthenticated,
        403 => StatusCode.permissionDenied,
        404 => StatusCode.notFound,
        409 => StatusCode.alreadyExists,
        415 => StatusCode.invalidArgument,
        429 => StatusCode.resourceExhausted,
        499 => StatusCode.cancelled,
        500 => StatusCode.internal,
        501 => StatusCode.unimplemented,
        503 => StatusCode.unavailable,
        504 => StatusCode.deadlineExceeded,
        _ => StatusCode.unknown,
      };

  /// Maps a WebSocket close code. Codes 0..16 are gRPC codes forwarded by
  /// the server; 1008 (policy violation) means the session was rejected.
  static int fromCloseCode(int? code) => switch (code) {
        final int c when c >= 0 && c <= 16 => c,
        1008 => StatusCode.unauthenticated,
        _ => StatusCode.unknown,
      };

  static GrpcError httpError(int status, String body) => GrpcError.custom(
        fromHttpStatus(status),
        'HTTP error: $status $body',
      );

  /// Converts any transport failure to a [GrpcError].
  static GrpcError toGrpcError(Object error) => switch (error) {
        GrpcError() => error,
        WebSocketChannelException(inner: final Object inner) =>
          toGrpcError(inner),
        WebSocketException(httpStatusCode: final int status) =>
          GrpcError.custom(
            fromHttpStatus(status),
            'WebSocket HTTP error: $status ${error.message}',
          ),
        TimeoutException() =>
          GrpcError.deadlineExceeded('Request timed out: ${error.message}'),
        SocketException() ||
        HttpException() ||
        WebSocketException() ||
        WebSocketChannelException() ||
        TlsException() =>
          GrpcError.unavailable(error.toString()),
        FormatException() =>
          GrpcError.internal('Malformed server response: ${error.message}'),
        _ => GrpcError.unknown(error.toString()),
      };
}
