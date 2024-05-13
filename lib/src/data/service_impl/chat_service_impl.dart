import 'dart:async';

import 'package:fixnum/fixnum.dart' as fixnum;
import 'package:grpc/grpc.dart';
import 'package:grpc/grpc_or_grpcweb.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';
import 'package:webitel_portal_sdk/src/backbone/logger.dart';
import 'package:webitel_portal_sdk/src/backbone/message_helper.dart';
import 'package:webitel_portal_sdk/src/builder/error_dialog_message_builder.dart';
import 'package:webitel_portal_sdk/src/builder/messages_list_message_builder.dart';
import 'package:webitel_portal_sdk/src/builder/response_dialog_message_builder.dart';
import 'package:webitel_portal_sdk/src/data/dialog_impl.dart';
import 'package:webitel_portal_sdk/src/data/grpc/grpc_channel.dart';
import 'package:webitel_portal_sdk/src/data/grpc/grpc_connect.dart';
import 'package:webitel_portal_sdk/src/data/shared_preferences/shared_preferences_gateway.dart';
import 'package:webitel_portal_sdk/src/domain/entities/connect.dart';
import 'package:webitel_portal_sdk/src/domain/entities/dialog_message/dialog_message_request.dart';
import 'package:webitel_portal_sdk/src/domain/entities/dialog_message/dialog_message_response.dart';
import 'package:webitel_portal_sdk/src/domain/entities/error.dart';
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
import 'package:webitel_portal_sdk/src/generated/portal/messages.pb.dart';
import 'package:webitel_portal_sdk/webitel_portal_sdk.dart';

@LazySingleton(as: ChatService)
class ChatServiceImpl implements ChatService {
  final GrpcChannel _grpcChannel;
  final GrpcConnect _grpcConnect;
  final SharedPreferencesGateway _sharedPreferencesGateway;

  final uuid = Uuid();
  final log = CustomLogger.getLogger('ChatServiceImpl');
  final Map<String, StreamController<DialogMessageResponseEntity>>
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
    log.info("Initializing Chat service...");

    listenToMessages();
    log.info("Message listener setup complete.");

    onConnectStreamStatusChange();
    log.info("Connection stream status change listener activated.");

    onChannelStatusChange();
    log.info("Channel status change listener enabled.");

    onError();
    log.info("Error handling is configured.");

    log.info("Chat service initialization complete.");
  }

  @override
  Future<List<Dialog>> fetchDialogs() async {
    final requestId = uuid.v4();
    log.info('Initiating fetch for chat dialogs with request ID: $requestId');
    List<Dialog> dialogs = [];
    await _sharedPreferencesGateway.init();
    final chatDialogsRequest = dialog.ChatDialogsRequest();
    final request = portal.Request(
      path: '/webitel.portal.ChatMessages/ChatDialogs',
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
          for (var dialog in unpackedDialogMessages.data) {
            await getControllerForChat(dialog.id);
          }
          for (var dialog in unpackedDialogMessages.data) {
            final controller = _onNewMessageControllers[dialog.id]!; //TODO
            dialogs.add(
              DialogImpl(
                topMessage: dialog.message.text,
                id: dialog.id,
                onNewMessage: controller.stream,
              ),
            );
          }
          log.info('Fetched dialogs: ${dialogs.length}');
          return dialogs;
        } else {
          log.info('No chat dialogs were returned in the response');
          return [];
        }
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
    List<Dialog> dialogs = [];
    await _sharedPreferencesGateway.init();
    final chatDialogsRequest = dialog.ChatDialogsRequest();
    final request = portal.Request(
      path: '/webitel.portal.ChatMessages/ChatDialogs',
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
          for (var dialog in unpackedDialogMessages.data) {
            await getControllerForChat(dialog.id);
          }
          for (var dialog in unpackedDialogMessages.data) {
            final controller = _onNewMessageControllers[dialog.id]!; //TODO
            dialogs.add(
              DialogImpl(
                topMessage: dialog.message.text,
                id: dialog.id,
                onNewMessage: controller.stream,
              ),
            );
          }
          log.info('Fetched dialogs: ${dialogs.length}');
          return dialogs.first;
        } else {
          log.info('No chat dialogs were returned in the response');
          return DialogImpl.initial();
        }
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
  Stream<UploadMedia> stream({
    required Stream<List<int>> data,
    required String name,
    required String type,
  }) async* {
    log.info(
        'Starting to stream UploadMedia with file name: $name and type: $type');
    yield UploadMedia(file: InputFile(name: name, type: type));

    await for (var bytes in data) {
      log.fine('Streaming data chunk of size: ${bytes.length} bytes.');
      yield UploadMedia(data: bytes);
    }

    log.info('Completed streaming UploadMedia messages for file: $name');
  }

  //Get controller for specific chat by chatId or create one if absent
  Future<StreamController<DialogMessageResponseEntity>> getControllerForChat(
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
        return StreamController<DialogMessageResponseEntity>.broadcast();
      },
    );
  }

  //Downloading media file if we receive incoming media message
  Future<MediaFileResponseEntity?> downloadMediaFile(
      {required String fileId}) async {
    final mediaStream =
        _grpcChannel.mediaStorageStub.getFile(GetFileRequest(fileId: fileId));

    MediaFileResponseEntity? file;
    fixnum.Int64 offset = fixnum.Int64(0);

    try {
      await for (MediaFile mediaFile in mediaStream) {
        if (mediaFile.file.name.isNotEmpty && file == null) {
          file = MediaFileResponseEntity(
            size: mediaFile.file.size.toInt(),
            name: mediaFile.file.name,
            type: mediaFile.file.type,
            id: mediaFile.file.id,
            bytes: [],
          );
          log.info(
              "Initialized file download for '${file.name}' with ID '${file.id}', expected size: ${file.size} bytes.");
        } else if (file != null) {
          file.bytes.addAll(mediaFile.data);
          offset += mediaFile.data.length;
          log.info(
              "Received ${mediaFile.data.length} bytes for file '${file.name}'; Total received: $offset bytes.");
        }
      }
      if (file != null && offset == file.size) {
        log.info(
            "Successfully downloaded file '${file.name}' with full size: ${file.size} bytes.");
      }
    } on GrpcError catch (err) {
      log.warning(
          "GrpcError encountered while downloading file '${file?.name ?? "unknown"}': ${err.message}");
      if (file != null && offset < file.size) {
        log.info(
            "Attempting to resume file download for '${file.name}' from offset $offset.");

        await downloadMediaFromOffset(
          fileId: fileId,
          file: file,
          offset: offset,
        );
      }
    }

    return file;
  }

  /// Resumes the download of a media file from a specified offset.
  Future<void> downloadMediaFromOffset({
    required String fileId,
    required MediaFileResponseEntity file,
    required fixnum.Int64 offset,
  }) async {
    final resumedMedia = _grpcChannel.mediaStorageStub.getFile(
      GetFileRequest(
        fileId: fileId,
        offset: offset,
      ),
    );

    await for (MediaFile mediaFile in resumedMedia) {
      file.bytes.addAll(mediaFile.data);
      offset += mediaFile.data.length;
      log.info(
          "Resumed download, received ${mediaFile.data.length} bytes; Total resumed: $offset bytes.");
    }
    log.info("Resumed and completed file download for '${file.name}'.");
  }

  /// Listens for all messages from server
  Future<void> listenToMessages() async {
    await _sharedPreferencesGateway.init();
    final userId = await _sharedPreferencesGateway.readUserId();
    _grpcConnect.updateStream.listen((update) async {
      log.info(
          "Message Controllers length: ${_onNewMessageControllers.length}");
      if (_onNewMessageControllers.containsKey(update.message.chat.id)) {
        final messageController =
            _onNewMessageControllers[update.message.chat.id];
        final messageType = MessageHelper.determineMessageTypeResponse(update);
        log.info("Received message update of type: $messageType");
        switch (messageType) {
          case MessageType.outcomingMedia:
            log.info(
                "Processing ${messageType.toString()} message: ${update.message.text}");
            final dialogMessage = ResponseDialogMessageBuilder()
                .setDialogMessageContent(update.message.text)
                .setRequestId(update.id)
                .setMessageId(update.id)
                .setUserUd(userId ?? '')
                .setId(update.message.id.toInt())
                .setChatId(update.message.chat.id)
                .setUpdate(update)
                .setFile(
                  MediaFileResponseEntity(
                    id: update.message.file.id,
                    type: update.message.file.type,
                    name: update.message.file.name,
                    bytes: [],
                    size: update.message.file.size.toInt(),
                  ),
                )
                .build();
            print(dialogMessage.file.name);

            messageController?.add(dialogMessage);

          case MessageType.outcomingMessage:
            log.info(
                "Processing ${messageType.toString()} message: ${update.message.text}");
            final dialogMessage = ResponseDialogMessageBuilder()
                .setDialogMessageContent(update.message.text)
                .setId(update.message.id.toInt())
                .setRequestId(update.id)
                .setMessageId(update.id)
                .setUserUd(userId ?? '')
                .setChatId(update.message.chat.id)
                .setUpdate(update)
                .setFile(
                  MediaFileResponseEntity(
                    id: update.message.file.id,
                    type: update.message.file.type,
                    name: update.message.file.name,
                    bytes: [],
                    size: update.message.file.size.toInt(),
                  ),
                )
                .build();

            messageController?.add(dialogMessage);

          case MessageType.incomingMedia:
            final file =
                await downloadMediaFile(fileId: update.message.file.id);

            final dialogMessage = ResponseDialogMessageBuilder()
                .setDialogMessageContent(update.message.text)
                .setRequestId(update.id)
                .setMessageId(update.id)
                .setUserUd(userId ?? '')
                .setId(update.message.id.toInt())
                .setChatId(update.message.chat.id)
                .setUpdate(update)
                .setFile(
                  MediaFileResponseEntity(
                    id: file != null ? file.id : '',
                    type: file != null ? file.type : '',
                    name: file != null ? file.name : '',
                    bytes: file != null ? file.bytes : [],
                    size: file != null ? file.size.toInt() : 0,
                  ),
                )
                .build();

            messageController?.add(dialogMessage);

          case MessageType.incomingMessage:
            log.info(
                "Processing ${messageType.toString()} message: ${update.message.text}");

            final dialogMessage = ResponseDialogMessageBuilder()
                .setDialogMessageContent(update.message.text)
                .setRequestId(update.id)
                .setMessageId(update.id)
                .setUserUd(userId ?? '')
                .setId(update.message.id.toInt())
                .setChatId(update.message.chat.id)
                .setUpdate(update)
                .setFile(MediaFileResponseEntity.initial())
                .build();

            messageController?.add(dialogMessage);
        }
      }
    }, onError: (error) {
      log.severe("Error while listening to messages: $error");
    }, onDone: () {
      log.severe("Error while listening to messages: stream is done");
    });
  }

  /// Sends a message to the chat service and waits for a response.
  @override
  Future<DialogMessageResponseEntity> sendMessage({
    required DialogMessageRequestEntity message,
    required String chatId,
  }) async {
    try {
      final userId = await _sharedPreferencesGateway.readUserId();
      final messageType = MessageHelper.determineMessageTypeRequest(message);
      log.info("Sending message of type $messageType for user $userId");
      final request = await _buildRequest(message, userId ?? '', messageType);

      _grpcConnect.sendRequest(request);
      return await _listenForResponse(message.requestId, userId ?? '')
          .timeout(const Duration(seconds: 5));
    } on GrpcError catch (err) {
      log.severe("GRPC Error on sendMessage: ${err.toString()}");
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
  Future<DialogMessageResponseEntity> _listenForResponse(
      String requestId, String userId) {
    final completer = Completer<DialogMessageResponseEntity>();
    StreamSubscription<portal.Response>? streamSubscription;

    streamSubscription = _grpcConnect.responseStream
        .where((response) => response.id == requestId)
        .listen(
          (response) => _handleResponse(response, completer, userId),
          onError: (error) => _handleError(error, completer, requestId),
          onDone: () => streamSubscription?.cancel(),
          cancelOnError: true,
        );
    return completer.future;
  }

  Future<void> _handleResponse(
    portal.Response response,
    Completer<DialogMessageResponseEntity> completer,
    String userId,
  ) async {
    if (response.data.canUnpackInto(UpdateNewMessage())) {
      final unpackedMessage = response.data.unpackInto(UpdateNewMessage());
      final messageType =
          MessageHelper.determineMessageTypeResponse(unpackedMessage);

      switch (messageType) {
        case MessageType.outcomingMessage:
          log.info("Handled response for message type $messageType");
          final dialogMessage = ResponseDialogMessageBuilder()
              .setDialogMessageContent(unpackedMessage.message.text)
              .setRequestId(unpackedMessage.id)
              .setId(unpackedMessage.message.id.toInt())
              .setUserUd(userId)
              .setMessageId(unpackedMessage.id)
              .setChatId(unpackedMessage.message.chat.id)
              .setUpdate(unpackedMessage)
              .setFile(MediaFileResponseEntity.initial())
              .build();
          completer.complete(dialogMessage);
          break;

        case MessageType.outcomingMedia:
          log.info("Handled response for message type $messageType");
          final dialogMessage = ResponseDialogMessageBuilder()
              .setDialogMessageContent(unpackedMessage.message.text)
              .setRequestId(unpackedMessage.id)
              .setMessageId(unpackedMessage.id)
              .setUserUd(userId)
              .setId(unpackedMessage.message.id.toInt())
              .setChatId(unpackedMessage.message.chat.id)
              .setUpdate(unpackedMessage)
              .setFile(
                MediaFileResponseEntity(
                  id: unpackedMessage.message.file.id,
                  type: unpackedMessage.message.file.type,
                  name: unpackedMessage.message.file.name,
                  bytes: [],
                  size: unpackedMessage.message.file.size.toInt(),
                ),
              )
              .build();
          completer.complete(dialogMessage);
          break;
        default:
          break;
      }
    } else if (response.err.hasMessage()) {
      completer.complete(ErrorDialogMessageBuilder()
          .setDialogMessageContent(response.err.message)
          .setRequestId(response.id)
          .build());
    }
  }

  void _handleError(Object error,
      Completer<DialogMessageResponseEntity> completer, String requestId) {
    final errorMessage =
        error is GrpcError ? error.toString() : 'Unknown error occurred';
    log.severe("Error on handling message response: $errorMessage");
    completer.complete(
      ErrorDialogMessageBuilder()
          .setDialogMessageContent(errorMessage)
          .setRequestId(requestId)
          .build(),
    );
  }

  Future<portal.Request> _buildRequest(DialogMessageRequestEntity message,
      String userId, MessageType messageType) async {
    log.info("Building request for message type $messageType");

    final baseRequest = SendMessageRequest(
      text: message.dialogMessageContent,
    );

    if (messageType == MessageType.outcomingMedia) {
      log.info("Uploading media for message.");
      final uploadedFile = await _grpcChannel.mediaStorageStub.uploadFile(
        stream(
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
      path: '/webitel.portal.ChatMessages/SendMessage',
      data: Any.pack(baseRequest),
      id: message.requestId,
    );
  }

  //FETCH MESSAGES
  @override
  Future<List<DialogMessageResponseEntity>> fetchMessages({
    int? limit,
    int? offset,
    required String chatId,
  }) async {
    final userId = await _sharedPreferencesGateway.readUserId();
    final requestId = uuid.v4();
    log.info(
        'Fetching messages for chatId: $chatId with limit: ${limit ?? 20}');
    final int64Offset = fixnum.Int64(offset ?? 0);
    final fetchMessagesRequest = ChatMessagesRequest(
      chatId: chatId,
      limit: limit ?? 20,
      offset: offset != null
          ? ChatMessagesRequest_Offset(
              id: int64Offset,
            )
          : null,
    );
    final request = portal.Request(
      path: '/webitel.portal.ChatMessages/ChatHistory',
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
      } else {
        log.severe(
            'Failed to unpack dialog messages for requestId: $requestId');
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

  //FETCH MESSAGES REVERSED FOR PAGINATION
  @override
  Future<List<DialogMessageResponseEntity>> fetchUpdates({
    int? limit,
    int? offset,
    required String chatId,
  }) async {
    final userId = await _sharedPreferencesGateway.readUserId();
    final requestId = uuid.v4();
    log.info(
        'Fetching message updates for chatId: $chatId with limit: ${limit ?? 20}');
    final int64Offset = fixnum.Int64(offset ?? 0);
    final fetchMessageUpdatesRequest = ChatMessagesRequest(
      chatId: chatId,
      limit: limit ?? 20,
      offset:
          offset != null ? ChatMessagesRequest_Offset(id: int64Offset) : null,
    );
    final request = portal.Request(
      path: '/webitel.portal.ChatMessages/ChatUpdates',
      data: Any.pack(fetchMessageUpdatesRequest),
      id: requestId,
    );

    try {
      _grpcConnect.sendRequest(request);
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
            'Successfully fetched ${messages.length} message updates for chatId: $chatId');
        return messages;
      } else {
        log.severe(
            'Failed to unpack dialog messages for requestId: $requestId');
        return [];
      }
    } catch (e) {
      if (e is TimeoutException) {
        log.severe(
            'Timeout while fetching message updates for chatId: $chatId');
      } else {
        log.severe(
            'An error occurred while fetching message updates for chatId: $chatId');
      }
      return [];
    }
  }

  @override
  StreamController<ChannelStatus> onChannelStatusChange() {
    return _grpcConnect.chanelStatusStream;
  }

  @override
  StreamController<ConnectEntity> onConnectStreamStatusChange() {
    return _grpcConnect.connectStatusStream;
  }

  @override
  StreamController<ErrorEntity> onError() {
    return _grpcConnect.errorStream;
  }
}
