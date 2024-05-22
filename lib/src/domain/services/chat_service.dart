import 'dart:async';

import 'package:webitel_portal_sdk/src/domain/entities/call_error.dart';
import 'package:webitel_portal_sdk/src/domain/entities/channel.dart';
import 'package:webitel_portal_sdk/src/domain/entities/channel_status.dart';
import 'package:webitel_portal_sdk/src/domain/entities/connect.dart';
import 'package:webitel_portal_sdk/src/domain/entities/dialog.dart';
import 'package:webitel_portal_sdk/src/domain/entities/dialog_message/dialog_message_request.dart';
import 'package:webitel_portal_sdk/src/domain/entities/dialog_message/dialog_message_response.dart';
import 'package:webitel_portal_sdk/src/domain/entities/media_file/media_file_response.dart';

/// Interface for the chat service, providing methods for fetching messages,
/// sending messages, handling dialogs, and managing streams and errors.
abstract interface class ChatService {
  /// Fetches messages from a chat.
  ///
  /// [chatId] The ID of the chat to fetch messages from.
  /// [limit] The maximum number of messages to fetch (optional).
  /// [offset] The offset from which to start fetching messages (optional).
  ///
  /// Returns a list of [DialogMessageResponse] representing the fetched messages.
  Future<List<DialogMessageResponse>> fetchMessages({
    required String chatId,
    int? limit,
    int? offset,
  });

  /// Fetches updates from a chat.
  ///
  /// [chatId] The ID of the chat to fetch updates from.
  /// [limit] The maximum number of updates to fetch (optional).
  /// [offset] The offset from which to start fetching updates (optional).
  ///
  /// Returns a list of [DialogMessageResponse] representing the fetched updates.
  Future<List<DialogMessageResponse>> fetchUpdates({
    required String chatId,
    int? limit,
    int? offset,
  });

  /// Sends a message in a chat.
  ///
  /// [chatId] The ID of the chat to send the message to.
  /// [message] The message to be sent.
  ///
  /// Returns a [DialogMessageResponse] indicating the result of the send operation.
  Future<DialogMessageResponse> sendMessage({
    required String chatId,
    required DialogMessageRequest message,
  });

  /// Fetches the service dialog.
  ///
  /// Returns a [Dialog] representing the service dialog.
  Future<Dialog> fetchServiceDialog();

  /// Fetches all dialogs.
  ///
  /// Returns a list of [Dialog] representing all dialogs.
  Future<List<Dialog>> fetchDialogs();

  /// Attempts to reconnect to the stream.
  ///
  /// Returns a [Future] that completes when the reconnection attempt is done.
  Future<void> reconnectToStream();

  /// Retrieves the current communication channel.
  ///
  /// Returns a [Channel] representing the current communication channel.
  Future<Channel> getChannel();

  /// Downloads a media file associated with a dialog.
  ///
  /// [fileId] The unique identifier of the file to be downloaded.
  ///
  /// Returns a stream of [MediaFileResponse] for the downloaded file.
  Stream<MediaFileResponse> downloadFile({required String fileId});

  /// Provides a stream controller for channel status changes.
  ///
  /// Returns a [StreamController] for [ChannelStatus] changes.
  StreamController<ChannelStatus> onChannelStatusChange();

  /// Provides a stream controller for connection status changes.
  ///
  /// Returns a [StreamController] for [Connect] status changes.
  StreamController<Connect> onConnectStreamStatusChange();

  /// Provides a stream controller for errors occurring in the chat service.
  ///
  /// Returns a [StreamController] for [CallError] occurrences.
  StreamController<CallError> onError();
}
