import 'dart:async';

import 'package:grpc/grpc.dart';
import 'package:injectable/injectable.dart';
import 'package:synchronized/synchronized.dart';
import 'package:webitel_portal_sdk/src/data/grpc/grpc_channel.dart';
import 'package:webitel_portal_sdk/src/data/helper/channel_status.dart';
import 'package:webitel_portal_sdk/src/data/helper/error.dart';
import 'package:webitel_portal_sdk/src/data/helper/response_type.dart';
import 'package:webitel_portal_sdk/src/data/logger/logger.dart';
import 'package:webitel_portal_sdk/src/data/shared_preferences/shared_preferences_gateway.dart';
import 'package:webitel_portal_sdk/src/domain/entities/call_error.dart';
import 'package:webitel_portal_sdk/src/domain/entities/channel_status.dart';
import 'package:webitel_portal_sdk/src/domain/entities/connect.dart';
import 'package:webitel_portal_sdk/src/domain/entities/connect_status.dart';
import 'package:webitel_portal_sdk/src/domain/entities/response_type.dart';
import 'package:webitel_portal_sdk/src/generated/google/protobuf/any.pb.dart';
import 'package:webitel_portal_sdk/src/generated/portal/connect.pb.dart'
    as portal;
import 'package:webitel_portal_sdk/src/generated/portal/messages.pb.dart';
import 'package:webitel_portal_sdk/src/generated/portal/messages.pbgrpc.dart';

/// A singleton class to manage gRPC bi-directional Connect stream and handle
/// communication with the server.
@LazySingleton()
final class GrpcConnect {
  // The gRPC channel used to communicate with the server.
  final GrpcChannel _grpcChannel;

  // Gateway to access shared preferences for storing and retrieving tokens.
  final SharedPreferencesGateway _sharedPreferencesGateway;

  // Stream controller for responses from the server.
  final StreamController<portal.Response> _responseStreamController =
      StreamController<portal.Response>.broadcast();

  // Stream controller for connection status updates.
  final StreamController<Connect> _connectController =
      StreamController<Connect>.broadcast();

  // Stream controller for new messages from the server.
  final StreamController<UpdateNewMessage> _updateStreamController =
      StreamController<UpdateNewMessage>.broadcast();

  // Stream controller new member added to the chat..
  final StreamController<UpdateChatMember> _memberAddedStreamController =
      StreamController<UpdateChatMember>.broadcast();

  // Stream controller member left the chat..
  final StreamController<UpdateLeftMember> _memberLeftStreamController =
      StreamController<UpdateLeftMember>.broadcast();

  // Stream controller for requests to the server.
  final StreamController<portal.Request> _requestStreamController =
      StreamController<portal.Request>.broadcast();

  // Stream controller for errors encountered during communication.
  final StreamController<CallError> _errorStreamController =
      StreamController<CallError>.broadcast();

  // Stream controller for the status of the channel.
  final StreamController<ChannelStatus> _channelStatus =
      StreamController<ChannelStatus>.broadcast();

  // Stream for receiving responses from the server.
  Stream<portal.Update>? _responseStream;

  // Flag indicating if the connection is closed.
  bool connectClosed = true;

  // Lock for synchronizing connection attempts.
  final Lock _lock = Lock();

  // Logger for logging messages and errors.
  final log = CustomLogger.getLogger('ConnectListenerGateway');

  // Current connection state of the gRPC channel.
  ConnectionState? _connectionState;

  // Timer for periodic tasks, such as sending ping messages.
  Timer? _timer;

  /// Constructs a [GrpcConnect] instance with the specified dependencies.
  ///
  /// [sharedPreferencesGateway] The gateway to access shared preferences.
  /// [grpcChannel] The gRPC channel for communication.
  GrpcConnect(this._sharedPreferencesGateway, this._grpcChannel) {
    listenToChannelStatus();
  }

  /// Listens to responses from the gRPC server and processes them accordingly.
  Future<void> listenToResponses() async {
    try {
      if (_responseStream != null) {
        await for (portal.Update update in _responseStream!) {
          connectClosed = false;
          _connectController.add(Connect(status: ConnectStatus.opened));
          final responseType = ResponseTypeHelper.determineResponseType(update);

          log.info(
              'Received a new response from the server with response type: $responseType');

          switch (responseType) {
            case ResponseType.response:
              // [Processing a standard response]
              log.info('Processing response type: ${ResponseType.response}');

              _responseStreamController.add(
                update.data.unpackInto(
                  portal.Response(),
                ),
              );

            case ResponseType.updateNewMessage:
              // [Processing a new message update]
              log.info(
                  'Processing response type: ${ResponseType.updateNewMessage}');
              final decodedUpdate = update.data.unpackInto(
                UpdateNewMessage(),
              );

              _updateStreamController.add(decodedUpdate);
              log.info('New message received: ${decodedUpdate.message.text}');

            case ResponseType.memberAdded:
              // [Processing a new member added update]
              log.info('Processing response type: ${ResponseType.memberAdded}');
              final decodedUpdate = update.data.unpackInto(
                UpdateChatMember(),
              );

              _memberAddedStreamController.add(decodedUpdate);
              log.info(
                  'New chat member added: ${decodedUpdate.join.first.name}');

            case ResponseType.memberLeft:
              // [Processing member left chat]
              log.info('Processing response type: ${ResponseType.memberLeft}');
              final decodedUpdate = update.data.unpackInto(
                UpdateLeftMember(),
              );

              _memberLeftStreamController.add(decodedUpdate);
              log.info('Member left chat: ${decodedUpdate.left.name}');

            case ResponseType.error:
              // [Processing an error response]
              log.info('Processing response type: ${ResponseType.error}');
              final decodedResponse = update.data.unpackInto(
                portal.Response(),
              );

              _responseStreamController.add(decodedResponse);
              final code =
                  ErrorHelper.getCodeFromMessage(decodedResponse.err.message);

              _errorStreamController.add(
                CallError(
                  statusCode: code,
                  errorMessage: decodedResponse.err.message,
                ),
              );
              log.warning(
                  'Error response received: ${decodedResponse.err.message}');
            case ResponseType.disconnect:
              handleConnectionClosure(err: 'gRPC stream was terminated');
            case ResponseType.chatComplete:
              log.info(
                  'Processing response type: ${ResponseType.chatComplete}');
              throw UnimplementedError();
          }
        }
      } else {
        log.warning('Response stream is null, unable to listen to responses.');
      }
    } on GrpcError catch (err) {
      log.warning('GRPC Error encountered: ${err.message}');

      _errorStreamController.add(
        CallError(
          statusCode: err.code.toString(),
          errorMessage: err.message ?? '',
        ),
      );
      handleConnectionClosure(err: err.message ?? '');
    } catch (err) {
      log.warning('Unexpected error occurred: $err');
      handleConnectionClosure(err: err.toString());
    }
  }

  /// Handles the closure of the connection, setting the appropriate flags and state.
  ///
  /// [errorMessage] The error message to be logged and included in the connection status.
  void handleConnectionClosure({required String err}) {
    connectClosed = true;
    _responseStream = null;

    _connectController.add(
      Connect(
        status: ConnectStatus.closed,
        errorMessage: err,
      ),
    );
    log.info('Connection closed with error message: $err');
  }

  /// Establishes a connection to the gRPC server and listens for responses.
  Future<void> _connect() async {
    try {
      log.info('Attempting to establish a connection to the gRPC server...');

      _responseStream = _grpcChannel.customerStub
          .connect(_requestStreamController.stream)
          .asBroadcastStream();

      await _responseStream?.isEmpty;

      log.info(
          'Connection established successfully. Listening to responses...');
      listenToResponses();
    } catch (err) {
      connectClosed = true;
      _responseStream = null;
      log.warning('Error occurred while establishing the connection: $err');
    }
  }

  /// Sends a ping message to the server
  Future<void> sendPingMessage() async {
    final String echoDataString = 'Bind';
    final List<int> echoDataBytes = echoDataString.codeUnits;
    final echo = portal.Echo(data: echoDataBytes);

    final request = portal.Request(
      path: '/webitel.portal.Customer/Ping',
      data: Any.pack(echo),
    );

    _requestStreamController.add(request);
    log.info('Ping message sent to server. Request path: ${request.path}');
  }

  /// Sends a request to the server.
  ///
  /// [request] The request to be sent.
  Future<void> sendRequest(portal.Request request) async {
    log.info('Starting to send request to server...');

    if (connectClosed == true && _responseStream == null) {
      log.warning(
          'Connection is closed or not ready. Attempting to reconnect...');
      await reconnect();
    }

    _requestStreamController.add(request);
    log.info('Request added to the stream. Request path: ${request.path}');
  }

  /// Attempts to reconnect to the gRPC server with synchronized backoff strategy.
  Future<void> reconnect() async {
    if (_connectionState == ConnectionState.shutdown) {
      log.info(
          'Current connection state is shutdown. Reinitializing gRPC channel...');

      final accessToken = await _sharedPreferencesGateway.readAccessToken();
      await _grpcChannel.setAccessToken(accessToken ?? '');

      log.info('gRPC Channel reinitialized successfully.');
    }

    await _lock.synchronized(() async {
      int pingCount = 0;
      _timer = Timer.periodic(Duration(seconds: 1), (timer) async {
        if (pingCount < 5) {
          log.info('Sending periodic ping message to maintain connection...');

          await sendPingMessage();
          pingCount++;
        } else {
          _timer?.cancel();
        }
      });
      await _connect();
      _timer?.cancel();

      log.info('Reconnected to the gRPC Stream successfully.');
    });
  }

  /// Listens to the channel status and handles state changes.
  Future<void> listenToChannelStatus() async {
    log.info('Starting to listen to channel status changes...');

    _grpcChannel.stateStream.stream.listen((state) async {
      log.info('Channel status changed: $state');

      _channelStatus.add(
        ChannelStatusHelper.toChannelStatus(
          state.name,
        ),
      );

      if (state == ConnectionState.shutdown) {
        handleStreamCleanup();

        _connectController.add(
          Connect(
            errorMessage:
                'Connection was closed due to the channel state change: $state',
            status: ConnectStatus.closed,
          ),
        );

        log.warning('Response stream canceled due to state: $state');
      } else if (state == ConnectionState.transientFailure) {
        handleStreamCleanup();

        _connectController.add(
          Connect(
            errorMessage:
                'Connection was closed due to the channel state change: $state',
            status: ConnectStatus.closed,
          ),
        );

        log.warning('Response stream canceled due to state: $state');
      } else if (state == ConnectionState.idle) {
        handleStreamCleanup();

        _connectController.add(
          Connect(
            errorMessage:
                'Connection was closed due to the channel state change: $state',
            status: ConnectStatus.closed,
          ),
        );

        log.warning('Response stream canceled due to state: $state');
      }
      _connectionState = state;
    });
  }

  /// Handles the cleanup of the response stream and connection state.
  void handleStreamCleanup() {
    _responseStream = null;
    connectClosed = true;

    log.info(
        'Stream cleanup completed. Response stream set to null and connection marked as closed.');
  }

  /// Gets the response stream controller's stream.
  Stream<portal.Response> get responseStream =>
      _responseStreamController.stream;

  /// Gets the update stream controller's stream.
  Stream<UpdateNewMessage> get updateStream => _updateStreamController.stream;

  /// Gets the new member added to the chat stream..
  Stream<UpdateChatMember> get memberAddedStream =>
      _memberAddedStreamController.stream;

  /// Gets the member left the chat stream..
  Stream<UpdateLeftMember> get memberLeftStream =>
      _memberLeftStreamController.stream;

  /// Gets the error stream controller.
  StreamController<CallError> get errorStream => _errorStreamController;

  /// Gets the connect status stream controller.
  StreamController<Connect> get connectStatusStream => _connectController;

  /// Gets the channel status stream controller.
  StreamController<ChannelStatus> get chanelStatusStream => _channelStatus;

  /// Disposes the stream controllers.
  void dispose() {
    _requestStreamController.close();
    _responseStreamController.close();
    _connectController.close();
    _updateStreamController.close();
    _channelStatus.close();

    log.info('Disposed all stream controllers and cleaned up resources.');
  }
}
