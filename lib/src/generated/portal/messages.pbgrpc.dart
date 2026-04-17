// This is a generated file - do not edit.
//
// Generated from portal/messages.proto.

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

import '../chat/messages/history.pb.dart' as $1;
import 'messages.pb.dart' as $0;

export 'messages.pb.dart';

/// Customer Messaging Service
@$pb.GrpcServiceName('webitel.portal.ChatMessages')
class ChatMessagesClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  ChatMessagesClient(super.channel, {super.options, super.interceptors});

  /// Returns the current user dialogs list.
  $grpc.ResponseFuture<$0.ChatList> chatDialogs(
    $0.ChatDialogsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$chatDialogs, request, options: options);
  }

  /// Sends a message to the chat.
  $grpc.ResponseFuture<$0.UpdateNewMessage> sendMessage(
    $0.SendMessageRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$sendMessage, request, options: options);
  }

  /// Marks message history as read.
  $grpc.ResponseFuture<$0.UpdateReadHistoryInbox> readHistory(
    $0.ReadHistoryRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$readHistory, request, options: options);
  }

  /// Returns the conversation history with one interlocutor / within a chat.
  /// Posible peer( type: string! ):
  /// * "chat" ; A separate dialog from general correspondence with the interlocutor
  /// * "user" ; Linked dialogs of general correspondence with the contact. Not implemented.
  /// * <none> ; Points [TO] the default portal service (bot) chat dialog.
  $grpc.ResponseFuture<$1.ChatMessages> chatHistory(
    $1.ChatMessagesRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$chatHistory, request, options: options);
  }

  /// Returns the chat (peer) history updates (difference) since offset (state).
  $grpc.ResponseFuture<$1.ChatMessages> chatUpdates(
    $1.ChatMessagesRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$chatUpdates, request, options: options);
  }

  // method descriptors

  static final _$chatDialogs =
      $grpc.ClientMethod<$0.ChatDialogsRequest, $0.ChatList>(
          '/webitel.portal.ChatMessages/ChatDialogs',
          ($0.ChatDialogsRequest value) => value.writeToBuffer(),
          $0.ChatList.fromBuffer);
  static final _$sendMessage =
      $grpc.ClientMethod<$0.SendMessageRequest, $0.UpdateNewMessage>(
          '/webitel.portal.ChatMessages/SendMessage',
          ($0.SendMessageRequest value) => value.writeToBuffer(),
          $0.UpdateNewMessage.fromBuffer);
  static final _$readHistory =
      $grpc.ClientMethod<$0.ReadHistoryRequest, $0.UpdateReadHistoryInbox>(
          '/webitel.portal.ChatMessages/ReadHistory',
          ($0.ReadHistoryRequest value) => value.writeToBuffer(),
          $0.UpdateReadHistoryInbox.fromBuffer);
  static final _$chatHistory =
      $grpc.ClientMethod<$1.ChatMessagesRequest, $1.ChatMessages>(
          '/webitel.portal.ChatMessages/ChatHistory',
          ($1.ChatMessagesRequest value) => value.writeToBuffer(),
          $1.ChatMessages.fromBuffer);
  static final _$chatUpdates =
      $grpc.ClientMethod<$1.ChatMessagesRequest, $1.ChatMessages>(
          '/webitel.portal.ChatMessages/ChatUpdates',
          ($1.ChatMessagesRequest value) => value.writeToBuffer(),
          $1.ChatMessages.fromBuffer);
}

@$pb.GrpcServiceName('webitel.portal.ChatMessages')
abstract class ChatMessagesServiceBase extends $grpc.Service {
  $core.String get $name => 'webitel.portal.ChatMessages';

  ChatMessagesServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.ChatDialogsRequest, $0.ChatList>(
        'ChatDialogs',
        chatDialogs_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.ChatDialogsRequest.fromBuffer(value),
        ($0.ChatList value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.SendMessageRequest, $0.UpdateNewMessage>(
        'SendMessage',
        sendMessage_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.SendMessageRequest.fromBuffer(value),
        ($0.UpdateNewMessage value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.ReadHistoryRequest, $0.UpdateReadHistoryInbox>(
            'ReadHistory',
            readHistory_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.ReadHistoryRequest.fromBuffer(value),
            ($0.UpdateReadHistoryInbox value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.ChatMessagesRequest, $1.ChatMessages>(
        'ChatHistory',
        chatHistory_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.ChatMessagesRequest.fromBuffer(value),
        ($1.ChatMessages value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.ChatMessagesRequest, $1.ChatMessages>(
        'ChatUpdates',
        chatUpdates_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.ChatMessagesRequest.fromBuffer(value),
        ($1.ChatMessages value) => value.writeToBuffer()));
  }

  $async.Future<$0.ChatList> chatDialogs_Pre($grpc.ServiceCall $call,
      $async.Future<$0.ChatDialogsRequest> $request) async {
    return chatDialogs($call, await $request);
  }

  $async.Future<$0.ChatList> chatDialogs(
      $grpc.ServiceCall call, $0.ChatDialogsRequest request);

  $async.Future<$0.UpdateNewMessage> sendMessage_Pre($grpc.ServiceCall $call,
      $async.Future<$0.SendMessageRequest> $request) async {
    return sendMessage($call, await $request);
  }

  $async.Future<$0.UpdateNewMessage> sendMessage(
      $grpc.ServiceCall call, $0.SendMessageRequest request);

  $async.Future<$0.UpdateReadHistoryInbox> readHistory_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.ReadHistoryRequest> $request) async {
    return readHistory($call, await $request);
  }

  $async.Future<$0.UpdateReadHistoryInbox> readHistory(
      $grpc.ServiceCall call, $0.ReadHistoryRequest request);

  $async.Future<$1.ChatMessages> chatHistory_Pre($grpc.ServiceCall $call,
      $async.Future<$1.ChatMessagesRequest> $request) async {
    return chatHistory($call, await $request);
  }

  $async.Future<$1.ChatMessages> chatHistory(
      $grpc.ServiceCall call, $1.ChatMessagesRequest request);

  $async.Future<$1.ChatMessages> chatUpdates_Pre($grpc.ServiceCall $call,
      $async.Future<$1.ChatMessagesRequest> $request) async {
    return chatUpdates($call, await $request);
  }

  $async.Future<$1.ChatMessages> chatUpdates(
      $grpc.ServiceCall call, $1.ChatMessagesRequest request);
}
