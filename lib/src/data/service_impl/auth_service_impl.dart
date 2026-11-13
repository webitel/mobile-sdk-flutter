import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:grpc/grpc.dart';
import 'package:injectable/injectable.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:uuid/uuid.dart';
import 'package:webitel_portal_sdk/src/data/builder/token_request.dart';
import 'package:webitel_portal_sdk/src/data/builder/user_agent.dart';
import 'package:webitel_portal_sdk/src/data/constants/constants.dart';
import 'package:webitel_portal_sdk/src/data/grpc/grpc_channel.dart';
import 'package:webitel_portal_sdk/src/data/helper/error.dart';
import 'package:webitel_portal_sdk/src/data/helper/uri.dart';
import 'package:webitel_portal_sdk/src/data/helper/user_agent.dart';
import 'package:webitel_portal_sdk/src/data/logger/logger.dart';
import 'package:webitel_portal_sdk/src/data/managers/call.dart';
import 'package:webitel_portal_sdk/src/data/managers/chat.dart';
import 'package:webitel_portal_sdk/src/data/portal_client_impl.dart';
import 'package:webitel_portal_sdk/src/data/shared_preferences/shared_preferences_gateway.dart';
import 'package:webitel_portal_sdk/src/domain/entities/call_error.dart';
import 'package:webitel_portal_sdk/src/domain/entities/portal_client.dart'
    as client;
import 'package:webitel_portal_sdk/src/domain/entities/portal_response.dart'
    as res;
import 'package:webitel_portal_sdk/src/domain/entities/portal_response_status.dart';
import 'package:webitel_portal_sdk/src/domain/entities/portal_user.dart';
import 'package:webitel_portal_sdk/src/domain/entities/portal_transport.dart';
import 'package:webitel_portal_sdk/src/domain/services/auth_service.dart';
import 'package:webitel_portal_sdk/src/generated/portal/account.pb.dart';
import 'package:webitel_portal_sdk/src/generated/portal/customer.pb.dart';
import 'package:webitel_portal_sdk/src/generated/portal/push.pb.dart';

/// Implementation of [AuthService] for handling authentication and user management.
@LazySingleton(as: AuthService)
class AuthServiceImpl implements AuthService {
  // Shared preferences gateway for accessing and storing data locally.
  final SharedPreferencesGateway _sharedPreferencesGateway;

  // gRPC channel for communicating with the server.
  final GrpcChannel _grpcChannel;

  // Logger for logging messages and errors.
  final log = CustomLogger.getLogger('AuthServiceImpl');

  /// Constructs an [AuthServiceImpl] instance with the given dependencies.
  AuthServiceImpl(
    this._grpcChannel,
    this._sharedPreferencesGateway,
  );

  /// Initializes the portal client with the specified URL and app token.
  ///
  /// This method configures the gRPC channel, retrieves device information,
  /// and sends an initial ping to check the channel's validity.
  ///
  /// [url] The URL of the portal.
  /// [appToken] The application token for authentication.
  /// [transport] The transport used to talk to the portal.
  ///
  /// Returns a [PortalClient] instance for interacting with the portal.
  @override
  Future<client.PortalClient> initClient({
    required String url,
    required String appToken,
    List<int>? cert,
    PortalTransport transport = PortalTransport.grpc,
  }) async {
    log.info(
        'Initializing gRPC channel for the portal URL: $url with the provided app token.');

    try {
      // Initialize shared preferences and save the app token.
      await _sharedPreferencesGateway.init();
      await _sharedPreferencesGateway.saveAppToken(appToken);

      // Retrieve or generate a unique device ID for this client instance.
      final deviceId = await getOrGenerateDeviceId();
      final packageInfo = await PackageInfo.fromPlatform();

      // Initialize device information plugins to get platform-specific details.
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      IosDeviceInfo? iosDeviceInfo;
      AndroidDeviceInfo? androidDeviceInfo;
      String? operatingSystemVersion;
      String? iosArchitecture;

      if (Platform.isIOS) {
        iosDeviceInfo = await deviceInfo.iosInfo;
        operatingSystemVersion =
            UserAgentHelper.parseIOSVersion(Platform.operatingSystemVersion);
        iosArchitecture =
            UserAgentHelper.parseArchitecture(iosDeviceInfo.utsname.version);

        log.info(
            'Retrieved iOS device information: Model - ${iosDeviceInfo.name}, Version - $operatingSystemVersion, Architecture - $iosArchitecture');
      } else if (Platform.isAndroid) {
        androidDeviceInfo = await deviceInfo.androidInfo;
        operatingSystemVersion = UserAgentHelper.parseAndroidVersion(
            Platform.operatingSystemVersion);

        log.info(
            'Retrieved Android device information: Model - ${androidDeviceInfo.model}, Version - $operatingSystemVersion');
      } else {
        log.warning(
            'Unknown platform type: ${Platform.operatingSystem}. Unable to retrieve device information.');
      }

      // Build the user agent string based on the retrieved device and application information.
      final userAgentString = buildUserAgent(
        appName: packageInfo.appName,
        appVersion: packageInfo.version,
        platform: Platform.operatingSystem,
        platformVersion: operatingSystemVersion ?? '',
        model: Platform.isIOS
            ? iosDeviceInfo?.name ?? ''
            : androidDeviceInfo?.model ?? '',
        device: Platform.isIOS
            ? iosDeviceInfo?.model ?? ''
            : androidDeviceInfo?.device ?? '',
        architecture: Platform.isIOS
            ? iosArchitecture ?? ''
            : androidDeviceInfo?.supportedAbis.first ?? '',
      );

      // Parse the URL and determine if a secure connection is required.
      final urlHelper = UrlHelper(url);
      final secureConnection = urlHelper.isSecure();
      final (hostUrl, port) = (urlHelper.getUrl(), urlHelper.getPort());

      log.info(
          'Initializing ${transport.name} connection to the host URL: $hostUrl with port: $port. Secure connection: $secureConnection');

      log.info('Using device ID: $deviceId and user agent: $userAgentString');

      // Initialize the gRPC channel with the specified parameters.
      await _grpcChannel.init(
        url: hostUrl,
        appToken: appToken,
        deviceId: deviceId,
        userAgent: userAgentString,
        port: port,
        secure: secureConnection,
        cert: cert,
        transport: transport,
      );

      return PortalClientImpl(
        url: url,
        appToken: appToken,
        call: CallManager(),
        chat: ChatManager(),
      );
    } on GrpcError catch (err) {
      log.severe(
          'An error occurred during the initialization of the gRPC channel: ${err.message}',
          err);

      return PortalClientImpl(
        error: CallError(
          errorMessage: err.message ?? '',
          statusCode: err.code.toString(),
        ),
        url: url,
        appToken: appToken,
        call: CallManager(),
        chat: ChatManager(),
      );
    }
  }

  /// Retrieves or generates a device ID.
  ///
  /// Returns the device ID as a string.
  Future<String> getOrGenerateDeviceId() async {
    log.info('Attempting to retrieve or generate a device ID.');

    // Retrieve the saved device ID from shared preferences.
    final savedDeviceId = await _sharedPreferencesGateway.readDeviceId();

    if (savedDeviceId == null || savedDeviceId == 'null') {
      // Generate a new device ID if none is saved.
      final deviceIdGenerated = const Uuid().v4();

      log.info(
          'No existing device ID found. Generating a new device ID: $deviceIdGenerated');

      await _sharedPreferencesGateway.saveDeviceId(deviceIdGenerated);
      return deviceIdGenerated;
    }
    log.info('Using existing device ID: $savedDeviceId');

    return savedDeviceId;
  }

  /// Builds a user agent string for the SDK.
  ///
  /// [appName] The name of the application.
  /// [appVersion] The version of the application.
  /// [platform] The platform (e.g., android, ios).
  /// [platformVersion] The version of the platform.
  /// [model] The model of the device.
  /// [device] The device name.
  /// [architecture] The architecture of the device.
  ///
  /// Returns the user agent string.
  String buildUserAgent({
    required String appName,
    required String appVersion,
    required String platform,
    required String platformVersion,
    required String model,
    required String device,
    required String architecture,
  }) {
    // Build the user agent string with the provided parameters.
    final userAgentString = UserAgentBuilder(
      sdkName: Constants.sdkName,
      sdkVersion: Constants.sdkVersion,
      appName: appName,
      version: appVersion,
      platform: platform == 'android' ? Constants.androidPlatform : platform,
      platformVersion: platformVersion,
      model: model,
      device: device,
      architecture: architecture,
    ).build();

    log.info('User agent string built successfully: $userAgentString');

    return userAgentString;
  }

  /// Logs in a user with the provided credentials and user information.
  ///
  /// [name] The name of the user.
  /// [sub] The subject (user ID).
  /// [issuer] The issuer of the credentials.
  /// [locale] The locale of the user (optional).
  /// [email] The email of the user (optional).
  /// [emailVerified] Indicates if the email is verified (optional).
  /// [phoneNumber] The phone number of the user (optional).
  /// [phoneNumberVerified] Indicates if the phone number is verified (optional).
  ///
  /// Returns a [PortalResponse] indicating the result of the login operation.
  @override
  Future<res.PortalResponse> login({
    required String name,
    required String sub,
    required String issuer,
    String? locale,
    String? email,
    bool? emailVerified,
    String? phoneNumber,
    bool? phoneNumberVerified,
  }) async {
    log.info(
        'Initiating login process for user: $name with subject: $sub and issuer: $issuer');

    // Retrieve the application token from shared preferences.
    final appToken = await _sharedPreferencesGateway.readAppToken();

    // Build the token request for the login operation.
    final request = TokenRequestBuilder()
        .setGrantType('identity')
        .setResponseType(['user', 'token', 'chat'])
        .setAppToken(appToken ?? '')
        .setIdentity(
          Identity(
            name: name,
            sub: sub,
            iss: issuer,
            locale: locale,
            email: email,
            emailVerified: emailVerified,
            phoneNumber: phoneNumber,
            phoneNumberVerified: phoneNumberVerified,
          ),
        )
        .build();

    try {
      // Send the token request to the server.
      final response = await _grpcChannel.customerStub.token(request);

      log.info(
          'User logged in successfully. Saving user ID and setting access token.');

      // Save the user ID and access token to shared preferences.
      await _sharedPreferencesGateway.saveUserId(response.chat.user.id);
      await _sharedPreferencesGateway.saveAccessToken(response.accessToken);

      // Set the access token in the gRPC channel.
      _grpcChannel.setAccessToken(response.accessToken);

      return res.PortalResponse(status: PortalResponseStatus.success);
    } on GrpcError catch (err) {
      log.severe(
          'A GRPC error occurred during the login process: ${err.message}',
          err);

      // Return a failure response indicating the login error.
      return res.PortalResponse(
        status: PortalResponseStatus.error,
        message: 'Failed to login: ${err.toString()}',
      );
    } catch (err) {
      log.severe(
          'An exception occurred during the login process: ${err.toString()}',
          err);

      // Return a failure response indicating the login error.
      return res.PortalResponse(
        status: PortalResponseStatus.error,
        message: 'Failed to login: ${err.toString()}',
      );
    }
  }

  // Sets custom token to headers [x-webitel-access] (jwt ...)
  @override
  Future<void> setAccessToken({required String token}) async {
    _grpcChannel.setAccessToken(token);
    await _grpcChannel.customerStub.inspect(InspectRequest());
  }

  /// Registers a device with a given push token.
  ///
  /// [pushToken] The push token to register the device with.
  ///
  /// Returns a [PortalResponse] indicating the result of the registration.
  @override
  Future<res.PortalResponse> registerDevice({required String pushToken}) async {
    log.info('Attempting to register device with push token: $pushToken');

    try {
      // Send the register device request to the server.
      await _grpcChannel.customerStub.registerDevice(
        RegisterDeviceRequest(
          push: Platform.isIOS
              ? DevicePush(aPN: pushToken)
              : DevicePush(fCM: pushToken),
        ),
      );

      log.info('Device registered successfully with push token: $pushToken');

      return res.PortalResponse(status: PortalResponseStatus.success);
    } catch (err) {
      log.severe(
          'Failed to register device with push token: $pushToken. Error: ${err.toString()}',
          err);

      // Return a failure response indicating the device registration error.
      return res.PortalResponse(
        status: PortalResponseStatus.error,
        message: 'Failed to register device: ${err.toString()}',
      );
    }
  }

  /// Unregisters a device.
  ///
  /// Returns a [PortalResponse] indicating the result of the un-registration.
  @override
  Future<res.PortalResponse> unregisterDevice() async {
    log.info('Attempting to unregister device');

    try {
      // Send the unregister device request to the server.
      await _grpcChannel.customerStub.registerDevice(
        RegisterDeviceRequest(push: null),
      );

      log.info('Device unregistered successfully');

      return res.PortalResponse(status: PortalResponseStatus.success);
    } catch (err) {
      log.severe('Failed to unregister device. Error: ${err.toString()}', err);

      // Return a failure response indicating the device un-registration error.
      return res.PortalResponse(
        status: PortalResponseStatus.error,
        message: 'Failed to unregister device: ${err.toString()}',
      );
    }
  }

  /// Logs out the current user.
  ///
  /// Returns a [PortalResponse] indicating the result of the logout operation.
  @override
  Future<res.PortalResponse> logout() async {
    log.info('Attempting to logout the current user.');

    try {
      // Send the logout request to the server.
      await _grpcChannel.customerStub.logout(LogoutRequest());

      log.info('User logged out successfully.');

      return res.PortalResponse(status: PortalResponseStatus.success);
    } catch (err) {
      log.severe(
          'Failed to logout the current user. Error: ${err.toString()}', err);

      // Return a failure response indicating the logout error.
      return res.PortalResponse(
        status: PortalResponseStatus.error,
        message: 'Failed to logout: ${err.toString()}',
      );
    }
  }

  /// Retrieves the current user information.
  ///
  /// Returns a [PortalUser] representing the current user.
  @override
  Future<PortalUser> getUser() async {
    log.info('Attempting to retrieve the current user information.');

    try {
      // Send the inspect request to retrieve user information.
      final token = await _grpcChannel.customerStub.inspect(InspectRequest());

      log.info('User information retrieved successfully.');

      return PortalUser(
        name: token.user.identity.name,
        sub: token.user.identity.sub,
        issuer: token.user.identity.iss,
        id: token.chat.user.id,
        tokenExpiration: token.expiresIn,
        locale: token.user.identity.locale,
        email: token.user.identity.email,
        emailVerified: token.user.identity.emailVerified,
        phoneNumber: token.user.identity.phoneNumber,
        phoneNumberVerified: token.user.identity.phoneNumberVerified,
      );
    } on GrpcError catch (err) {
      log.severe(
          'A GRPC error occurred while retrieving user information: ${err.message}',
          err);

      return PortalUser.error(
        error: CallError(
          errorMessage: err.message ?? '',
          statusCode: ErrorHelper.getCodeFromMessage(err.message ?? ''),
        ),
      );
    } catch (err) {
      log.severe(
          'An exception occurred while retrieving user information: ${err.toString()}',
          err);

      return PortalUser.error(
        error: CallError(
          errorMessage: err.toString(),
        ),
      );
    }
  }
}
