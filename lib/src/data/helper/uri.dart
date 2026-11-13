/// Helper class to manage and extract information from URLs.
final class UrlHelper {
  // The parsed URI from the provided URL string.
  late Uri _uri;

  /// Constructs a [UrlHelper] instance by parsing the provided [url].
  ///
  /// [url] The URL string to be parsed.
  UrlHelper(String url) {
    _uri = Uri.parse(url);
  }

  /// Retrieves the host part of the URL.
  ///
  /// Returns the host as a string.
  String getUrl() {
    return _uri.host;
  }

  /// Retrieves the port part of the URL.
  ///
  /// If the URL does not explicitly specify a port, the method returns the default
  /// port based on the URL scheme. For 'grpcs' scheme, it returns 443. For 'grpc'
  /// or any other scheme, it returns 443.
  ///
  /// Returns the port as an integer.
  int getPort() {
    if (_uri.hasPort) {
      return _uri.port;
    } else {
      switch (_uri.scheme) {
        case 'grpcs':
          return 443;
        case 'grpc':
        default:
          return 443;
      }
    }
  }

  /// Checks if the URL uses a secure scheme.
  ///
  /// The method considers 'https', 'grpcs' and 'wss' schemes as secure.
  ///
  /// Returns `true` if the scheme is secure, otherwise `false`.
  bool isSecure() {
    return _uri.scheme == 'https' ||
        _uri.scheme == 'grpcs' ||
        _uri.scheme == 'wss';
  }
}
