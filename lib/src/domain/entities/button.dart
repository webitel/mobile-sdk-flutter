/// Represents a button in the keyboard.
library;

class Button {
  /// The text displayed on the button.
  final String text;

  /// The callback code executed when the button is pressed (optional).
  /// This corresponds to postback/callback data.
  final String? code;

  /// The URL to navigate to when the button is pressed (optional).
  final String? url;

  /// Constructs a [Button] instance with the given details.
  ///
  /// [text] The text displayed on the button. This is a required parameter.
  /// [code] The callback code executed when the button is pressed (optional).
  /// [url] The URL to navigate to when the button is pressed (optional).
  Button({
    required this.text,
    this.code,
    this.url,
  });
}
