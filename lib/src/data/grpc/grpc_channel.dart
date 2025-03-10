import 'dart:async';

import 'package:grpc/grpc.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:retry/retry.dart';
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

  // gRPC channel.
  late ClientChannel _channel;

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
    await _createChannel(
      url: url,
      deviceId: deviceId,
      appToken: appToken,
      userAgent: _userAgent,
      port: port,
      secure: secure,
      cert: _cert,
    );
  }

  /// Sets the access token and reinitializes the channel.
  ///
  /// [accessToken] The new access token.
  Future<void> setAccessToken(String accessToken) async {
    _accessToken = accessToken;
    _logger
        .info('Setting new access token and reinitializing the gRPC channel.');

    await _createChannel(
      url: _url,
      port: _port,
      secure: _secure,
      deviceId: _deviceId,
      appToken: _appToken,
      userAgent: _userAgent,
    );
  }

  /// Gets the customer client stub.
  CustomerClient get customerStub => _customerStub;

  /// Gets the media storage client stub.
  MediaStorageClient get mediaStorageStub => _mediaStorageStub;

  /// Gets the gRPC channel.
  ClientChannel get channel => _channel;

  /// Gets the stream controller for connection state changes.
  StreamController<ConnectionState> get stateStream => _streamControllerState;

  /// Creates and initializes the gRPC channel and client stubs.
  ///
  /// [deviceId] The device ID to be included in the metadata.
  /// [appToken] The application token for authentication.
  /// [userAgent] The user agent string for the gRPC client.
  /// [port] The port of the gRPC server.
  /// [url] The URL of the gRPC server.
  /// [secure] Indicates if the connection should be secure.
  Future<void> _createChannel({
    required String deviceId,
    required String appToken,
    required String userAgent,
    required int port,
    required String url,
    required bool secure,
    List<int>? cert,
  }) async {
    _logger.info(
        'Creating gRPC channel with the following parameters: URL: $_url, Port: $_port, Secure: $_secure, Device ID: $_deviceId, User Agent: $_userAgent');

    // Create the gRPC channel with the specified options.
    _channel = ClientChannel(
      url,
      port: port,
      options: ChannelOptions(
        credentials: secure
            ? ChannelCredentials.secure(certificates: cert)
            : ChannelCredentials.insecure(),
        userAgent: userAgent,
        idleTimeout: Duration(minutes: 5),
        connectionTimeout: Duration(minutes: 50),
        keepAlive: ClientKeepAliveOptions(
          pingInterval: Duration(seconds: 3),
          timeout: Duration(seconds: 2),
        ),
      ),
    );

    // Listen for connection state changes and handle reconnections.
    _channel.onConnectionStateChanged.listen((state) {
      _logger.info('Connection state changed: $state');
      _streamControllerState.add(state);

      if (state == ConnectionState.shutdown) {
        _logger.warning(
            'Connection has been shutdown. Attempting to reconnect...');

        _reconnect();
      }
    });

    // Initialize customer client stub with call options.
    _customerStub = CustomerClient(
      _channel,
      options: CallOptionsBuilder()
          .setDeviceId(deviceId)
          .setClientToken(appToken)
          .setAccessToken(_accessToken)
          .build(),
    );

    _logger.info('Customer client stub initialized successfully.');

    // Initialize media storage client stub with call options.
    _mediaStorageStub = MediaStorageClient(
      _channel,
      options: CallOptionsBuilder()
          .setDeviceId(deviceId)
          .setClientToken(appToken)
          .setAccessToken(_accessToken)
          .build(),
    );

    _logger.info('Media storage client stub initialized successfully.');
  }

  /// Attempts to reconnect to the gRPC server with retry strategy.
  Future<void> _reconnect() async {
    try {
      await retry(
        () async {
          await _createChannel(
            url: _url,
            port: _port,
            secure: _secure,
            deviceId: _deviceId,
            appToken: _appToken,
            userAgent: _userAgent,
          );

          _logger.info(
              'Reconnection successful with the following parameters: URL: $_url, Port: $_port, Secure: $_secure, Device ID: $_deviceId, User Agent: $_userAgent');
        },
        retryIf: (err) => err is GrpcError,
        onRetry: (err) => _logger.warning(
            'Retrying due to GrpcError while reconnecting to gRPC server: ${err.toString()}'),
      );
    } catch (err) {
      _logger.severe(
          'Maximum reconnection attempts reached. Unable to reconnect to the gRPC server. Error: $err');
    }
  }
}
