import 'dart:async';

import 'package:grpc/grpc.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:webitel_portal_sdk/src/data/builder/call_options.dart';
import 'package:webitel_portal_sdk/src/generated/portal/customer.pbgrpc.dart';
import 'package:webitel_portal_sdk/src/generated/portal/media.pbgrpc.dart';

/// A singleton class to manage gRPC channel and client stubs.
@LazySingleton()
class GrpcChannel {
  // Customer client stub.
  late CustomerClient _customerStub;

  // Media storage client stub.
  late MediaStorageClient _mediaStorageStub;

  // gRPC channel. Created once per [init]; transport-level reconnection is
  // handled internally by grpc-dart with exponential backoff, so the channel
  // must never be recreated on connection failures.
  ClientChannel? _channel;

  // Access token for authentication.
  late String _accessToken = '';

  // URL of the gRPC server.
  late String _url;

  // Port of the gRPC server.
  late int _port;

  // Indicates if the connection should be secure.
  late bool _secure;

  // Device ID to be included in the metadata.
  late String _deviceId;

  // Application token for authentication.
  late String _appToken;

  // User agent string for the gRPC client.
  late String _userAgent;

  // Stream controller for connection state changes.
  final _streamControllerState = StreamController<ConnectionState>();

  // Subscription to the current channel's state changes; cancelled before
  // the channel is replaced so a stale channel cannot emit into the stream.
  StreamSubscription<ConnectionState>? _stateSubscription;

  // Logger for logging connection state changes and errors.
  final Logger _logger = Logger('GrpcChannel');

  // Certificate for secure connection.
  List<int>? _cert;

  /// Initializes the gRPC channel with the provided parameters.
  ///
  /// [url] The URL of the gRPC server.
  /// [appToken] The application token for authentication.
  /// [deviceId] The device ID to be included in the metadata.
  /// [userAgent] The user agent string for the gRPC client.
  /// [port] The port of the gRPC server.
  /// [secure] Indicates if the connection should be secure.
  Future<void> init({
    required String url,
    required String appToken,
    required String deviceId,
    required String userAgent,
    required int port,
    required bool secure,
    List<int>? cert,
  }) async {
    _url = url;
    _secure = secure;
    _port = port;
    _deviceId = deviceId;
    _appToken = appToken;
    _userAgent = userAgent;
    _cert = cert;

    await _shutdownChannel();
    _createChannel();
    _createStubs();
  }

  /// Sets the access token and rebuilds the client stubs.
  ///
  /// The channel itself is reused: the token only affects per-call metadata,
  /// so recreating the underlying HTTP/2 connection is not needed.
  Future<void> setAccessToken(String accessToken) async {
    _accessToken = accessToken;
    _logger.info('Setting new access token and rebuilding client stubs.');

    _createStubs();
  }

  /// Gets the customer client stub.
  CustomerClient get customerStub => _customerStub;

  /// Gets the media storage client stub.
  MediaStorageClient get mediaStorageStub => _mediaStorageStub;

  /// Gets the gRPC channel.
  ClientChannel get channel => _channel!;

  /// Gets the stream controller for connection state changes.
  StreamController<ConnectionState> get stateStream => _streamControllerState;

  /// Creates the gRPC channel and subscribes to its state changes.
  void _createChannel() {
    _logger.info(
        'Creating gRPC channel with the following parameters: URL: $_url, Port: $_port, Secure: $_secure, Device ID: $_deviceId, User Agent: $_userAgent');

    _channel = ClientChannel(
      _url,
      port: _port,
      options: ChannelOptions(
        credentials: _secure
            ? ChannelCredentials.secure(certificates: _cert)
            : ChannelCredentials.insecure(),
        userAgent: _userAgent,
        connectTimeout: Duration(seconds: 15),
        keepAlive: ClientKeepAliveOptions(
          // gRPC servers reject client pings arriving more often than their
          // keepalive enforcement policy allows (5 minutes by default) with
          // GOAWAY too_many_pings, which kills the connection. Do not lower
          // this without lowering the server-side policy first.
          pingInterval: Duration(minutes: 5),
          timeout: Duration(seconds: 20),
        ),
      ),
    );

    _stateSubscription = _channel!.onConnectionStateChanged.listen((state) {
      _logger.info('Connection state changed: $state');
      _streamControllerState.add(state);
    });
  }

  /// (Re)creates the client stubs with the current metadata.
  void _createStubs() {
    final options = CallOptionsBuilder()
        .setDeviceId(_deviceId)
        .setClientToken(_appToken)
        .setAccessToken(_accessToken)
        .build();

    _customerStub = CustomerClient(_channel!, options: options);
    _mediaStorageStub = MediaStorageClient(_channel!, options: options);

    _logger.info('Client stubs initialized successfully.');
  }

  /// Shuts down the current channel, if any, releasing its sockets and
  /// detaching its state listener.
  Future<void> _shutdownChannel() async {
    await _stateSubscription?.cancel();
    _stateSubscription = null;

    final channel = _channel;
    _channel = null;
    if (channel != null) {
      try {
        await channel.shutdown();
      } catch (err) {
        _logger.warning('Error while shutting down previous channel: $err');
      }
    }
  }
}
