// This is a generated file - do not edit.
//
// Generated from portal/customer.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'auth.pb.dart' as $1;
import 'connect.pb.dart' as $0;
import 'customer.pb.dart' as $2;

export 'customer.pb.dart';

/// Portal Customer Service
@$pb.GrpcServiceName('webitel.portal.Customer')
class CustomerClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  CustomerClient(super.channel, {super.options, super.interceptors});

  /// Network PING command
  $grpc.ResponseFuture<$0.Echo> ping(
    $0.Echo request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$ping, request, options: options);
  }

  /// Obtain your user's access token to portal services.
  $grpc.ResponseFuture<$1.AccessToken> token(
    $1.TokenRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$token, request, options: options);
  }

  /// Logout session request
  $grpc.ResponseFuture<$0.UpdateDisconnect> logout(
    $2.LogoutRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$logout, request, options: options);
  }

  /// Inspect your authorization access token
  $grpc.ResponseFuture<$1.AccessToken> inspect(
    $2.InspectRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$inspect, request, options: options);
  }

  /// Register device PUSH subscription
  $grpc.ResponseFuture<$2.RegisterDeviceResponse> registerDevice(
    $2.RegisterDeviceRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$registerDevice, request, options: options);
  }

  /// Stay connected to the service and receive real-time updates
  $grpc.ResponseStream<$0.Update> connect(
    $async.Stream<$0.Request> request, {
    $grpc.CallOptions? options,
  }) {
    return $createStreamingCall(_$connect, request, options: options);
  }

  // method descriptors

  static final _$ping = $grpc.ClientMethod<$0.Echo, $0.Echo>(
      '/webitel.portal.Customer/Ping',
      ($0.Echo value) => value.writeToBuffer(),
      $0.Echo.fromBuffer);
  static final _$token = $grpc.ClientMethod<$1.TokenRequest, $1.AccessToken>(
      '/webitel.portal.Customer/Token',
      ($1.TokenRequest value) => value.writeToBuffer(),
      $1.AccessToken.fromBuffer);
  static final _$logout =
      $grpc.ClientMethod<$2.LogoutRequest, $0.UpdateDisconnect>(
          '/webitel.portal.Customer/Logout',
          ($2.LogoutRequest value) => value.writeToBuffer(),
          $0.UpdateDisconnect.fromBuffer);
  static final _$inspect =
      $grpc.ClientMethod<$2.InspectRequest, $1.AccessToken>(
          '/webitel.portal.Customer/Inspect',
          ($2.InspectRequest value) => value.writeToBuffer(),
          $1.AccessToken.fromBuffer);
  static final _$registerDevice =
      $grpc.ClientMethod<$2.RegisterDeviceRequest, $2.RegisterDeviceResponse>(
          '/webitel.portal.Customer/RegisterDevice',
          ($2.RegisterDeviceRequest value) => value.writeToBuffer(),
          $2.RegisterDeviceResponse.fromBuffer);
  static final _$connect = $grpc.ClientMethod<$0.Request, $0.Update>(
      '/webitel.portal.Customer/Connect',
      ($0.Request value) => value.writeToBuffer(),
      $0.Update.fromBuffer);
}

@$pb.GrpcServiceName('webitel.portal.Customer')
abstract class CustomerServiceBase extends $grpc.Service {
  $core.String get $name => 'webitel.portal.Customer';

  CustomerServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.Echo, $0.Echo>(
        'Ping',
        ping_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Echo.fromBuffer(value),
        ($0.Echo value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.TokenRequest, $1.AccessToken>(
        'Token',
        token_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.TokenRequest.fromBuffer(value),
        ($1.AccessToken value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.LogoutRequest, $0.UpdateDisconnect>(
        'Logout',
        logout_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.LogoutRequest.fromBuffer(value),
        ($0.UpdateDisconnect value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.InspectRequest, $1.AccessToken>(
        'Inspect',
        inspect_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.InspectRequest.fromBuffer(value),
        ($1.AccessToken value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.RegisterDeviceRequest,
            $2.RegisterDeviceResponse>(
        'RegisterDevice',
        registerDevice_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $2.RegisterDeviceRequest.fromBuffer(value),
        ($2.RegisterDeviceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Request, $0.Update>(
        'Connect',
        connect,
        true,
        true,
        ($core.List<$core.int> value) => $0.Request.fromBuffer(value),
        ($0.Update value) => value.writeToBuffer()));
  }

  $async.Future<$0.Echo> ping_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.Echo> $request) async {
    return ping($call, await $request);
  }

  $async.Future<$0.Echo> ping($grpc.ServiceCall call, $0.Echo request);

  $async.Future<$1.AccessToken> token_Pre(
      $grpc.ServiceCall $call, $async.Future<$1.TokenRequest> $request) async {
    return token($call, await $request);
  }

  $async.Future<$1.AccessToken> token(
      $grpc.ServiceCall call, $1.TokenRequest request);

  $async.Future<$0.UpdateDisconnect> logout_Pre(
      $grpc.ServiceCall $call, $async.Future<$2.LogoutRequest> $request) async {
    return logout($call, await $request);
  }

  $async.Future<$0.UpdateDisconnect> logout(
      $grpc.ServiceCall call, $2.LogoutRequest request);

  $async.Future<$1.AccessToken> inspect_Pre($grpc.ServiceCall $call,
      $async.Future<$2.InspectRequest> $request) async {
    return inspect($call, await $request);
  }

  $async.Future<$1.AccessToken> inspect(
      $grpc.ServiceCall call, $2.InspectRequest request);

  $async.Future<$2.RegisterDeviceResponse> registerDevice_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$2.RegisterDeviceRequest> $request) async {
    return registerDevice($call, await $request);
  }

  $async.Future<$2.RegisterDeviceResponse> registerDevice(
      $grpc.ServiceCall call, $2.RegisterDeviceRequest request);

  $async.Stream<$0.Update> connect(
      $grpc.ServiceCall call, $async.Stream<$0.Request> request);
}
