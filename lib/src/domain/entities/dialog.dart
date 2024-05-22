import 'dart:async';

import 'package:webitel_portal_sdk/src/domain/entities/call_error.dart';
import 'package:webitel_portal_sdk/src/domain/entities/dialog_message/dialog_message_response.dart';
import 'package:webitel_portal_sdk/src/domain/entities/media_file/media_file_response.dart';

/// Interface for dialog operations, providing methods to manage messages,
/// download files, and handle dialog events.
abstract interface class Dialog {
  /// Retrieves the last occurred error, if any.
  ///
  /// Returns a [CallError] if an error occurred, otherwise returns null.
  CallError? get error;

  /// Retrieves the unique identifier of the dialog.
  ///
  /// Returns the dialog ID as a string.
  String get id;

  /// Retrieves the content of the top message in the dialog.
  ///
  /// Returns the top message as a string.
  String get topMessage;

  /// Stream of new messages in the dialog.
  ///
  /// Returns a stream of [DialogMessageResponse] for new messages.
  Stream<DialogMessageResponse> get onNewMessage;

  /// Downloads a media file associated with the dialog.
  ///
  /// [fileId] The unique identifier of the file to be downloaded.
  ///
  /// Returns a stream of [MediaFileResponse] for the downloaded file.
  Stream<MediaFileResponse> downloadFile({required String fileId});

  // Uncomment the following StreamController properties if needed:
  // StreamController<String> get onMemberAdded;
  // StreamController<String> get onMemberRemoved;
  // StreamController<String> get onOperatorAdded;
  // StreamController<String> get onOperatorRemoved;
  // StreamController<String> get onMessageEdited;
  // StreamController<String> get onMessageDeleted;
  // StreamController<String> get onNewReaction;
  // StreamController<String> get onTyping;

  /// Sends a message in the dialog.
  ///
  /// [mediaType] The type of the media to be sent (optional).
  /// [mediaName] The name of the media to be sent (optional).
  /// [mediaData] The data stream of the media to be sent (optional).
  /// [content] The content of the message.
  /// [requestId] The unique identifier for the message request.
  ///
  /// Returns a [DialogMessageResponse] indicating the result of the send operation.
  Future<DialogMessageResponse> sendMessage({
    String? mediaType,
    String? mediaName,
    Stream<List<int>>? mediaData,
    required String content,
    required String requestId,
  });

  /// Fetches messages in the dialog with optional pagination.
  ///
  /// [limit] The maximum number of messages to fetch (optional).
  /// [offset] The offset from which to start fetching messages (optional).
  ///
  /// Returns a list of [DialogMessageResponse] representing the fetched messages.
  Future<List<DialogMessageResponse>> fetchMessages({
    int? limit,
    int? offset,
  });

  /// Fetches updates in the dialog with optional pagination.
  ///
  /// [limit] The maximum number of updates to fetch (optional).
  /// [offset] The offset from which to start fetching updates (optional).
  ///
  /// Returns a list of [DialogMessageResponse] representing the fetched updates.
  Future<List<DialogMessageResponse>> fetchUpdates({
    int? limit,
    int? offset,
  });
}
