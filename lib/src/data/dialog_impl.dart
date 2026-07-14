import 'dart:async';
import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:webitel_portal_sdk/src/domain/entities/call_error.dart';
import 'package:webitel_portal_sdk/src/domain/entities/dialog.dart';
import 'package:webitel_portal_sdk/src/domain/entities/dialog_message_request.dart';
import 'package:webitel_portal_sdk/src/domain/entities/dialog_message_response.dart';
import 'package:webitel_portal_sdk/src/domain/entities/download.dart';
import 'package:webitel_portal_sdk/src/domain/entities/portal_chat_member.dart';
import 'package:webitel_portal_sdk/src/domain/entities/postback.dart';
import 'package:webitel_portal_sdk/src/domain/entities/upload.dart';
import 'package:webitel_portal_sdk/src/domain/entities/upload_file.dart';
import 'package:webitel_portal_sdk/src/domain/services/chat_service.dart';
import 'package:webitel_portal_sdk/src/injection/injection.dart';

/// Implementation of [Dialog] that provides functionalities for dialog operations.
@LazySingleton(as: Dialog)
final class DialogImpl implements Dialog {
  /// The unique identifier for the dialog.
  @override
  final String id;

  /// The current status of the dialog whether it's closed.
  @override
  final bool isClosed;

  /// The top message in the dialog.
  @override
  final String topMessage;

  /// The error associated with the dialog, if any.
  @override
  final CallError? error;

  /// Stream [DialogMessageResponse] for new messages in the dialog.
  @override
  final Stream<DialogMessageResponse> onNewMessage;

  /// Stream [PortalChatMember] for new member added to the chat.
  @override
  final Stream<PortalChatMember> onMemberAdded;

  /// Stream [PortalChatMember] for member left the chat.
  @override
  final Stream<PortalChatMember> onMemberLeft;

  // Dependency on the ChatService to handle chat-related operations.
  late final ChatService _chatService;

  /// Constructor for initializing a [DialogImpl] instance.
  DialogImpl({
    required this.id,
    required this.topMessage,
    required this.isClosed,
    required this.onNewMessage,
    required this.onMemberAdded,
    required this.onMemberLeft,
    this.error,
  }) {
    _chatService = getIt.get<ChatService>();
  }

  /// Named constructor for creating an initial/default instance of [DialogImpl].
  DialogImpl.initial()
      : id = 'default_id',
        topMessage = 'No messages yet',
        isClosed = true,
        error = CallError(statusCode: '', errorMessage: ''),
        onNewMessage = Stream.empty(),
        onMemberLeft = Stream.empty(),
        onMemberAdded = Stream.empty();

  /// Sends a message in the dialog.
  @override
  Future<DialogMessageResponse> sendMessage({
    UploadFile? uploadFile,
    required String content,
    required String requestId,
    int? timeout,
  }) async {
    return await _chatService.sendMessage(
      chatId: id,
      timeout: timeout,
      message: DialogMessageRequest(
        content: content,
        requestId: requestId,
        uploadFile: UploadFile(
          name: uploadFile?.name ?? '',
          type: uploadFile?.type ?? '',
          id: uploadFile?.id ?? '',
        ),
      ),
    );
  }

  /// Sends a postback in the dialog.
  @override
  Future<DialogMessageResponse> sendPostback({
    required Postback postback,
    required String requestId,
    int? timeout,
  }) async {
    return await _chatService.sendPostback(
      chatId: id,
      timeout: timeout,
      requestId: requestId,
      postback: postback,
    );
  }

  /// Fetches messages in the dialog.
  @override
  Future<List<DialogMessageResponse>> fetchMessages({
    int? limit,
    int? offset,
  }) async {
    return await _chatService.fetchMessages(
      chatId: id,
      limit: limit,
      offset: offset,
    );
  }

  /// Fetches updates in the dialog.
  @override
  Future<List<DialogMessageResponse>> fetchUpdates({
    int? limit,
    int? offset,
  }) async {
    return await _chatService.fetchUpdates(
      chatId: id,
      limit: limit,
      offset: offset,
    );
  }

  /// Downloads a media file associated with a dialog.
  @override
  Download downloadFile({
    required String fileId,
    required String savePath,
    int? offset,
  }) =>
      _chatService.downloadFile(
        fileId: fileId,
        offset: offset,
        savePath: savePath,
      );

  /// Uploads a media file associated with a dialog.
  @override
  Upload uploadFile({
    required String mediaType,
    required String mediaName,
    required File file,
    String? pid,
    int? offset,
  }) =>
      _chatService.uploadFile(
        mediaType: mediaType,
        mediaName: mediaName,
        file: file,
        pid: pid,
        offset: offset,
      );
}
