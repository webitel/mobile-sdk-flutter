import 'package:webitel_portal_sdk/src/domain/entities/dialog_message_response.dart';
import 'package:webitel_portal_sdk/src/domain/entities/media_file_response.dart';
import 'package:webitel_portal_sdk/src/domain/entities/peer.dart';

final class ErrorMessageBuilder {
  late String _errorMessage;

  ErrorMessageBuilder setErrorMessage(String errorMessage) {
    _errorMessage = errorMessage;
    return this;
  }

  DialogMessageResponse build() {
    return DialogMessageResponse(
      input: false,
      messageId: 0,
      dialogMessageContent: _errorMessage,
      requestId: '',
      peer: PeerInfo(id: '', name: '', type: ''),
      file: MediaFileResponse.initial(),
      timestamp: 0,
    );
  }
}
