import 'dart:async';

import 'package:grpc/grpc.dart';
import 'package:injectable/injectable.dart';
import 'package:protobuf/well_known_types/google/protobuf/any.pb.dart';
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
import 'package:webitel_portal_sdk/src/generated/portal/connect.pb.dart'
    as portal;
import 'package:webitel_portal_sdk/src/generated/portal/messages.pb.dart';
import 'package:webitel_portal_sdk/src/generated/portal/messages.pbgrpc.dart';

/// A singleton class to manage gRPC bi-directional Connect stream and handle
/// communication with the server.
///
/// At most ONE Connect call is alive at any moment: requests are written to a
/// single-subscription sink owned by that call, so a request can never be
/// delivered to the server more than once.
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

  // Stream controller for errors encountered during communication.
  final StreamController<CallError> _errorStreamController =
      StreamController<CallError>.broadcast();

  // Stream controller for the status of the channel.
  final StreamController<ChannelStatus> _channelStatus =
      StreamController<ChannelStatus>.broadcast();

  // Request sink of the active Connect call. Single-subscription: exactly one
  // live gRPC call consumes it. Null while no call is active.
  StreamController<portal.Request>? _requestSink;

  // Subscription to the active call's updates; kept so the previous call can
  // be cancelled before a new one is opened.
  StreamSubscription<portal.Update>? _updateSubscription;

  // Completes when the active call receives its first update (proof that the
  // stream is live), or with an error if the call fails to establish.
  Completer<void>? _connectionReady;

  // Incremented on every (re)connect. Callbacks of a previous call compare
  // their captured epoch against it, so a stale onError/onDone can never tear
  // down the current call.
  int _connectEpoch = 0;

  // Flag indicating if the connection is closed.
  bool connectClosed = true;

  // Lock for synchronizing connection attempts.
  final Lock _lock = Lock();

  // Logger for logging messages and errors.
  final log = CustomLogger.getLogger('ConnectListenerGateway');

  // Current connection state of the gRPC channel.
  ConnectionState? _connectionState;

  /// Constructs a [GrpcConnect] instance with the specified dependencies.
  ///
  /// [sharedPreferencesGateway] The gateway to access shared preferences.
  /// [grpcChannel] The gRPC channel for communication.
  GrpcConnect(this._sharedPreferencesGateway, this._grpcChannel) {
    listenToChannelStatus();
  }

  // Whether there is an active Connect call able to accept requests.
  bool get _isActive => _requestSink != null && !_requestSink!.isClosed;

  /// Sends a request to the server over the Connect stream, (re)establishing
  /// the stream first if needed.
  ///
  /// Throws a [GrpcError] if the stream cannot be established, so the caller
  /// can report the failure immediately instead of waiting for a timeout.
  ///
  /// [request] The request to be sent.
  Future<void> sendRequest(portal.Request request) async {
    if (!_isActive) {
      log.info('No active Connect stream. Establishing connection...');
      await _ensureConnected();
    }

    final sink = _requestSink;
    if (sink == null || sink.isClosed) {
      throw GrpcError.unavailable('Connect stream is not available');
    }

    sink.add(request);
    log.info('Request added to the stream. Request path: ${request.path}');
  }

  /// Establishes the Connect stream if it is not already active.
  Future<void> _ensureConnected() async {
    await _lock.synchronized(() async {
      if (_isActive) return;
      await _connect();
    });
  }

  /// Forcefully re-establishes the Connect stream.
  Future<void> reconnect() async {
    await _lock.synchronized(() async {
      if (_connectionState == ConnectionState.shutdown) {
        log.info(
            'Current connection state is shutdown. Refreshing access token...');

        final accessToken = await _sharedPreferencesGateway.readAccessToken();
        await _grpcChannel.setAccessToken(accessToken ?? '');
      }

      await _teardownCall();
      await _connect();

      log.info('Reconnected to the gRPC Stream successfully.');
    });
  }

  /// Opens a new Connect call and waits until it is confirmed live.
  ///
  /// Must only be called while holding [_lock].
  Future<void> _connect() async {
    await _teardownCall();

    final epoch = ++_connectEpoch;
    final sink = StreamController<portal.Request>();
    final ready = Completer<void>();

    _requestSink = sink;
    _connectionReady = ready;

    log.info('Attempting to establish a connection to the gRPC server...');

    try {
      final call = _grpcChannel.customerStub.connect(sink.stream);

      // The server's initial HTTP/2 metadata is the earliest reliable signal
      // that the stream was actually accepted — grpc-dart opens calls lazily,
      // so the call object alone proves nothing. The Ping round-trip below is
      // a stronger end-to-end proof; whichever arrives first marks the stream
      // live. Establishment failures surface via the update subscription's
      // onError, so a headers error can be ignored here.
      unawaited(call.headers
          .then((_) => _markConnected(epoch))
          .catchError((Object _) {}));

      _updateSubscription = call.listen(
        (update) => _handleUpdate(update, epoch),
        onError: (Object err) => _handleCallClosure(
          epoch,
          err is GrpcError ? (err.message ?? err.toString()) : err.toString(),
          error: err,
        ),
        onDone: () =>
            _handleCallClosure(epoch, 'gRPC stream was closed by the server'),
        cancelOnError: true,
      );

      // The call is established lazily by grpc-dart; a Ping forces a full
      // round-trip so [ready] only completes once the stream is proven live.
      await sendPingMessage();
      await ready.future.timeout(const Duration(seconds: 10));

      log.info(
          'Connection established successfully. Listening to responses...');
    } on Object catch (err) {
      log.warning('Error occurred while establishing the connection: $err');
      await _teardownCall();

      throw err is GrpcError
          ? err
          : GrpcError.unavailable('Failed to establish Connect stream: $err');
    }
  }

  /// Marks the active call as live: completes the pending connection
  /// verification and notifies listeners exactly once per connection.
  void _markConnected(int epoch) {
    if (epoch != _connectEpoch) return;

    connectClosed = false;

    final ready = _connectionReady;
    if (ready != null && !ready.isCompleted) {
      ready.complete();
      _connectController.add(Connect(status: ConnectStatus.opened));
    }
  }

  /// Processes a single update received from the server.
  void _handleUpdate(portal.Update update, int epoch) {
    if (epoch != _connectEpoch) return;

    _markConnected(epoch);

    try {
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
          log.info('New chat member added: ${decodedUpdate.join.first.name}');

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
          _handleCallClosure(epoch, 'gRPC stream was terminated');

        case ResponseType.chatComplete:
          // A completed chat is a normal domain event: it must not tear down
          // the transport or crash the update listener.
          log.info('Processing response type: ${ResponseType.chatComplete}');
      }
    } catch (err) {
      log.warning('Unexpected error while processing an update: $err');
    }
  }

  /// Handles the closure of the active call: releases its resources and
  /// notifies listeners. Safe to call multiple times; stale epochs are
  /// ignored.
  void _handleCallClosure(int epoch, String message, {Object? error}) {
    if (epoch != _connectEpoch) return;
    // Invalidate any remaining callbacks of this call (e.g. onDone following
    // an in-band disconnect update), so closure runs exactly once.
    _connectEpoch++;

    if (error is GrpcError) {
      log.warning('GRPC Error encountered: ${error.message}');

      _errorStreamController.add(
        CallError(
          statusCode: error.code.toString(),
          errorMessage: error.message ?? '',
        ),
      );
    }

    final ready = _connectionReady;
    _connectionReady = null;
    if (ready != null && !ready.isCompleted) {
      ready.completeError(
        error is GrpcError ? error : GrpcError.unavailable(message),
      );
    }

    final sink = _requestSink;
    _requestSink = null;
    if (sink != null && !sink.isClosed) {
      unawaited(sink.close());
    }

    unawaited(_updateSubscription?.cancel());
    _updateSubscription = null;
    connectClosed = true;

    _connectController.add(
      Connect(
        status: ConnectStatus.closed,
        errorMessage: message,
      ),
    );
    log.info('Connection closed with error message: $message');
  }

  /// Cancels the active call, if any, and releases its resources.
  Future<void> _teardownCall() async {
    _connectEpoch++;

    final subscription = _updateSubscription;
    _updateSubscription = null;
    // Cancelling the update subscription cancels the underlying gRPC call.
    await subscription?.cancel();

    final sink = _requestSink;
    _requestSink = null;
    if (sink != null && !sink.isClosed) {
      unawaited(sink.close());
    }

    final ready = _connectionReady;
    _connectionReady = null;
    if (ready != null && !ready.isCompleted) {
      ready.completeError(GrpcError.cancelled('Connect stream was torn down'));
    }

    connectClosed = true;
  }

  /// Sends a ping message to the server over the active Connect stream.
  Future<void> sendPingMessage() async {
    final sink = _requestSink;
    if (sink == null || sink.isClosed) {
      log.warning('Cannot send ping: Connect stream is not active.');
      return;
    }

    final String echoDataString = 'Bind';
    final List<int> echoDataBytes = echoDataString.codeUnits;
    final echo = portal.Echo(data: echoDataBytes);

    final request = portal.Request(
      path: '/webitel.portal.Customer/Ping',
      data: Any.pack(echo),
    );

    sink.add(request);
    log.info('Ping message sent to server. Request path: ${request.path}');
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

      // Only a lost transport invalidates the active call. `idle` is the
      // normal state of a channel without in-flight calls and must not be
      // treated as a failure.
      if (state == ConnectionState.shutdown ||
          state == ConnectionState.transientFailure) {
        if (_updateSubscription != null || _isActive) {
          _handleCallClosure(
            _connectEpoch,
            'Connection was closed due to the channel state change: $state',
          );

          log.warning('Active call released due to state: $state');
        }
      }
      _connectionState = state;
    });
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
    unawaited(_teardownCall());
    _responseStreamController.close();
    _connectController.close();
    _updateStreamController.close();
    _memberAddedStreamController.close();
    _memberLeftStreamController.close();
    _errorStreamController.close();
    _channelStatus.close();

    log.info('Disposed all stream controllers and cleaned up resources.');
  }
}
