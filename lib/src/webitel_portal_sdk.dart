import 'package:webitel_portal_sdk/src/backbone/logger.dart';
import 'package:webitel_portal_sdk/src/domain/entities/logger_level.dart';
import 'package:webitel_portal_sdk/src/domain/entities/portal_client.dart';
import 'package:webitel_portal_sdk/src/domain/services/auth_service.dart';
import 'package:webitel_portal_sdk/src/injection/injection.dart';

class WebitelPortalSdk {
  static final WebitelPortalSdk _instance = WebitelPortalSdk._internal();

  WebitelPortalSdk._internal();

  static WebitelPortalSdk get instance => _instance;

  Future<PortalClient> initClient({
    required String url,
    required String appToken,
    required LoggerLevel loggerLevel,
  }) async {
    configureDependencies();
    CustomLogger.initialize(loggerLevel: loggerLevel);
    AuthService authService = getIt<AuthService>();

    final client = authService.initClient(
      url: url,
      appToken: appToken,
    );

    return client;
  }
}
