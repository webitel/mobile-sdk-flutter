import 'dart:async';

import 'package:fixnum/fixnum.dart' as fixnum;
import 'package:grpc/grpc.dart';
import 'package:grpc/grpc_or_grpcweb.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';
import 'package:webitel_portal_sdk/src/backbone/builder/error_dialog_message_builder.dart';
import 'package:webitel_portal_sdk/src/backbone/builder/messages_list_message_builder.dart';
import 'package:webitel_portal_sdk/src/backbone/builder/response_dialog_message_builder.dart';
import 'package:webitel_portal_sdk/src/backbone/constants.dart';
import 'package:webitel_portal_sdk/src/backbone/helper/error.dart';
import 'package:webitel_portal_sdk/src/backbone/helper/message.dart';
import 'package:webitel_portal_sdk/src/backbone/logger.dart';
import 'package:webitel_portal_sdk/src/backbone/shared_preferences/shared_preferences_gateway.dart';
import 'package:webitel_portal_sdk/src/data/channel_impl.dart';
import 'package:webitel_portal_sdk/src/data/dialog_impl.dart';
import 'package:webitel_portal_sdk/src/data/grpc/grpc_channel.dart';
import 'package:webitel_portal_sdk/src/data/grpc/grpc_connect.dart';
import 'package:webitel_portal_sdk/src/domain/entities/channel.dart';
import 'package:webitel_portal_sdk/src/domain/entities/connect.dart';
import 'package:webitel_portal_sdk/src/domain/entities/dialog_message/dialog_message_request.dart';
import 'package:webitel_portal_sdk/src/domain/entities/dialog_message/dialog_message_response.dart';
import 'package:webitel_portal_sdk/src/domain/entities/media_file/media_file_response.dart';
import 'package:webitel_portal_sdk/src/domain/entities/message_type.dart';
import 'package:webitel_portal_sdk/src/domain/services/chat_service.dart';
import 'package:webitel_portal_sdk/src/generated/chat/messages/dialog.pb.dart'
    as dialog;
import 'package:webitel_portal_sdk/src/generated/chat/messages/history.pb.dart';
import 'package:webitel_portal_sdk/src/generated/chat/messages/message.pb.dart'
    as file;
import 'package:webitel_portal_sdk/src/generated/google/protobuf/any.pb.dart';
import 'package:webitel_portal_sdk/src/generated/portal/connect.pb.dart'
    as portal;
import 'package:webitel_portal_sdk/src/generated/portal/media.pb.dart';
import 'package:webitel_portal_sdk/src/generated/portal/messages.pbgrpc.dart';
import 'package:webitel_portal_sdk/webitel_portal_sdk.dart';

typedef SendMessageResponseHandler = Future<void> Function(
  portal.Response response,
  Completer<DialogMessageResponse> completer,
  String userId,
);

typedef SendMessageErrorHandler = void Function(
  Object error,
  Completer<DialogMessageResponse> completer,
  String requestId,
);

@LazySingleton(as: ChatService)
final class ChatServiceImpl implements ChatService {
  final GrpcChannel _grpcChannel;
  final GrpcConnect _grpcConnect;
  final SharedPreferencesGateway _sharedPreferencesGateway;

  final uuid = Uuid();
  final log = CustomLogger.getLogger('ChatServiceImpl');
  final Map<String, StreamController<DialogMessageResponse>>
      _onNewMessageControllers = {};

  // final Map<String, StreamController<void>> _onTypingControllers = {};
  // final Map<String, StreamController<void>> _onMessageDeleted = {};
  // final Map<String, StreamController<void>> _onMessageEdited = {};
  // final Map<String, StreamController<void>> _onOperatorActions = {};

  ChatServiceImpl(
    this._grpcChannel,
    this._grpcConnect,
    this._sharedPreferencesGateway,
  ) {
    initListeners();
  }

  void initListeners() {
    listenToMessages();
    log.info("Message listener setup complete.");

    onConnectStreamStatusChange();
    log.info("Connection stream status change listener activated.");

    onChannelStatusChange();
    log.info("Channel status change listener enabled.");

    onError();
    log.info("Error handling is configured.");
  }

  //Get controller for specific chat by chatId or create one if absent
  Future<StreamController<DialogMessageResponse>> getControllerForChat(
    String chatId,
  ) async {
    var controllerExists = _onNewMessageControllers.containsKey(chatId);
    if (controllerExists) {
      log.info('Retrieving existing controller for chat ID: $chatId');
    } else {
      log.info('No controller found for chat ID: $chatId, creating a new one.');
    }

    return _onNewMessageControllers.putIfAbsent(
      chatId,
      () {
        log.info(
            'New StreamController for DialogMessageResponseEntity created for chat ID: $chatId');
        return StreamController<DialogMessageResponse>.broadcast();
      },
    );
  }

  @override
  Future<List<Dialog>> fetchDialogs() async {
    final requestId = uuid.v4();
    log.info('Initiating fetch for chat dialogs with request ID: $requestId');

    await _sharedPreferencesGateway.init();
    final chatDialogsRequest = dialog.ChatDialogsRequest();

    final request = portal.Request(
      path: Constants.fetchDialogsPath,
      data: Any.pack(chatDialogsRequest),
      id: requestId,
    );

    log.info('Sending request to fetch chat dialogs');

    await _grpcConnect.sendRequest(request);

    try {
      final response = await _grpcConnect.responseStream
          .firstWhere((response) => response.id == requestId);

      log.info('Received response for chat dialogs request ID: $requestId');

      if (response.data.canUnpackInto(ChatList())) {
        final unpackedDialogMessages = response.data.unpackInto(ChatList());
        if (unpackedDialogMessages.data.isNotEmpty) {
          log.info(
              'Successfully unpacked chat dialogs, saving first chat ID to preferences');

          _sharedPreferencesGateway.saveToDisk(
            'chatId',
            unpackedDialogMessages.data.first.id,
          );

          final List<Future<Dialog>> dialogFutures =
              unpackedDialogMessages.data.map((dialog) async {
            final onNewMessageController =
                await getControllerForChat(dialog.id);

            return DialogImpl(
              topMessage: dialog.message.text,
              id: dialog.id,
              onNewMessage: onNewMessageController.stream,
            );
          }).toList();

          final dialogs = await Future.wait(dialogFutures);

          log.info('Fetched dialogs: ${dialogs.length}');

          return dialogs;
        } else {
          log.info('No chat dialogs were returned in the response');

          return [];
        }
      } else if (response.err.hasMessage()) {
        final (requestId, errorMessage) = (
          response.id,
          response.err.message,
        );

        log.warning('Failed to unpack chat list for request ID: $requestId '
            '$errorMessage');
        final statusCode = ErrorHelper.getCodeFromMessage(errorMessage);

        return [
          DialogImpl(
            error: CallError(
              statusCode: statusCode,
              errorMessage: response.err.message,
            ),
            topMessage: 'ERROR',
            id: response.id,
            onNewMessage: Stream<DialogMessageResponse>.empty(),
          ),
        ];
      } else {
        log.warning('Failed to unpack chat list for request ID: $requestId');
      }
    } catch (err) {
      log.severe(
        'Error fetching chat dialogs with request ID: $requestId',
      );
    }
    return [];
  }

  @override
  Future<Dialog> fetchServiceDialog() async {
    final requestId = uuid.v4();
    log.info('Initiating fetch for chat dialogs with request ID: $requestId');

    await _sharedPreferencesGateway.init();
    final chatDialogsRequest = dialog.ChatDialogsRequest();

    final request = portal.Request(
      path: Constants.fetchDialogsPath,
      data: Any.pack(chatDialogsRequest),
      id: requestId,
    );

    log.info('Sending request to fetch chat dialogs');
    await _grpcConnect.sendRequest(request);

    try {
      final response = await _grpcConnect.responseStream
          .firstWhere((response) => response.id == requestId);

      log.info('Received response for chat dialogs request ID: $requestId');
      if (response.data.canUnpackInto(ChatList())) {
        final unpackedDialogMessages = response.data.unpackInto(ChatList());

        if (unpackedDialogMessages.data.isNotEmpty) {
          log.info(
              'Successfully unpacked chat dialogs, saving first chat ID to preferences');

          _sharedPreferencesGateway.saveToDisk(
            'chatId',
            unpackedDialogMessages.data.first.id,
          );

          final List<Future<Dialog>> dialogFutures =
              unpackedDialogMessages.data.map((dialog) async {
            final onNewMessageController =
                await getControllerForChat(dialog.id);

            return DialogImpl(
              topMessage: dialog.message.text,
              id: dialog.id,
              onNewMessage: onNewMessageController.stream,
            );
          }).toList();

          // Await all futures to complete
          final dialogs = await Future.wait(dialogFutures);

          log.info('Fetched dialogs: ${dialogs.length}');

          return dialogs.first;
        } else {
          log.info('No chat dialogs were returned in the response');
          return DialogImpl.initial();
        }
      } else if (response.err.hasMessage()) {
        final (requestId, errorMessage) = (
          response.id,
          response.err.message,
        );

        log.warning('Failed to unpack chat list for request ID: $requestId '
            '$errorMessage');
        final statusCode = ErrorHelper.getCodeFromMessage(errorMessage);

        return DialogImpl(
          error: CallError(
            statusCode: statusCode,
            errorMessage: response.err.message,
          ),
          topMessage: 'ERROR',
          id: response.id,
          onNewMessage: Stream<DialogMessageResponse>.empty(),
        );
      } else {
        log.warning('Failed to unpack chat list for request ID: $requestId');
      }
    } catch (err) {
      log.severe(
        'Error fetching chat dialogs with request ID: $requestId',
      );
    }
    return DialogImpl.initial();
  }

  /// Stream transformer that converts a stream of data chunks into a stream of UploadMedia messages.
  /// Firstly adding name/type and then bytes
  Stream<UploadMedia> uploadMediaStream({
    required Stream<List<int>> data,
    required String name,
    required String type,
  }) async* {
    log.info(
        'Starting to stream UploadMedia with file name: $name and type: $type');

    yield UploadMedia(
      file: InputFile(
        name: name,
        type: type,
      ),
    );

    await for (var bytes in data) {
      log.fine('Streaming data chunk of size: ${bytes.length} bytes.');
      yield UploadMedia(data: bytes);
    }

    log.info('Completed streaming UploadMedia messages for file: $name');
  }

  @override
  Stream<MediaFileResponse> downloadFile({
    required String fileId,
  }) {
    StreamController<MediaFileResponse> getFileController = StreamController();
    getFileFromServer(fileId: fileId, controller: getFileController);
    return getFileController.stream;
  }

  Future<StreamController<MediaFileResponse>> getFileFromServer({
    required String fileId,
    required StreamController<MediaFileResponse> controller,
  }) async {
    final mediaStream =
        _grpcChannel.mediaStorageStub.getFile(GetFileRequest(fileId: fileId));
    MediaFileResponse? file;
    fixnum.Int64 offset = fixnum.Int64(0);

    try {
      await for (MediaFile mediaFile in mediaStream) {
        if (mediaFile.file.name.isNotEmpty && file == null) {
          file = MediaFileResponse(
            size: mediaFile.file.size.toInt(),
            name: mediaFile.file.name,
            type: mediaFile.file.type,
            id: mediaFile.file.id,
          );
          controller.add(file);
          log.info(
              "Initialized file download for '${file.name}' with ID '${file.id}', expected size: ${file.size} bytes.");
        }

        if (file != null) {
          file.bytes.clear();
          file.bytes.addAll(mediaFile.data);
          offset += mediaFile.data.length;
          log.info(
              "Received ${mediaFile.data.length} bytes for file '${file.name}'; Total received: $offset bytes.");
          controller.add(file);
        }
      }

      if (file != null) {
        if (offset == fixnum.Int64(file.size)) {
          log.info(
              "Successfully downloaded file '${file.name}' with full size: ${file.size} bytes.");
        } else {
          log.warning(
              "Downloaded file '${file.name}' has a size mismatch. Expected: ${file.size} bytes, Received: $offset bytes.");
        }
      }
    } on GrpcError catch (err) {
      log.warning(
          "GrpcError encountered while downloading file '${file?.name ?? "unknown"}': ${err.message}");
      if (file != null && offset < fixnum.Int64(file.size)) {
        log.info(
            "Attempting to resume file download for '${file.name}' from offset $offset.");

        await downloadMediaFromOffset(
          fileId: fileId,
          file: file,
          offset: offset,
          controller: controller,
        );
      } else {
        log.warning("Failed to download file due to GrpcError: $err");
      }
    } finally {
      if (!controller.isClosed) {
        controller.close();
      }
    }

    return controller;
  }

  Future<void> downloadMediaFromOffset({
    required String fileId,
    required MediaFileResponse file,
    required fixnum.Int64 offset,
    required StreamController<MediaFileResponse> controller,
    int retries = 5,
  }) async {
    for (int attempt = 0; attempt < retries; attempt++) {
      try {
        final resumedMedia = _grpcChannel.mediaStorageStub.getFile(
          GetFileRequest(
            fileId: fileId,
            offset: offset,
          ),
        );

        await for (MediaFile mediaFile in resumedMedia) {
          file.bytes.clear();
          file.bytes.addAll(mediaFile.data);
          offset += mediaFile.data.length;
          log.info(
              "Resumed download, received ${mediaFile.data.length} bytes; Total resumed: $offset bytes.");
          controller.add(file);
        }

        log.info("Resumed and completed file download for '${file.name}'.");
        return;
      } on GrpcError catch (err) {
        log.warning(
            "GrpcError encountered while resuming download for '${file.name}': ${err.message}");
        if (attempt == retries - 1) {
          controller.addError(err);
        }
      }
    }
  }

  /// Listens for all messages from server
  Future<void> listenToMessages() async {
    await _sharedPreferencesGateway.init();
    final userId = await _sharedPreferencesGateway.readUserId();
    _grpcConnect.updateStream.listen(
      (update) async {
        final chatId = update.message.chat.id;
        final controller = _onNewMessageControllers[chatId];

        if (controller != null) {
          final messageType =
              MessageHelper.determineMessageTypeResponse(update);

          final dialogMessage = switch (messageType) {
            MessageType.outcomingMedia ||
            MessageType.incomingMedia =>
              ResponseDialogMessageBuilder()
                  .setDialogMessageContent(update.message.text)
                  .setRequestId(update.id)
                  .setMessageId(update.message.id.toInt())
                  .setUserUd(userId ?? '')
                  .setChatId(chatId)
                  .setUpdate(update)
                  .setFile(
                    MediaFileResponse(
                      id: update.message.file.id,
                      type: update.message.file.type,
                      name: update.message.file.name,
                      bytes: [],
                      size: update.message.file.size.toInt(),
                    ),
                  )
                  .build(),
            MessageType.outcomingMessage ||
            MessageType.incomingMessage =>
              ResponseDialogMessageBuilder()
                  .setDialogMessageContent(update.message.text)
                  .setRequestId(update.id)
                  .setMessageId(update.message.id.toInt())
                  .setUserUd(userId ?? '')
                  .setChatId(chatId)
                  .setUpdate(update)
                  .setFile(MediaFileResponse.initial())
                  .build()
          };

          controller.add(dialogMessage);
        }
      },
      onError: (error) {
        log.severe("Error while listening to messages: $error");
      },
      onDone: () {
        log.severe("Error while listening to messages: stream is done");
      },
    );
  }

  /// Sends a message to the chat service and waits for a response.
  @override
  Future<DialogMessageResponse> sendMessage({
    required DialogMessageRequest message,
    required String chatId,
  }) async {
    try {
      final userId = await _sharedPreferencesGateway.readUserId();
      final messageType = MessageHelper.determineMessageTypeRequest(message);

      log.info("Sending message of type $messageType for user $userId");

      final request = await _buildSendMessageRequest(
        message,
        userId ?? '',
        messageType,
      );

      _grpcConnect.sendRequest(request);

      return await _sendMessageResponse(
        message.requestId,
        userId ?? '',
        _handleSendMessageResponse,
        _handleSendMessageError,
      ).timeout(const Duration(seconds: 5));
    } on GrpcError catch (err) {
      log.severe("GRPC Error on sendMessage: ${err.message}");

      return ErrorDialogMessageBuilder()
          .setDialogMessageContent(err.toString())
          .setRequestId(message.requestId)
          .build();
    } on TimeoutException {
      log.warning("Timeout exception on sendMessage");

      return ErrorDialogMessageBuilder()
          .setDialogMessageContent('Message was not sent due to timeout')
          .setRequestId(message.requestId)
          .build();
    }
  }

  //LISTEN FOR RESPONSE BY EQUAL REQUEST ID
  // Method to send message and use the typedefs for handling responses and errors
  Future<DialogMessageResponse> _sendMessageResponse(
    String requestId,
    String userId,
    SendMessageResponseHandler handleResponse,
    SendMessageErrorHandler handleError,
  ) {
    final completer = Completer<DialogMessageResponse>();
    StreamSubscription<portal.Response>? streamSubscription;

    streamSubscription = _grpcConnect.responseStream
        .where((response) => response.id == requestId)
        .listen(
          (response) => handleResponse(response, completer, userId),
          onError: (error) => handleError(error, completer, requestId),
          onDone: () => streamSubscription?.cancel(),
          cancelOnError: true,
        );
    return completer.future;
  }

  Future<void> _handleSendMessageResponse(
    portal.Response response,
    Completer<DialogMessageResponse> completer,
    String userId,
  ) async {
    if (response.data.canUnpackInto(UpdateNewMessage())) {
      final unpackedMessage = response.data.unpackInto(UpdateNewMessage());
      final messageType =
          MessageHelper.determineMessageTypeResponse(unpackedMessage);
      switch (messageType) {
        case MessageType.outcomingMessage:
          log.info(
              "Handled response for message type $MessageType.outcomingMessage");
          completer.complete(
            ResponseDialogMessageBuilder()
                .setDialogMessageContent(unpackedMessage.message.text)
                .setRequestId(unpackedMessage.id)
                .setUserUd(userId)
                .setMessageId(unpackedMessage.message.id.toInt())
                .setChatId(unpackedMessage.message.chat.id)
                .setUpdate(unpackedMessage)
                .setFile(MediaFileResponse.initial())
                .build(),
          );
          break;
        case MessageType.outcomingMedia:
          log.info(
              "Handled response for message type $MessageType.outcomingMedia");
          completer.complete(
            ResponseDialogMessageBuilder()
                .setDialogMessageContent(unpackedMessage.message.text)
                .setRequestId(unpackedMessage.id)
                .setMessageId(unpackedMessage.message.id.toInt())
                .setUserUd(userId)
                .setChatId(unpackedMessage.message.chat.id)
                .setUpdate(unpackedMessage)
                .setFile(
                  MediaFileResponse(
                    id: unpackedMessage.message.file.id,
                    type: unpackedMessage.message.file.type,
                    name: unpackedMessage.message.file.name,
                    size: unpackedMessage.message.file.size.toInt(),
                  ),
                )
                .build(),
          );
          break;
        default:
          log.warning("Unhandled message type: $messageType");
      }
    } else if (response.err.hasMessage()) {
      final (recordId, errorMessage) = (
        response.id,
        response.err.message,
      );

      log.warning(
          'Failed to send Message for requestId: $recordId: $errorMessage');
      final statusCode = ErrorHelper.getCodeFromMessage(errorMessage);
      completer.complete(
        DialogMessageResponse.error(
          requestId: response.id,
          error: CallError(
            statusCode: statusCode,
            errorMessage: response.err.message,
          ),
        ),
      );
    }
  }

  // Method to handle send message error using the typedef
  void _handleSendMessageError(
    Object error,
    Completer<DialogMessageResponse> completer,
    String requestId,
  ) {
    final errorMessage =
        error is GrpcError ? error.message : 'Unknown error occurred';
    log.severe("Error on handling message response: $errorMessage");

    completer.complete(
      ErrorDialogMessageBuilder()
          .setDialogMessageContent(errorMessage ?? '')
          .setRequestId(requestId)
          .build(),
    );
  }

  Future<portal.Request> _buildSendMessageRequest(
    DialogMessageRequest message,
    String userId,
    MessageType messageType,
  ) async {
    log.info("Building request for message type $messageType");

    final baseRequest = SendMessageRequest(
      text: message.content,
    );

    if (messageType == MessageType.outcomingMedia) {
      log.info("Uploading media for message.");
      final uploadedFile = await _grpcChannel.mediaStorageStub.uploadFile(
        uploadMediaStream(
          data: message.file.data,
          name: message.file.name,
          type: message.file.type,
        ),
      );
      baseRequest.file = file.File(
        id: uploadedFile.id,
        name: uploadedFile.name,
        type: uploadedFile.type,
      );
    }

    return portal.Request(
      path: Constants.sendMessagePath,
      data: Any.pack(baseRequest),
      id: message.requestId,
    );
  }

  @override
  Future<List<DialogMessageResponse>> fetchUpdates({
    int? limit,
    int? offset,
    required String chatId,
  }) async {
    return await _fetchMessages(
      path: Constants.chatUpdatesPath,
      chatId: chatId,
      limit: limit,
      offset: offset,
    );
  }

  @override
  Future<List<DialogMessageResponse>> fetchMessages({
    int? limit,
    int? offset,
    required String chatId,
  }) async {
    return await _fetchMessages(
      path: Constants.chatHistoryPath,
      chatId: chatId,
      limit: limit,
      offset: offset,
    );
  }

  Future<List<DialogMessageResponse>> _fetchMessages({
    required String path,
    required String chatId,
    int? limit,
    int? offset,
  }) async {
    final userId = await _sharedPreferencesGateway.readUserId();
    final requestId = uuid.v4();

    log.info(
        'Fetching messages for chatId: $chatId with limit: ${limit ?? 20}');

    final int64Offset = fixnum.Int64(offset ?? 0);
    final fetchMessagesRequest = ChatMessagesRequest(
      chatId: chatId,
      limit: limit ?? 20,
      offset:
          offset != null ? ChatMessagesRequest_Offset(id: int64Offset) : null,
    );
    final request = portal.Request(
      path: path,
      data: Any.pack(fetchMessagesRequest),
      id: requestId,
    );

    try {
      await _grpcConnect.sendRequest(request);
      final response = await _grpcConnect.responseStream
          .firstWhere((response) => response.id == requestId)
          .timeout(const Duration(seconds: 5));

      if (response.data.canUnpackInto(ChatMessages())) {
        final unpackedDialogMessages = response.data.unpackInto(ChatMessages());

        final messagesBuilder = MessagesListMessageBuilder()
            .setChatId(chatId)
            .setUserId(userId ?? '')
            .setMessages(unpackedDialogMessages.messages)
            .setPeers(unpackedDialogMessages.peers);

        final messages = messagesBuilder.build();

        log.info(
            'Successfully fetched ${messages.length} messages for chatId: $chatId');
        return messages;
      } else if (response.err.hasMessage()) {
        final (recordId, errorMessage) = (
          response.id,
          response.err.message,
        );

        log.warning(
            'Failed to unpack dialog messages for requestId: $recordId: $errorMessage');
        final statusCode = ErrorHelper.getCodeFromMessage(errorMessage);

        return [
          DialogMessageResponse.error(
            requestId: response.id,
            error: CallError(
              statusCode: statusCode,
              errorMessage: response.err.message,
            ),
          ),
        ];
      } else {
        return [];
      }
    } catch (e) {
      if (e is TimeoutException) {
        log.severe('Timeout while fetching messages for chatId: $chatId');
      } else {
        log.severe(
            'An error occurred while fetching messages for chatId: $chatId');
      }
      return [];
    }
  }

  @override
  Future<void> reconnectToStream() async {
    await _grpcConnect.reconnect();
  }

  @override
  Future<Channel> getChannel() async {
    return ChannelImpl();
  }

  @override
  StreamController<ChannelStatus> onChannelStatusChange() {
    return _grpcConnect.chanelStatusStream;
  }

  @override
  StreamController<Connect> onConnectStreamStatusChange() {
    return _grpcConnect.connectStatusStream;
  }

  @override
  StreamController<CallError> onError() {
    return _grpcConnect.errorStream;
  }
}
