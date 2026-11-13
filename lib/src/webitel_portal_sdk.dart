import 'package:webitel_portal_sdk/src/data/logger/logger.dart';
import 'package:webitel_portal_sdk/src/domain/entities/logger_level.dart';
import 'package:webitel_portal_sdk/src/domain/entities/portal_client.dart';
import 'package:webitel_portal_sdk/src/domain/entities/portal_transport.dart';
import 'package:webitel_portal_sdk/src/domain/services/auth_service.dart';
import 'package:webitel_portal_sdk/src/injection/injection.dart';

/// Singleton class for initializing and managing the Webitel Portal SDK.
class WebitelPortalSdk {
  // Singleton instance of WebitelPortalSdk.
  static final WebitelPortalSdk _instance = WebitelPortalSdk._internal();

  // Private constructor for internal instantiation.
  WebitelPortalSdk._internal();

  /// Gets the singleton instance of [WebitelPortalSdk].
  static WebitelPortalSdk get instance => _instance;

  /// Initializes the portal client with the specified URL, app token, and logger level.
  ///
  /// This method configures dependencies, initializes the custom logger with the
  /// provided [loggerLevel], and then uses the [AuthService] to initialize the portal client.
  ///
  /// [url] The URL of the portal.
  /// [appToken] The application token for authentication.
  /// [loggerLevel] The level of logging to be used.
  /// [cert] Optional PEM certificate(s) to trust instead of the system roots.
  /// [transport] The transport used to talk to the portal: [PortalTransport.grpc]
  /// (default) or [PortalTransport.websocket]. The rest of the API is identical.
  ///
  /// Returns a [PortalClient] instance for interacting with the portal.
  Future<PortalClient> initClient({
    required String url,
    required String appToken,
    required LoggerLevel loggerLevel,
    List<int>? cert,
    PortalTransport transport = PortalTransport.grpc,
  }) async {
    // Configure dependencies using dependency injection.
    configureDependencies();

    // Initialize the custom logger with the specified logger level.
    CustomLogger.initialize(loggerLevel: loggerLevel);

    // Get an instance of AuthService from the dependency injection container.
    AuthService authService = getIt<AuthService>();

    // Initialize the portal client using the AuthService.
    final client = authService.initClient(
      url: url,
      appToken: appToken,
      cert: cert,
      transport: transport,
    );

    return client;
  }
}
