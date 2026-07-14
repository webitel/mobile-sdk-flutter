import 'dart:async';
import 'dart:collection';
import 'dart:io';

import 'package:fixnum/fixnum.dart' as fixnum;
import 'package:grpc/grpc.dart';
import 'package:grpc/grpc_or_grpcweb.dart';
import 'package:protobuf/well_known_types/google/protobuf/any.pb.dart';
import 'package:retry/retry.dart';
import 'package:uuid/uuid.dart';
import 'package:webitel_portal_sdk/src/data/builder/error_dialog_message.dart';
import 'package:webitel_portal_sdk/src/data/builder/messages_list_message.dart';
import 'package:webitel_portal_sdk/src/data/builder/response_dialog_message.dart';
import 'package:webitel_portal_sdk/src/data/channel_impl.dart';
import 'package:webitel_portal_sdk/src/data/constants/constants.dart';
import 'package:webitel_portal_sdk/src/data/constants/error_codes.dart';
import 'package:webitel_portal_sdk/src/data/dialog_impl.dart';
import 'package:webitel_portal_sdk/src/data/download_impl.dart';
import 'package:webitel_portal_sdk/src/data/grpc/grpc_channel.dart';
import 'legacy_grpc_connect.dart';
import 'package:webitel_portal_sdk/src/data/helper/error.dart';
import 'package:webitel_portal_sdk/src/data/helper/message.dart';
import 'package:webitel_portal_sdk/src/data/logger/logger.dart';
import 'package:webitel_portal_sdk/src/data/shared_preferences/shared_preferences_gateway.dart';
import 'package:webitel_portal_sdk/src/data/upload_impl.dart';
import 'package:webitel_portal_sdk/src/domain/entities/button.dart';
import 'package:webitel_portal_sdk/src/domain/entities/channel.dart';
import 'package:webitel_portal_sdk/src/domain/entities/connect.dart';
import 'package:webitel_portal_sdk/src/domain/entities/download.dart';
import 'package:webitel_portal_sdk/src/domain/entities/keyboard.dart';
import 'package:webitel_portal_sdk/src/domain/entities/progress.dart';
import 'package:webitel_portal_sdk/src/domain/entities/upload.dart';
import 'package:webitel_portal_sdk/src/domain/entities/upload_task.dart';
import 'package:webitel_portal_sdk/src/domain/services/chat_service.dart';
import 'package:webitel_portal_sdk/src/generated/chat/messages/dialog.pb.dart'
    as dialog;
import 'package:webitel_portal_sdk/src/generated/chat/messages/history.pb.dart';
import 'package:webitel_portal_sdk/src/generated/chat/messages/message.pb.dart'
    as file;
import 'package:webitel_portal_sdk/src/generated/portal/connect.pb.dart'
    as portal;
import 'package:webitel_portal_sdk/src/generated/portal/media.pb.dart';
import 'package:webitel_portal_sdk/src/generated/portal/messages.pbgrpc.dart';
import 'package:webitel_portal_sdk/webitel_portal_sdk.dart';

/// Typedef for handling the response when a message is sent.
///
/// This typedef defines a function signature for handling the response from the
/// server when a message is sent. It takes a [portal.Response], a [Completer] for
/// the [DialogMessageResponse], and the [userId] of the user who sent the message.
///
/// [response] The response from the server.
/// [completer] The completer for the dialog message response.
/// [userId] The ID of the user who sent the message.
///
/// Returns a [Future] that completes when the handling is done.
typedef SendMessageResponseHandler = Future<void> Function(
  portal.Response response,
  Completer<DialogMessageResponse> completer,
  String userId,
);

/// Typedef for handling errors that occur when a message is sent.
///
/// This typedef defines a function signature for handling errors that occur
/// during the process of sending a message. It takes an [Object] representing the
/// error, a [Completer] for the [DialogMessageResponse], and the [requestId] of
/// the message that failed to send.
///
/// [error] The error that occurred.
/// [completer] The completer for the dialog message response.
/// [requestId] The ID of the request that failed.
///
/// This handler does not return any value.
typedef SendMessageErrorHandler = void Function(
  Object error,
  Completer<DialogMessageResponse> completer,
  String requestId,
);

/// Implementation of [ChatService] for handling chat operations.
final class LegacyChatServiceImpl implements ChatService {
  // Dependencies required for the chat service.
  final GrpcChannel _grpcChannel;
  final LegacyGrpcConnect _grpcConnect;
  final SharedPreferencesGateway _sharedPreferencesGateway;

  // Utility instances.
  final uuid = Uuid();

  final log = CustomLogger.getLogger('ChatServiceImpl');

  /// A map to manage StreamControllers for new message events, indexed by chat ID.
  /// Each chat ID maps to a StreamController that broadcasts [DialogMessageResponse] events.
  final Map<String, StreamController<DialogMessageResponse>>
      _onNewMessageControllers = {};

  /// A map to manage StreamControllers for new member added events, indexed by chat ID.
  /// Each chat ID maps to a StreamController that broadcasts [PortalChatMember] events.
  final Map<String, StreamController<PortalChatMember>>
      _onMemberAddedControllers = {};

  /// A map to manage StreamControllers for member left events, indexed by chat ID.
  /// Each chat ID maps to a StreamController that broadcasts [PortalChatMember] events.
  final Map<String, StreamController<PortalChatMember>>
      _onMemberLeftControllers = {};

  // Queue and state flag for uploads
  final Queue<UploadTask> _uploadQueue = Queue<UploadTask>();
  bool _isUploading = false;

  // Constructor for initializing the chat service with the required dependencies.
  LegacyChatServiceImpl(
    this._grpcChannel,
    this._grpcConnect,
    this._sharedPreferencesGateway,
  ) {
    initListeners();
  }

  /// Initializes various listeners for messages, connection status changes, and errors.
  void initListeners() {
    listenToMessages();
    listenToNewMemberAdded();
    listenToMemberLeft();

    log.info("Message listener setup complete.");

    onConnectStreamStatusChange();
    log.info("Connection stream status change listener activated.");

    onChannelStatusChange();
    log.info("Channel status change listener enabled.");

    onError();
    log.info("Error handling is configured.");
  }

  /// Get or create a [StreamController] for a specific chat member by chatId.
  ///
  /// [chatId] The ID of the chat for which the controller is requested.
  ///
  /// Returns a [StreamController] for [ChatMember].
  Future<StreamController<PortalChatMember>> getControllerForMemberAdded(
    String chatId,
  ) async {
    final controllerExists = _onMemberAddedControllers.containsKey(chatId);
    if (controllerExists) {
      log.info(
          'Retrieving existing controller for chat member with ID: $chatId');
    } else {
      log.info(
          'No controller found for chat member with ID: $chatId, creating a new one.');
    }

    return _onMemberAddedControllers.putIfAbsent(
      chatId,
      () {
        log.info(
            'New StreamController for ChatMember created for chat ID: $chatId');

        return StreamController<PortalChatMember>.broadcast();
      },
    );
  }

  /// Get or create a [StreamController] for a member left event by chatId.
  ///
  /// [chatId] The ID of the chat for which the controller is requested.
  ///
  /// Returns a [StreamController] for [PortalChatMember].
  Future<StreamController<PortalChatMember>> getControllerForMemberLeft(
    String chatId,
  ) async {
    final controllerExists = _onMemberLeftControllers.containsKey(chatId);
    if (controllerExists) {
      log.info(
          'Retrieving existing controller for member left with ID: $chatId');
    } else {
      log.info(
          'No controller found for member left with ID: $chatId, creating a new one.');
    }

    return _onMemberLeftControllers.putIfAbsent(
      chatId,
      () {
        log.info(
            'New StreamController for member left created for chat ID: $chatId');
        return StreamController<PortalChatMember>.broadcast();
      },
    );
  }

  /// Get or create a [StreamController] for a specific chat by chatId.
  ///
  /// [chatId] The ID of the chat for which the controller is requested.
  ///
  /// Returns a [StreamController] for [DialogMessageResponse].
  Future<StreamController<DialogMessageResponse>> getControllerForNewMessage(
    String chatId,
  ) async {
    final controllerExists = _onNewMessageControllers.containsKey(chatId);

    if (controllerExists) {
      log.info('Retrieving existing controller for chat ID: $chatId');
    } else {
      log.info('No controller found for chat ID: $chatId, creating a new one.');
    }

    return _onNewMessageControllers.putIfAbsent(
      chatId,
      () {
        log.info(
            'New StreamController for DialogMessageResponse created for chat ID: $chatId');

        return StreamController<DialogMessageResponse>.broadcast();
      },
    );
  }

  /// Fetches a list of dialogs.
  ///
  /// Returns a list of [Dialog] instances.
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
                await getControllerForNewMessage(dialog.id);

            final onNewMemberAddedController =
                await getControllerForMemberAdded(dialog.id);

            final bool isClosed =
                (dialog.left != 0 || (dialog.left == 0 && dialog.join == 0));

            final onMemberLeftController =
                await getControllerForMemberLeft(dialog.id);

            return DialogImpl(
              isClosed: isClosed,
              topMessage: dialog.message.text,
              id: dialog.id,
              onNewMessage: onNewMessageController.stream,
              onMemberAdded: onNewMemberAddedController.stream,
              onMemberLeft: onMemberLeftController.stream,
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
            isClosed: true,
            topMessage: 'ERROR',
            id: response.id,
            onNewMessage: Stream<DialogMessageResponse>.empty(),
            onMemberAdded: Stream<PortalChatMember>.empty(),
            onMemberLeft: Stream<PortalChatMember>.empty(),
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

  /// Fetches a specific service dialog.
  ///
  /// Returns a [Dialog] instance representing the service dialog.
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
                await getControllerForNewMessage(dialog.id);

            final onNewMemberAddedController =
                await getControllerForMemberAdded(dialog.id);

            final onMemberLeftController =
                await getControllerForMemberLeft(dialog.id);

            final bool isClosed =
                (dialog.left != 0 || (dialog.left == 0 && dialog.join == 0));

            return DialogImpl(
              isClosed: isClosed,
              topMessage: dialog.message.text,
              id: dialog.id,
              onNewMessage: onNewMessageController.stream,
              onMemberAdded: onNewMemberAddedController.stream,
              onMemberLeft: onMemberLeftController.stream,
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
          isClosed: true,
          id: response.id,
          onNewMessage: Stream<DialogMessageResponse>.empty(),
          onMemberAdded: Stream<PortalChatMember>.empty(),
          onMemberLeft: Stream<PortalChatMember>.empty(),
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

  // Add a task to the queue and start processing if not already uploading
  void _addToUploadQueue({
    required String mediaType,
    required String mediaName,
    required File file,
    String? pid,
    int? offset,
    required StreamController<UploadResponse> controller,
  }) {
    final completer = Completer<void>();
    _uploadQueue.add(
      UploadTask(
        mediaType: mediaType,
        mediaName: mediaName,
        file: file,
        pid: pid,
        offset: offset,
        controller: controller,
        completer: completer,
      ),
    );

    // Start processing the queue if not already uploading
    if (!_isUploading) {
      _processQueue();
    }
  }

  // Process the upload queue sequentially
  void _processQueue() {
    if (_uploadQueue.isEmpty) {
      _isUploading = false;
      return;
    }

    _isUploading = true;
    final task = _uploadQueue.removeFirst();

    final subscription = _grpcChannel.mediaStorageStub
        .upload(
      _uploadMediaStream(
        pid: task.pid,
        offset: task.offset,
        file: task.file,
        mediaName: task.mediaName,
        mediaType: task.mediaType,
        completer: task.completer,
      ),
    )
        .listen(
      (progress) {
        if (progress.hasPart()) {
          log.info('Upload progress: ${progress.part.size} bytes uploaded.');
          task.controller.add(
            UploadResponse(
              progress: Progress(
                progressSize: progress.part.size.toInt(),
                progressId: progress.part.pid,
              ),
            ),
          );
          if (!task.completer.isCompleted) {
            task.completer.complete();
          }
          task.completer =
              Completer<void>(); // Create a new completer for the next batch
        } else if (progress.hasStat()) {
          log.info('Upload completed for file: ${progress.stat.file.name}');
          task.controller.add(
            UploadResponse(
              id: progress.stat.file.id,
              type: progress.stat.file.type,
              name: progress.stat.file.name,
              size: progress.stat.file.size.toInt(),
            ),
          );
        }
      },
      onError: (error) {
        log.severe('Upload error: $error');
        final callError = CallError(
          statusCode: 'UPLOAD_ERROR',
          errorMessage: error.toString(),
        );
        task.controller.addError(callError);
        task.controller.close();
        _processQueue(); // Continue to the next task in the queue
      },
      onDone: () {
        log.info('Upload stream closed.');
        task.controller.close();
        _processQueue(); // Continue to the next task in the queue
      },
      cancelOnError: true,
    );

    // Set the subscription in the upload object to manage cancellation
    final upload = UploadImpl(
      onProgress: task.controller,
      offset: task.offset ?? 0,
    );
    upload.setSubscription(subscription);
  }

  @override
  Upload uploadFile({
    required String mediaType,
    required String mediaName,
    required File file,
    String? pid,
    int? offset,
  }) {
    // Create a StreamController for managing upload progress
    final StreamController<UploadResponse> controller =
        StreamController<UploadResponse>();

    _addToUploadQueue(
      mediaType: mediaType,
      mediaName: mediaName,
      file: file,
      pid: pid,
      offset: offset,
      controller: controller,
    );

    return UploadImpl(
      onProgress: controller,
      offset: 0,
    );
  }

  Stream<UploadRequest> _uploadMediaStream({
    required File file,
    required String mediaName,
    required String mediaType,
    required Completer<void> completer,
    String? pid,
    int? offset,
  }) async* {
    log.info('Starting upload stream for file: $mediaName of type: $mediaType');

    // Existing code logic for managing chunk size and upload...
    int chunkSize = 512;
    final int minChunkSize = 100;
    final int maxChunkSize = 131072;
    final int maxDelayThreshold = 5000;
    int currentOffset = offset ?? 0;
    int chunkCount = 0;
    final int fileLength = await file.length();
    int fastUploadCount = 0;
    DateTime lastDecreaseTime = DateTime.now();
    final Duration decreaseCooldown = Duration(seconds: 3);

    List<double> uploadSpeeds = [];
    int adjustmentsCount = 0;
    final int adjustmentInterval = 5;

    if (pid == null) {
      yield UploadRequest(
        new_2: UploadRequest_Start(
          file: InputFile(
            name: mediaName,
            type: mediaType,
          ),
          progress: true,
        ),
      );
    } else {
      log.info('Resuming upload with PID: $pid from offset: $currentOffset');
    }

    while (currentOffset < fileLength) {
      int end = (currentOffset + chunkSize > fileLength)
          ? fileLength
          : currentOffset + chunkSize;
      Stream<List<int>> fileStream = file.openRead(currentOffset, end);

      await for (var bytes in fileStream) {
        yield UploadRequest(
          part: bytes,
          pid: pid ?? '',
        );
      }

      currentOffset += chunkSize;
      chunkCount++;

      if (chunkCount == 3) {
        final startTime = DateTime.now();
        await completer.future;

        final endTime = DateTime.now();
        int elapsedTimeMs = endTime.difference(startTime).inMilliseconds;
        if (elapsedTimeMs == 0) {
          elapsedTimeMs = 1;
        }

        final currentSpeed = (chunkSize / elapsedTimeMs) * 1000;
        uploadSpeeds.add(currentSpeed);
        if (uploadSpeeds.length > 5) {
          uploadSpeeds.removeAt(0);
        }

        final averageSpeed =
            uploadSpeeds.reduce((a, b) => a + b) / uploadSpeeds.length;
        adjustmentsCount++;
        if (adjustmentsCount >= adjustmentInterval) {
          final currentTime = DateTime.now();

          if (elapsedTimeMs > maxDelayThreshold &&
              currentTime.difference(lastDecreaseTime) > decreaseCooldown) {
            chunkSize =
                (chunkSize * 0.9).clamp(minChunkSize, maxChunkSize).toInt();
            log.warning(
                'Significant delay detected. Gradually reducing chunk size to: $chunkSize bytes.');
            lastDecreaseTime = currentTime;
          } else if (averageSpeed > 50000) {
            fastUploadCount++;
            if (fastUploadCount >= 3) {
              chunkSize =
                  (chunkSize * 1.15).clamp(minChunkSize, maxChunkSize).toInt();
              fastUploadCount = 0;
            }
          } else if (averageSpeed < 20000 &&
              currentTime.difference(lastDecreaseTime) > decreaseCooldown) {
            chunkSize =
                (chunkSize * 0.99).clamp(minChunkSize, maxChunkSize).toInt();
            log.warning(
                'Consistently slow speed. Gradually reducing chunk size to: $chunkSize bytes.');
            lastDecreaseTime = currentTime;
          }

          log.info(
              'Elapsed time: $elapsedTimeMs ms, Average upload speed: ${averageSpeed.toStringAsFixed(2)} B/s, Adjusted chunk size: $chunkSize bytes');
          adjustmentsCount = 0;
        }

        chunkCount = 0;
      }
    }

    log.info('Completed streaming upload requests for file: $mediaName');
  }

  /// Downloads a media file associated with a dialog.
  ///
  /// [fileId] The ID of the file to be downloaded.
  /// [offset] The starting point for the download (in bytes).
  ///
  /// Returns a [Download] object representing the download operation.
  @override
  Download downloadFile({
    required String fileId,
    required String savePath,
    int? offset,
  }) {
    // Initialize the StreamController for media file responses
    StreamController<MediaFileResponse> controller;
    // Create a new DownloadImpl object to manage the download
    DownloadImpl download;

    // Initialize the StreamController
    controller = StreamController<MediaFileResponse>();
    // Initialize the DownloadImpl with the fileId, offset, and controller
    download = DownloadImpl(
      fileId: fileId,
      offset: offset ?? 0,
      onData: controller,
      savePath: savePath,
    );

    // Start the media download from the server
    _downloadMediaFromServer(
      fileId: fileId,
      offset: fixnum.Int64(offset ?? 0),
      controller: controller,
      download: download,
    );

    return download;
  }

  /// Initiates the download of media from the server.
  ///
  /// [fileId] The ID of the file to be downloaded.
  /// [offset] The starting point for the download (in bytes).
  /// [controller] The StreamController for media file responses.
  /// [download] The DownloadImpl object managing the download.
  void _downloadMediaFromServer({
    required String fileId,
    required fixnum.Int64 offset,
    required StreamController<MediaFileResponse> controller,
    required DownloadImpl download,
  }) {
    final file = File(download.savePath);
    file.createSync(recursive: true);

    // Create the media stream from the gRPC call
    final mediaStream = _grpcChannel.mediaStorageStub.getFile(
      GetFileRequest(
        fileId: fileId,
        offset: offset,
      ),
    );

    // Set up the subscription to handle the media stream
    final subscription = _setupSubscription(
      mediaStream: mediaStream,
      fileId: fileId,
      offset: offset,
      controller: controller,
      download: download,
      targetFile: file,
    );

    // Assign the subscription to the download object
    download.setSubscription(subscription);
  }

  /// Sets up the subscription to handle the media stream.
  ///
  /// [mediaStream] The response stream of media files from the server.
  /// [fileId] The ID of the file being downloaded.
  /// [offset] The starting point for the download (in bytes).
  /// [controller] The StreamController for media file responses.
  /// [download] The DownloadImpl object managing the download.
  ///
  /// Returns the StreamSubscription for the media stream.
  StreamSubscription<MediaFile> _setupSubscription({
    required ResponseStream<MediaFile> mediaStream,
    required String fileId,
    required fixnum.Int64 offset,
    required StreamController<MediaFileResponse> controller,
    required DownloadImpl download,
    required File targetFile,
  }) {
    MediaFileResponse? file;

    final sink = targetFile.openWrite(mode: FileMode.writeOnly);

    // Listen to the media stream
    return mediaStream.listen(
      (mediaFile) {
        if (file == null) {
          // Initialize the MediaFileResponse object when the first chunk is received
          file = MediaFileResponse(
            size: mediaFile.file.size.toInt(),
            name: mediaFile.file.name,
            type: mediaFile.file.type,
            id: mediaFile.file.id,
          );
          controller.add(file!);

          log.info(
              "Initialized download for file '${file!.name}' with ID '${file!.id}', expected size: ${file!.size} bytes.");
        }

        // Add the received data to the file
        file!.bytes?.clear();
        file!.bytes?.addAll(mediaFile.data);
        sink.add(mediaFile.data);

        offset += mediaFile.data.length;

        // Update the download offset
        download.updateOffset(offset.toInt());

        // Add the file to the controller
        controller.add(file!);

        log.info(
            "Received ${mediaFile.data.length} bytes for file '${file!.name}'; Total received: $offset bytes.");
      },
      onError: (err) async {
        log.warning(
            "GrpcError encountered while downloading file '${file?.name ?? "unknown"}': ${err.message}");

        // Attempt to resume the download if it was interrupted
        if (file != null && offset < fixnum.Int64(file!.size ?? 0)) {
          log.info(
              "Attempting to resume file download for '${file!.name}' from offset $offset.");

          await for (var resumedFile in _downloadMediaFromOffset(
            fileId: fileId,
            file: file!,
            offset: offset,
            controller: controller,
            download: download,
            sink: sink,
          )) {
            controller.add(resumedFile);
          }
        } else {
          log.warning("Failed to download file due to GrpcError: $err");

          controller.addError(err);
          controller.close();
          await sink.flush();
          await sink.close();
        }
      },
      onDone: () async {
        // Close the controller when the download is complete
        if (file != null && offset.toInt() == file!.size) {
          log.info(
              "Completed download for file ID: $fileId, Total bytes received: $offset.");
        } else {
          log.warning(
              "Download not complete for file ID: $fileId, total bytes received: $offset.");
        }
        controller.close();
        await sink.flush();
        await sink.close();
      },
      cancelOnError: true,
    );
  }

  /// Resumes the download of media from the server if it was interrupted.
  ///
  /// [fileId] The ID of the file being downloaded.
  /// [file] The MediaFileResponse object representing the file being downloaded.
  /// [offset] The current offset in bytes of the download.
  /// [controller] The StreamController for media file responses.
  /// [download] The DownloadImpl object managing the download.
  ///
  /// Returns a stream of MediaFileResponse objects.
  Stream<MediaFileResponse> _downloadMediaFromOffset({
    required String fileId,
    required MediaFileResponse file,
    required fixnum.Int64 offset,
    required StreamController<MediaFileResponse> controller,
    required DownloadImpl download,
    required IOSink sink,
  }) async* {
    await retry(
      () async* {
        // Create the resumed media stream from the gRPC call
        final resumedMedia = _grpcChannel.mediaStorageStub.getFile(
          GetFileRequest(
            fileId: fileId,
            offset: offset,
          ),
        );

        // Listen to the resumed media stream
        await for (MediaFile mediaFile in resumedMedia) {
          file.bytes?.clear();
          file.bytes?.addAll(mediaFile.data);
          sink.add(mediaFile.data);
          offset += mediaFile.data.length;

          log.info(
              "Resumed download, received ${mediaFile.data.length} bytes; Total resumed: $offset bytes.");

          download.updateOffset(offset.toInt());

          controller.add(file);
          yield file;
        }

        log.info("Resumed and completed file download for '${file.name}'.");

        controller.close();
        await sink.flush();
        await sink.close();
      },
      retryIf: (err) => err is GrpcError,
      onRetry: (err) => log.warning(
        "Retrying due to GrpcError while resuming download for file (ID: '${file.id}', Size: ${file.size} bytes) from offset $offset: ${err.toString()}",
      ),
    );
  }

  // /// Pauses the download of a media file.
  // ///
  // /// [fileId] The ID of the file to be paused.
  // /// [subscription] The StreamSubscription managing the download stream.
  // @override
  // Future<void> pauseDownload({
  //   required String fileId,
  //   required StreamSubscription<MediaFile> subscription,
  // }) async {
  //   // Cancel the subscription to pause the download
  //   await subscription.cancel();
  //
  //   log.info("Paused download for file ID: $fileId");
  // }

  /// Resumes the download of a media file.
  ///
  /// [fileId] The ID of the file to be resumed.
  /// [controller] The StreamController for media file responses.
  /// [offset] The point at which to resume the download (in bytes).
  /// [download] The DownloadImpl object managing the download.
  @override
  Future<void> resumeDownload({
    required String fileId,
    required StreamController<MediaFileResponse> controller,
    required int offset,
    required DownloadImpl download,
  }) async {
    log.info("Resuming download for file ID: $fileId from offset: $offset");

    _downloadMediaFromServer(
      fileId: fileId,
      offset: fixnum.Int64(offset),
      controller: controller,
      download: download,
    );
  }

  /// Listens for new members added to the chat.
  Future<void> listenToNewMemberAdded() async {
    log.info("Initializing listener for new member added events.");

    await _sharedPreferencesGateway.init();
    final userId = await _sharedPreferencesGateway.readUserId();

    log.info("User ID retrieved: $userId");

    _grpcConnect.memberAddedStream.listen(
      (member) async {
        final chatId = member.chat.id;
        log.info("New member added event received for chat ID: $chatId");

        final onNewMemberAddedController = _onMemberAddedControllers[chatId];

        if (onNewMemberAddedController != null) {
          log.info("Adding new member to controller for chat ID: $chatId");

          onNewMemberAddedController.add(
            PortalChatMember(
              chatId: member.chat.id,
              memberId: member.join.first.id,
              memberType: member.join.first.type,
              memberName: member.join.first.name,
            ),
          );
        } else {
          log.warning("No controller found for chat ID: $chatId");
        }
      },
      onError: (error) {
        log.severe("Error while listening to new member added events: $error");
      },
      onDone: () {
        log.info("Listener for new member added events has completed.");
      },
    );
  }

  /// Listens for member left the chat.
  Future<void> listenToMemberLeft() async {
    log.info("Initializing listener for member left events.");

    await _sharedPreferencesGateway.init();
    final userId = await _sharedPreferencesGateway.readUserId();

    log.info("User ID retrieved: $userId");

    _grpcConnect.memberLeftStream.listen(
      (member) async {
        final chatId = member.chat.id;
        log.info("Member left event received for chat ID: $chatId");

        final onMemberLeftController = _onMemberLeftControllers[chatId];

        if (onMemberLeftController != null) {
          log.info("Adding member left to controller for chat ID: $chatId");

          onMemberLeftController.add(
            PortalChatMember(
              chatId: member.chat.id,
              memberId: member.left.id,
              memberType: member.left.type,
              memberName: member.left.name,
            ),
          );
        } else {
          log.warning("No controller found for chat ID: $chatId");
        }
      },
      onError: (error) {
        log.severe("Error while listening to member left events: $error");
      },
      onDone: () {
        log.info("Listener for member left events has completed.");
      },
    );
  }

  /// Listens for all messages from the server.
  Future<void> listenToMessages() async {
    await _sharedPreferencesGateway.init();
    final userId = await _sharedPreferencesGateway.readUserId();
    _grpcConnect.updateStream.listen(
      (update) async {
        try {
          final chatId = update.message.chat.id;
          final onNewMessageController = _onNewMessageControllers[chatId];

          if (onNewMessageController != null) {
            final messageType =
                MessageHelper.determineMessageTypeResponse(update);

            log.info("Received message of type: $messageType in chat: $chatId");

            Keyboard? keyboard;
            if (update.message.keyboard.buttons.isNotEmpty) {
              log.info(
                  'Buttons found in keyboard: ${update.message.keyboard.buttons}');
              keyboard = Keyboard(
                buttons: update.message.keyboard.buttons.map((buttonRow) {
                  log.info('Processing button row: $buttonRow');
                  return buttonRow.row
                      .map((button) {
                        log.info('Processing button: $button');

                        // Check if the code or url property is not empty
                        if (button.code.isNotEmpty || button.url.isNotEmpty) {
                          return Button(
                            text: button.text,
                            code: button.code,
                            url: button.url,
                          );
                        } else {
                          log.warning(
                              'Skipping button with empty code - ${button.text}');
                          return null;
                        }
                      })
                      .whereType<Button>()
                      .toList();
                }).toList(),
              );
            } else {
              log.warning('No buttons found in keyboard.');
            }

            if (messageType == MessageType.button) {
              final buttonDetails = keyboard?.buttons.map((buttonRow) {
                    return buttonRow.map((button) {
                      return 'Button(text: ${button.text}, code: ${button.code}, url: ${button.url})';
                    }).join('\n');
                  }).join('\n') ??
                  '';

              log.info(
                  "Received a button message in chat: $chatId with buttons:\n$buttonDetails");
            }

            final dialogMessage = ResponseDialogMessageBuilder()
                .setDialogMessageContent(update.message.text)
                .setRequestId(update.id)
                .setMessageId(update.message.id.toInt())
                .setUserUd(userId ?? '')
                .setChatId(chatId)
                .setTimestamp(update.message.date.toInt())
                .setUpdate(update)
                .setFile(
                  messageType == MessageType.media
                      ? MediaFileResponse(
                          id: update.message.file.id,
                          type: update.message.file.type,
                          name: update.message.file.name,
                          bytes: [],
                          size: update.message.file.size.toInt(),
                        )
                      : MediaFileResponse.initial(),
                )
                .setKeyboard(keyboard ?? Keyboard.initial())
                .setInput(update.message.keyboard.noInput)
                .build();

            log.info(
                "Built dialog message: ${dialogMessage.dialogMessageContent}");

            onNewMessageController.add(dialogMessage);
          } else {
            log.warning("No message controller found for chat: $chatId");
          }
        } catch (e) {
          log.severe("Exception while processing message: $e");
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
  ///
  /// [message] The message to be sent.
  /// [chatId] The ID of the chat to which the message is sent.
  ///
  /// Returns a [DialogMessageResponse] representing the sent message.
  @override
  Future<DialogMessageResponse> sendMessage({
    required DialogMessageRequest message,
    required String chatId,
    int? timeout,
  }) async {
    try {
      final userId = await _sharedPreferencesGateway.readUserId();
      final messageType = MessageHelper.determineMessageTypeRequest(message);

      log.info("Sending message of type $messageType for user $userId");

      final request = await _buildSendMessageRequest(
          message, userId ?? '', messageType, message.uploadFile);

      _grpcConnect.sendRequest(request);

      return await _sendMessageResponse(
        message.requestId,
        userId ?? '',
        _handleSendMessageResponse,
        _handleSendMessageError,
      ).timeout(Duration(seconds: timeout ?? 30));
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

  /// Sends a message and uses the typedefs for handling responses and errors.
  ///
  /// [requestId] The ID of the request.
  /// [userId] The ID of the user.
  /// [handleResponse] The handler for processing the response.
  /// [handleError] The handler for processing errors.
  ///
  /// Returns a [Future] for [DialogMessageResponse].
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

  /// Handles the response when a message is sent.
  ///
  /// [response] The response from the server.
  /// [completer] The [Completer] for the [DialogMessageResponse].
  /// [userId] The ID of the user.
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
        case MessageType.text:
          log.info("Handled response for message type $MessageType.text");

          completer.complete(
            ResponseDialogMessageBuilder()
                .setDialogMessageContent(unpackedMessage.message.text)
                .setRequestId(unpackedMessage.id)
                .setUserUd(userId)
                .setMessageId(unpackedMessage.message.id.toInt())
                .setChatId(unpackedMessage.message.chat.id)
                .setTimestamp(unpackedMessage.message.date.toInt())
                .setUpdate(unpackedMessage)
                .setFile(MediaFileResponse.initial())
                .setInput(unpackedMessage.message.keyboard.noInput)
                .build(),
          );

        case MessageType.media:
          log.info("Handled response for message type $MessageType.media");

          completer.complete(
            ResponseDialogMessageBuilder()
                .setDialogMessageContent(unpackedMessage.message.text)
                .setRequestId(unpackedMessage.id)
                .setMessageId(unpackedMessage.message.id.toInt())
                .setUserUd(userId)
                .setChatId(unpackedMessage.message.chat.id)
                .setUpdate(unpackedMessage)
                .setTimestamp(unpackedMessage.message.date.toInt())
                .setFile(
                  MediaFileResponse(
                    id: unpackedMessage.message.file.id,
                    type: unpackedMessage.message.file.type,
                    name: unpackedMessage.message.file.name,
                    size: unpackedMessage.message.file.size.toInt(),
                  ),
                )
                .setInput(unpackedMessage.message.keyboard.noInput)
                .build(),
          );

        case MessageType.button:
          log.warning("Error response format: ${MessageType.button}");
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

  /// Handles the error when a message is sent.
  ///
  /// [error] The error that occurred.
  /// [completer] The [Completer] for the [DialogMessageResponse].
  /// [requestId] The ID of the request.
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

  /// Builds the request for sending a message.
  ///
  /// [message] The message to be sent.
  /// [userId] The ID of the user.
  /// [messageType] The type of the message.
  ///
  /// Returns a [Future] for [portal.Request].
  Future<portal.Request> _buildSendMessageRequest(
    DialogMessageRequest message,
    String userId,
    MessageType messageType,
    UploadFile? uploadFile,
  ) async {
    log.info(
        "Building request for sending a message. User ID: $userId, Message Type: $messageType, Message Content: ${message.content}");

    final baseRequest = SendMessageRequest(
      text: message.content,
    );

    if (messageType == MessageType.media) {
      baseRequest.file = file.File(
        id: uploadFile?.id.toString(),
        name: uploadFile?.name,
        type: uploadFile?.type,
      );
    }

    log.info(
        'Sending message request to portal with path: ${Constants.sendMessagePath}');

    return portal.Request(
      path: Constants.sendMessagePath,
      data: Any.pack(baseRequest),
      id: message.requestId,
    );
  }

  /// Fetches updates for a chat.
  ///
  /// [limit] The maximum number of updates to fetch.
  /// [offset] The offset from which to start fetching updates.
  /// [chatId] The ID of the chat for which updates are fetched.
  ///
  /// Returns a list of [DialogMessageResponse].
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

  /// Fetches messages for a chat.
  ///
  /// [limit] The maximum number of messages to fetch.
  /// [offset] The offset from which to start fetching messages.
  /// [chatId] The ID of the chat for which messages are fetched.
  ///
  /// Returns a list of [DialogMessageResponse].
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
    } catch (err) {
      if (err is TimeoutException) {
        log.severe('Timeout while fetching messages');

        return [
          DialogMessageResponse.error(
            requestId: requestId,
            error: CallError(
              statusCode: ErrorCodes.timeoutError.toString(),
              errorMessage: 'Request timed out while fetching messages.',
            ),
          ),
        ];
      } else {
        log.severe('An error occurred while fetching messages');

        return [
          DialogMessageResponse.error(
            requestId: requestId,
            error: CallError(
              statusCode: ErrorCodes.unknownError.toString(),
              errorMessage:
                  'An unknown error occurred while fetching messages.',
            ),
          ),
        ];
      }
    }
  }

  /// Sends a ping request to the server to check the connection status.
  ///
  /// This method creates an Echo request with the data 'Client ping' and sends it to the
  /// server using the gRPC channel. It converts the server's response to a string and returns it.
  /// If a gRPC error occurs, it logs the error and returns an error message.
  ///
  /// Returns a [Future<String>] that completes with the server's response as a string,
  /// or an error message if the ping request fails.
  @override
  Future<String> ping() async {
    try {
      // Create an Echo request with the data 'Client ping'
      final echo = portal.Echo(data: 'Client ping'.codeUnits);

      // Send the ping request using the gRPC channel
      final response = await _grpcChannel.customerStub.ping(echo);

      // Convert the response to a string and return it
      return String.fromCharCodes(response.data);
    } on GrpcError catch (err) {
      // Log and handle the gRPC error
      log.severe('GRPC Error during ping', err);
      return 'GRPC Error: ${err.message}';
    } catch (err) {
      // Log and handle any other errors
      log.severe('Unexpected Error during ping', err);
      return 'Unexpected Error: ${err.toString()}';
    }
  }

  /// Reconnects to the chat stream.
  ///
  /// Returns a [Future] representing the asynchronous operation.
  @override
  Future<void> reconnectToStream() async {
    await _grpcConnect.reconnect();
  }

  /// Gets the current communication channel.
  ///
  /// Returns a [Channel] representing the current communication channel.
  @override
  Future<Channel> getChannel() async {
    return ChannelImpl();
  }

  /// Provides a stream controller for channel status changes.
  ///
  /// Returns a [StreamController] for [ChannelStatus].
  @override
  StreamController<ChannelStatus> onChannelStatusChange() {
    return _grpcConnect.chanelStatusStream;
  }

  /// Provides a stream controller for connection status changes.
  ///
  /// Returns a [StreamController] for [Connect].
  @override
  StreamController<Connect> onConnectStreamStatusChange() {
    return _grpcConnect.connectStatusStream;
  }

  /// Provides a stream controller for errors occurring in the chat service.
  ///
  /// Returns a [StreamController] for [CallError].
  @override
  StreamController<CallError> onError() {
    return _grpcConnect.errorStream;
  }

  @override
  Future<DialogMessageResponse> sendPostback({
    required String chatId,
    required Postback postback,
    required String requestId,
    int? timeout,
  }) async {
    try {
      final userId = await _sharedPreferencesGateway.readUserId();

      log.info("Sending postback for user $userId");

      final request = await _buildSendPostbackRequest(
        postback: postback,
        userId: userId ?? '',
        requestId: requestId,
      );

      _grpcConnect.sendRequest(request);

      return await _sendPostbackResponse(
        requestId,
        userId ?? '',
        _handleSendPostbackResponse,
        _handleSendPostbackError,
      ).timeout(Duration(seconds: timeout ?? 30));
    } on GrpcError catch (err) {
      log.severe("GRPC Error on sendPostback: ${err.message}");

      return ErrorDialogMessageBuilder()
          .setDialogMessageContent(err.toString())
          .setRequestId(postback.mid.toString())
          .build();
    } on TimeoutException {
      log.warning("Timeout exception on sendPostback");

      return ErrorDialogMessageBuilder()
          .setDialogMessageContent('Postback was not sent due to timeout')
          .setRequestId(postback.mid.toString())
          .build();
    }
  }

  Future<portal.Request> _buildSendPostbackRequest({
    required Postback postback,
    required String userId,
    required String requestId,
  }) async {
    // Construct SendMessageRequest for postback

    final sendMessageRequest = SendMessageRequest(
      id: requestId,
      postback: file.Postback(
        mid: fixnum.Int64(postback.mid),
        code: postback.code,
        text: postback.text,
      ),
    );

    return portal.Request(
      path: Constants.sendMessagePath,
      data: Any.pack(sendMessageRequest),
      id: requestId,
    );
  }

  Future<DialogMessageResponse> _sendPostbackResponse(
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

  Future<void> _handleSendPostbackResponse(
    portal.Response response,
    Completer<DialogMessageResponse> completer,
    String userId,
  ) async {
    if (response.data.canUnpackInto(UpdateNewMessage())) {
      final unpackedMessage = response.data.unpackInto(UpdateNewMessage());
      final messageType =
          MessageHelper.determineMessageTypeResponse(unpackedMessage);

      if (messageType == MessageType.text) {
        log.info(
            "Handled response for message type $MessageType.outcomingMessage");

        completer.complete(
          ResponseDialogMessageBuilder()
              .setDialogMessageContent(unpackedMessage.message.text)
              .setRequestId(unpackedMessage.id)
              .setUserUd(userId)
              .setMessageId(unpackedMessage.message.id.toInt())
              .setChatId(unpackedMessage.message.chat.id)
              .setTimestamp(unpackedMessage.message.date.toInt())
              .setInput(unpackedMessage.message.keyboard.noInput)
              .setUpdate(unpackedMessage)
              .setFile(MediaFileResponse.initial())
              .setInput(unpackedMessage.message.keyboard.noInput)
              .build(),
        );
      }
    } else if (response.err.hasMessage()) {
      final (recordId, errorMessage) = (
        response.id,
        response.err.message,
      );

      log.warning(
          'Failed to send postback for requestId: $recordId: $errorMessage');
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

  void _handleSendPostbackError(
    Object error,
    Completer<DialogMessageResponse> completer,
    String requestId,
  ) {
    final errorMessage =
        error is GrpcError ? error.message : 'Unknown error occurred';
    log.severe("Error on handling postback response: $errorMessage");

    completer.complete(
      ErrorDialogMessageBuilder()
          .setDialogMessageContent(errorMessage ?? '')
          .setRequestId(requestId)
          .build(),
    );
  }
}
