/// The `Constants` class holds static constant values used throughout the application.
///
/// This class provides a centralized location for defining constant values
/// such as SDK name, SDK version, API paths, and other configuration settings.
final class Constants {
  /// Private constructor to prevent instantiation.
  ///
  /// This class is intended to be used in a static context only.
  Constants._();

  /// The name of the SDK.
  static const String sdkName = 'webitel_portal_sdk';

  /// The version of the SDK.
  static const String sdkVersion = '1.3.0';

  /// The platform name for Android.
  static const String androidPlatform = 'Android';

  /// The API path for fetching chat dialogs.
  static const String fetchDialogsPath =
      '/webitel.portal.ChatMessages/ChatDialogs';

  /// The API path for fetching chat updates.
  static const String chatUpdatesPath =
      '/webitel.portal.ChatMessages/ChatUpdates';

  /// The API path for sending a message.
  static const String sendMessagePath =
      '/webitel.portal.ChatMessages/SendMessage';

  /// The API path for fetching chat history.
  static const String chatHistoryPath =
      '/webitel.portal.ChatMessages/ChatHistory';

  /// The default timeout duration for requests.
  static const Duration requestTimeout = Duration(seconds: 5);
}
