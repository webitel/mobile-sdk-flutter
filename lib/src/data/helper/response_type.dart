import 'package:webitel_portal_sdk/src/domain/entities/response_type.dart';
import 'package:webitel_portal_sdk/src/generated/portal/connect.pb.dart';
import 'package:webitel_portal_sdk/src/generated/portal/messages.pb.dart';
import 'package:webitel_portal_sdk/src/generated/portal/messages.pbgrpc.dart';

/// Helper class to determine and handle different response types.
final class ResponseTypeHelper {
  // Constants representing different response types.
  static const ResponseType updateNewMessage = ResponseType.updateNewMessage;
  static const ResponseType response = ResponseType.response;
  static const ResponseType error = ResponseType.error;

  /// Determines the response type based on the content of an [Update].
  ///
  /// This method checks the data in the [update] to determine if it can be unpacked
  /// into a [Response] or [UpdateNewMessage] and returns the corresponding [ResponseType].
  /// If the data cannot be unpacked into any known type, an [Exception] is thrown.
  ///
  /// Returns the corresponding [ResponseType] based on the update content.
  ///
  /// Throws an [Exception] if the response type cannot be determined.
  ///
  /// [update] The update to be checked.
  static ResponseType determineResponseType(Update update) {
    if (update.data.canUnpackInto(Response())) {
      Response response = update.data.unpackInto(Response());
      if (response.err.hasMessage()) {
        return ResponseType.error;
      }
      return ResponseType.response;
    } else if (update.data.canUnpackInto(UpdateNewMessage())) {
      return ResponseType.updateNewMessage;
    } else if (update.data.canUnpackInto(UpdateChatMember())) {
      return ResponseType.memberAdded;
    } else if (update.data.canUnpackInto(UpdateLeftMember())) {
      return ResponseType.memberLeft;
    } else if (update.data.canUnpackInto(UpdateDisconnect())) {
      return ResponseType.disconnect;
    } else if (update.data.canUnpackInto(UpdateChatComplete())) {
      return ResponseType.chatComplete;
    } else {
      throw Exception('Unknown type');
    }
  }
}
