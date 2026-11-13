import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:fixnum/fixnum.dart';
import 'package:grpc/grpc.dart';
import 'package:webitel_portal_sdk/src/data/wss/error_code_mapper.dart';
import 'package:webitel_portal_sdk/src/data/wss/portal_http.dart';
import 'package:webitel_portal_sdk/src/data/wss/responses.dart';
import 'package:webitel_portal_sdk/src/data/wss/web_socket_transport.dart';
import 'package:webitel_portal_sdk/src/generated/chat/messages/message.pb.dart'
    as chat;
import 'package:webitel_portal_sdk/src/generated/portal/auth.pb.dart';
import 'package:webitel_portal_sdk/src/generated/portal/connect.pb.dart'
    as portal;
import 'package:webitel_portal_sdk/src/generated/portal/customer.pbgrpc.dart';
import 'package:webitel_portal_sdk/src/generated/portal/media.pbgrpc.dart';

/// Portal headers of a call: the stub metadata merged with the per-call
/// metadata, without empty values (e.g. no access token before login).
Map<String, String> _headers(CallOptions base, CallOptions? call) => {
      for (final entry in {...base.metadata, ...?call?.metadata}.entries)
        if (entry.value.isNotEmpty) entry.key: entry.value,
    };

/// [CustomerClient] served by the WebSocket transport.
///
/// `Connect` and `Ping` go through `wss://<host>/portal/ws`; token, inspect,
/// logout and device registration go through REST (`/api/portal/*`).
final class WebSocketCustomerClient extends CustomerClient {
  WebSocketCustomerClient(WebSocketTransport transport, {CallOptions? options})
      : _transport = transport,
        _options = options ?? CallOptions(),
        super(transport.clientChannel, options: options);

  static const tokenPath = 'api/portal/token';
  static const logoutPath = 'api/portal/logout';
  static const devicePath = 'api/portal/device';

  final WebSocketTransport _transport;
  final CallOptions _options;

  @override
  ResponseFuture<portal.Echo> ping(portal.Echo request,
          {CallOptions? options}) =>
      UnaryResponse(_transport.ping(request));

  @override
  ResponseFuture<AccessToken> token(TokenRequest request,
          {CallOptions? options}) =>
      UnaryResponse(_transport.unary(
        'POST',
        tokenPath,
        _headers(_options, options),
        AccessToken(),
        body: request,
      ));

  @override
  ResponseFuture<portal.UpdateDisconnect> logout(LogoutRequest request,
          {CallOptions? options}) =>
      UnaryResponse(_transport.unary(
        'POST',
        logoutPath,
        _headers(_options, options),
        portal.UpdateDisconnect(),
        body: request,
      ));

  @override
  ResponseFuture<AccessToken> inspect(InspectRequest request,
          {CallOptions? options}) =>
      UnaryResponse(_transport.unary(
        'GET',
        tokenPath,
        _headers(_options, options),
        AccessToken(),
      ));

  @override
  ResponseFuture<RegisterDeviceResponse> registerDevice(
          RegisterDeviceRequest request,
          {CallOptions? options}) =>
      UnaryResponse(_transport.unary(
        'POST',
        devicePath,
        _headers(_options, options),
        RegisterDeviceResponse(),
        body: request,
      ));

  @override
  ResponseStream<portal.Update> connect(Stream<portal.Request> request,
          {CallOptions? options}) =>
      _transport.connect(request, _headers(_options, options));
}

/// [MediaStorageClient] served over HTTP (`/portal/files`).
///
/// Speaks the same request/response messages as the gRPC stream, so file
/// transfer code does not depend on the transport.
final class HttpMediaStorageClient extends MediaStorageClient {
  HttpMediaStorageClient(WebSocketTransport transport, {CallOptions? options})
      : _http = transport.http,
        _options = options ?? CallOptions(),
        super(transport.clientChannel, options: options);

  static const filesPath = 'portal/files';

  final PortalHttp _http;
  final CallOptions _options;

  /// Upload protocol:
  ///   1. `POST /portal/files {mime_type, name}` -> `{upload_id}` (new upload);
  ///   2. `PUT /portal/files?uploadId=<id>` with the content
  ///      -> `{file_id, name, mime_type, size, hash}`.
  /// A request without a start message resumes the upload given by its pid.
  @override
  ResponseStream<UploadProgress> upload(Stream<UploadRequest> request,
      {CallOptions? options}) {
    final headers = _headers(_options, options);
    HttpClientRequest? put;
    var cancelled = false;
    late final StreamController<UploadProgress> progress;

    Future<void> run() async {
      String? uploadId;
      var mimeType = 'application/octet-stream';
      var sent = 0;

      Future<HttpClientRequest> openPut(String id) async => await _http.open(
            'PUT',
            _http.uri(filesPath, {'uploadId': id}),
            headers,
          )
            ..headers.contentType = ContentType.parse(mimeType);

      try {
        // Leaving the loop cancels the request stream.
        await for (final message in request) {
          if (cancelled) return;

          if (message.hasNew_2()) {
            if (message.new_2.file.type.isNotEmpty) {
              mimeType = message.new_2.file.type;
            }
            uploadId = await _createUpload(message.new_2.file, headers);
            progress.add(_partial(uploadId, sent));
          }

          if (message.part.isNotEmpty) {
            if (uploadId == null) {
              if (message.pid.isEmpty) {
                throw GrpcError.failedPrecondition(
                    'Upload data was sent before the upload was started');
              }
              uploadId = message.pid;
            }
            put ??= await openPut(uploadId);
            put!.add(message.part);
            await put!.flush();
            sent += message.part.length;
            progress.add(_partial(uploadId, sent));
          }
        }
        if (cancelled) return;

        if (uploadId == null) {
          throw GrpcError.invalidArgument('Upload request stream was empty');
        }
        put ??= await openPut(uploadId);

        final response = await put!.close();
        final body = await utf8.decodeStream(response);
        if (!PortalHttp.isSuccess(response.statusCode)) {
          throw ErrorCodeMapper.httpError(response.statusCode, body);
        }

        final json = jsonDecode(body) as Map<String, dynamic>;
        progress.add(
          UploadProgress(
            stat: UploadProgress_Complete(
              file: chat.File(
                id: '${json['file_id'] ?? ''}',
                name: '${json['name'] ?? ''}',
                type: '${json['mime_type'] ?? ''}',
                size: Int64(_asInt(json['size'])),
              ),
            )..hash.addAll({
                if (json['hash'] != null) 'sha256': '${json['hash']}',
              }),
          ),
        );
      } catch (err) {
        put?.abort();
        if (!cancelled) progress.addError(ErrorCodeMapper.toGrpcError(err));
      } finally {
        if (!cancelled) unawaited(progress.close());
      }
    }

    void cancel() {
      cancelled = true;
      put?.abort();
    }

    progress = StreamController<UploadProgress>(
      onListen: () => unawaited(run()),
      onCancel: cancel,
    );
    return StreamResponse(progress.stream, onCancel: () async => cancel());
  }

  Future<String> _createUpload(
    InputFile file,
    Map<String, String> headers,
  ) async {
    final body = await _http.sendJson(
      'POST',
      filesPath,
      headers,
      body: jsonEncode({'mime_type': file.type, 'name': file.name}),
    );
    final uploadId = (jsonDecode(body) as Map<String, dynamic>)['upload_id'];
    if (uploadId == null || '$uploadId'.isEmpty) {
      throw GrpcError.internal('Upload was not created: $body');
    }
    return '$uploadId';
  }

  static UploadProgress _partial(String pid, int size) => UploadProgress(
        part: UploadProgress_Partial(pid: pid, size: Int64(size)),
      );

  @override
  ResponseFuture<chat.File> uploadFile(Stream<UploadMedia> request,
          {CallOptions? options}) =>
      UnaryResponse(Future.error(GrpcError.unimplemented(
          'UploadFile is deprecated and not available over WebSocket; use Upload')));

  /// `GET /portal/files/<id>` with `Range: bytes=<offset>-`. Emits the file
  /// metadata first and then the content, like the gRPC `GetFile` stream.
  @override
  ResponseStream<MediaFile> getFile(GetFileRequest request,
      {CallOptions? options}) {
    final headers = _headers(_options, options);
    final offset = request.offset.toInt();
    HttpClientRequest? get;
    var cancelled = false;
    late final StreamController<MediaFile> output;

    Future<void> run() async {
      try {
        get = await _http.open(
          'GET',
          _http.uri('$filesPath/${Uri.encodeComponent(request.fileId)}'),
          headers,
        );
        if (offset > 0) {
          get!.headers.set(HttpHeaders.rangeHeader, 'bytes=$offset-');
        }

        final response = await get!.close();
        if (!PortalHttp.isSuccess(response.statusCode)) {
          final body = await utf8.decodeStream(response);
          throw ErrorCodeMapper.httpError(response.statusCode, body);
        }

        final ranged = response.statusCode == HttpStatus.partialContent;
        // A server that ignores Range returns the whole file.
        var skip = offset > 0 && !ranged ? offset : 0;

        output.add(MediaFile(
          file: chat.File(
            id: request.fileId,
            name: _fileName(response.headers) ?? '',
            type: response.headers.contentType?.mimeType ?? '',
            size: Int64(_totalSize(response, offset, ranged)),
          ),
        ));

        await for (var chunk in response) {
          if (cancelled) return;
          if (skip > 0) {
            if (chunk.length <= skip) {
              skip -= chunk.length;
              continue;
            }
            chunk = chunk.sublist(skip);
            skip = 0;
          }
          output.add(MediaFile(data: chunk));
        }
      } catch (err) {
        if (!cancelled) output.addError(ErrorCodeMapper.toGrpcError(err));
      } finally {
        if (!cancelled) unawaited(output.close());
      }
    }

    output = StreamController<MediaFile>(
      onListen: () => unawaited(run()),
      onCancel: () {
        cancelled = true;
        get?.abort();
      },
    );
    return StreamResponse(output.stream, onCancel: () async {
      cancelled = true;
      get?.abort();
    });
  }

  static int _totalSize(HttpClientResponse response, int offset, bool ranged) {
    final contentRange = response.headers.value(HttpHeaders.contentRangeHeader);
    final total = contentRange == null
        ? null
        : int.tryParse(contentRange.substring(contentRange.lastIndexOf('/') + 1));
    if (total != null) return total;

    final length = response.contentLength;
    if (length < 0) return 0;
    return ranged ? offset + length : length;
  }

  static String? _fileName(HttpHeaders headers) {
    final disposition = headers.value('content-disposition');
    if (disposition == null) return null;

    final encoded =
        RegExp(r"filename\*=(?:UTF-8'')?([^;]+)", caseSensitive: false)
            .firstMatch(disposition);
    if (encoded != null) {
      return Uri.decodeComponent(encoded.group(1)!.trim().replaceAll('"', ''));
    }
    return RegExp(r'filename="?([^";]+)"?', caseSensitive: false)
        .firstMatch(disposition)
        ?.group(1);
  }

  static int _asInt(Object? value) => switch (value) {
        final int v => v,
        final String v => int.tryParse(v) ?? 0,
        final num v => v.toInt(),
        _ => 0,
      };
}
