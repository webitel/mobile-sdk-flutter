import 'package:webitel_portal_sdk/src/domain/entities/portal_client.dart';
import 'package:webitel_portal_sdk/src/domain/entities/portal_response.dart';
import 'package:webitel_portal_sdk/src/domain/entities/portal_user.dart';
import 'package:webitel_portal_sdk/src/domain/entities/portal_transport.dart';

/// Interface for the authentication service, providing methods for user authentication,
/// device registration, client initialization, and user information retrieval.
abstract interface class AuthService {
  /// Logs out the current user.
  ///
  /// Returns a [PortalResponse] indicating the result of the logout operation.
  Future<PortalResponse> logout();

  /// Registers a device with a given push token.
  ///
  /// [pushToken] The push token to register the device with.
  ///
  /// Returns a [PortalResponse] indicating the result of the registration.
  Future<PortalResponse> registerDevice({required String pushToken});

  /// Unregisters a device.
  ///
  /// Returns a [PortalResponse] indicating the result of the un-registration
  /// from push notifications.
  Future<PortalResponse> unregisterDevice();

  /// Initializes the portal client with the specified URL and app token.
  ///
  /// [url] The URL of the portal.
  /// [appToken] The application token for authentication.
  /// [transport] The transport used to talk to the portal.
  ///
  /// Returns a [PortalClient] instance for interacting with the portal.
  Future<PortalClient> initClient({
    required String url,
    required String appToken,
    List<int>? cert,
    PortalTransport transport = PortalTransport.grpc,
  });

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
  Future<PortalResponse> login({
    required String name,
    required String sub,
    required String issuer,
    String? locale,
    String? email,
    bool? emailVerified,
    String? phoneNumber,
    bool? phoneNumberVerified,
  });

  // Set custom token (jwt ...)
  Future<void> setAccessToken({
    required String token,
  });

  /// Retrieves the current user information.
  ///
  /// Returns a [PortalUser] representing the current user.
  Future<PortalUser> getUser();
}
