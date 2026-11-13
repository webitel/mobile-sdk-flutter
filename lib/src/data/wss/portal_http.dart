import 'dart:convert';
import 'dart:io';

import 'package:webitel_portal_sdk/src/data/wss/error_code_mapper.dart';

/// HTTP client bound to the portal base URL.
///
/// Every request carries the same portal headers as the gRPC metadata
/// (`x-portal-client`, `x-portal-device`, `x-portal-access`) plus the SDK
/// user agent.
final class PortalHttp {
  PortalHttp({
    required this.baseUri,
    required this.userAgent,
    required this.client,
    this.requestTimeout = const Duration(seconds: 30),
  });

  /// Base URL, e.g. `https://host[:port]/`.
  final Uri baseUri;
  final String userAgent;
  final HttpClient client;
  final Duration requestTimeout;

  Uri uri(String path, [Map<String, String>? query]) {
    final resolved = baseUri.resolve(path);
    return query == null ? resolved : resolved.replace(queryParameters: query);
  }

  /// Opens a request with the portal [headers] already set.
  Future<HttpClientRequest> open(
    String method,
    Uri uri,
    Map<String, String> headers,
  ) async {
    final request = await client.openUrl(method, uri);
    request.headers.set(HttpHeaders.userAgentHeader, userAgent);
    headers.forEach(request.headers.set);
    return request;
  }

  /// Sends a request with an optional JSON [body] and returns the response
  /// body. Non-2xx responses and transport failures throw a `GrpcError`.
  Future<String> sendJson(
    String method,
    String path,
    Map<String, String> headers, {
    String? body,
  }) async {
    try {
      return await _sendJson(method, uri(path), headers, body)
          .timeout(requestTimeout);
    } catch (err) {
      throw ErrorCodeMapper.toGrpcError(err);
    }
  }

  Future<String> _sendJson(
    String method,
    Uri uri,
    Map<String, String> headers,
    String? body,
  ) async {
    final request = await open(method, uri, headers);
    if (body != null) {
      request.headers.contentType = ContentType.json;
      request.add(utf8.encode(body));
    }

    final response = await request.close();
    final text = await utf8.decodeStream(response);
    if (!isSuccess(response.statusCode)) {
      throw ErrorCodeMapper.httpError(response.statusCode, text);
    }
    return text;
  }

  static bool isSuccess(int status) => status >= 200 && status < 300;
}
