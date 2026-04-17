// This is a generated file - do not edit.
//
// Generated from portal/media.proto.

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

import '../chat/messages/message.pb.dart' as $1;
import 'media.pb.dart' as $0;

export 'media.pb.dart';

/// Media (file) storage
@$pb.GrpcServiceName('webitel.portal.MediaStorage')
class MediaStorageClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  MediaStorageClient(super.channel, {super.options, super.interceptors});

  /// Upload new media content.
  /// Continue incomplete upload.
  $grpc.ResponseStream<$0.UploadProgress> upload(
    $async.Stream<$0.UploadRequest> request, {
    $grpc.CallOptions? options,
  }) {
    return $createStreamingCall(_$upload, request, options: options);
  }

  /// Upload a file (without actually sending it to the chat)
  /// Deprecated: Use [MediaStorage.Upload] instead.
  $grpc.ResponseFuture<$1.File> uploadFile(
    $async.Stream<$0.UploadMedia> request, {
    $grpc.CallOptions? options,
  }) {
    return $createStreamingCall(_$uploadFile, request, options: options).single;
  }

  /// Returns content of a whole file
  $grpc.ResponseStream<$0.MediaFile> getFile(
    $0.GetFileRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createStreamingCall(
        _$getFile, $async.Stream.fromIterable([request]),
        options: options);
  }

  // method descriptors

  static final _$upload =
      $grpc.ClientMethod<$0.UploadRequest, $0.UploadProgress>(
          '/webitel.portal.MediaStorage/Upload',
          ($0.UploadRequest value) => value.writeToBuffer(),
          $0.UploadProgress.fromBuffer);
  static final _$uploadFile = $grpc.ClientMethod<$0.UploadMedia, $1.File>(
      '/webitel.portal.MediaStorage/UploadFile',
      ($0.UploadMedia value) => value.writeToBuffer(),
      $1.File.fromBuffer);
  static final _$getFile = $grpc.ClientMethod<$0.GetFileRequest, $0.MediaFile>(
      '/webitel.portal.MediaStorage/GetFile',
      ($0.GetFileRequest value) => value.writeToBuffer(),
      $0.MediaFile.fromBuffer);
}

@$pb.GrpcServiceName('webitel.portal.MediaStorage')
abstract class MediaStorageServiceBase extends $grpc.Service {
  $core.String get $name => 'webitel.portal.MediaStorage';

  MediaStorageServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.UploadRequest, $0.UploadProgress>(
        'Upload',
        upload,
        true,
        true,
        ($core.List<$core.int> value) => $0.UploadRequest.fromBuffer(value),
        ($0.UploadProgress value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UploadMedia, $1.File>(
        'UploadFile',
        uploadFile,
        true,
        false,
        ($core.List<$core.int> value) => $0.UploadMedia.fromBuffer(value),
        ($1.File value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetFileRequest, $0.MediaFile>(
        'GetFile',
        getFile_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $0.GetFileRequest.fromBuffer(value),
        ($0.MediaFile value) => value.writeToBuffer()));
  }

  $async.Stream<$0.UploadProgress> upload(
      $grpc.ServiceCall call, $async.Stream<$0.UploadRequest> request);

  $async.Future<$1.File> uploadFile(
      $grpc.ServiceCall call, $async.Stream<$0.UploadMedia> request);

  $async.Stream<$0.MediaFile> getFile_Pre($grpc.ServiceCall $call,
      $async.Future<$0.GetFileRequest> $request) async* {
    yield* getFile($call, await $request);
  }

  $async.Stream<$0.MediaFile> getFile(
      $grpc.ServiceCall call, $0.GetFileRequest request);
}
