// This is a generated file - do not edit.
//
// Generated from chat/messages/history.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'chat.pb.dart' as $1;
import 'message.pb.dart' as $0;
import 'peer.pb.dart' as $2;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

/// ChatMessages dataset
class ChatMessages extends $pb.GeneratedMessage {
  factory ChatMessages({
    $core.Iterable<$0.Message>? messages,
    $core.Iterable<$1.Chat>? chats,
    $core.Iterable<$2.Peer>? peers,
    $core.int? page,
    $core.bool? next,
  }) {
    final result = create();
    if (messages != null) result.messages.addAll(messages);
    if (chats != null) result.chats.addAll(chats);
    if (peers != null) result.peers.addAll(peers);
    if (page != null) result.page = page;
    if (next != null) result.next = next;
    return result;
  }

  ChatMessages._();

  factory ChatMessages.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ChatMessages.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ChatMessages',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'webitel.chat'),
      createEmptyInstance: create)
    ..pPM<$0.Message>(1, _omitFieldNames ? '' : 'messages',
        subBuilder: $0.Message.create)
    ..pPM<$1.Chat>(2, _omitFieldNames ? '' : 'chats',
        subBuilder: $1.Chat.create)
    ..pPM<$2.Peer>(3, _omitFieldNames ? '' : 'peers',
        subBuilder: $2.Peer.create)
    ..aI(5, _omitFieldNames ? '' : 'page')
    ..aOB(6, _omitFieldNames ? '' : 'next')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChatMessages clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChatMessages copyWith(void Function(ChatMessages) updates) =>
      super.copyWith((message) => updates(message as ChatMessages))
          as ChatMessages;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ChatMessages create() => ChatMessages._();
  @$core.override
  ChatMessages createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ChatMessages getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ChatMessages>(create);
  static ChatMessages? _defaultInstance;

  /// Dataset page of messages.
  @$pb.TagNumber(1)
  $pb.PbList<$0.Message> get messages => $_getList(0);

  /// List of chats mentioned in messages. [FROM]
  @$pb.TagNumber(2)
  $pb.PbList<$1.Chat> get chats => $_getList(1);

  /// List of peers mentioned in messages. [FROM]
  @$pb.TagNumber(3)
  $pb.PbList<$2.Peer> get peers => $_getList(2);

  /// Dataset page number.
  @$pb.TagNumber(5)
  $core.int get page => $_getIZ(3);
  @$pb.TagNumber(5)
  set page($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(5)
  $core.bool hasPage() => $_has(3);
  @$pb.TagNumber(5)
  void clearPage() => $_clearField(5);

  /// Next page is available ?
  @$pb.TagNumber(6)
  $core.bool get next => $_getBF(4);
  @$pb.TagNumber(6)
  set next($core.bool value) => $_setBool(4, value);
  @$pb.TagNumber(6)
  $core.bool hasNext() => $_has(4);
  @$pb.TagNumber(6)
  void clearNext() => $_clearField(6);
}

/// Offset options
class ChatMessagesRequest_Offset extends $pb.GeneratedMessage {
  factory ChatMessagesRequest_Offset({
    $fixnum.Int64? id,
    $fixnum.Int64? date,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (date != null) result.date = date;
    return result;
  }

  ChatMessagesRequest_Offset._();

  factory ChatMessagesRequest_Offset.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ChatMessagesRequest_Offset.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ChatMessagesRequest.Offset',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'webitel.chat'),
      createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'id')
    ..aInt64(2, _omitFieldNames ? '' : 'date')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChatMessagesRequest_Offset clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChatMessagesRequest_Offset copyWith(
          void Function(ChatMessagesRequest_Offset) updates) =>
      super.copyWith(
              (message) => updates(message as ChatMessagesRequest_Offset))
          as ChatMessagesRequest_Offset;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ChatMessagesRequest_Offset create() => ChatMessagesRequest_Offset._();
  @$core.override
  ChatMessagesRequest_Offset createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ChatMessagesRequest_Offset getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ChatMessagesRequest_Offset>(create);
  static ChatMessagesRequest_Offset? _defaultInstance;

  /// Messages ONLY starting from the specified message ID
  @$pb.TagNumber(1)
  $fixnum.Int64 get id => $_getI64(0);
  @$pb.TagNumber(1)
  set id($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  /// Messages ONLY been sent before the specified epochtime(milli).
  @$pb.TagNumber(2)
  $fixnum.Int64 get date => $_getI64(1);
  @$pb.TagNumber(2)
  set date($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasDate() => $_has(1);
  @$pb.TagNumber(2)
  void clearDate() => $_clearField(2);
}

enum ChatMessagesRequest_Chat { chatId, peer, notSet }

class ChatMessagesRequest extends $pb.GeneratedMessage {
  factory ChatMessagesRequest({
    ChatMessagesRequest_Offset? offset,
    $core.int? limit,
    $core.Iterable<$core.String>? fields,
    $core.String? q,
    $core.String? chatId,
    $2.Peer? peer,
  }) {
    final result = create();
    if (offset != null) result.offset = offset;
    if (limit != null) result.limit = limit;
    if (fields != null) result.fields.addAll(fields);
    if (q != null) result.q = q;
    if (chatId != null) result.chatId = chatId;
    if (peer != null) result.peer = peer;
    return result;
  }

  ChatMessagesRequest._();

  factory ChatMessagesRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ChatMessagesRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static const $core.Map<$core.int, ChatMessagesRequest_Chat>
      _ChatMessagesRequest_ChatByTag = {
    6: ChatMessagesRequest_Chat.chatId,
    7: ChatMessagesRequest_Chat.peer,
    0: ChatMessagesRequest_Chat.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ChatMessagesRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'webitel.chat'),
      createEmptyInstance: create)
    ..oo(0, [6, 7])
    ..aOM<ChatMessagesRequest_Offset>(1, _omitFieldNames ? '' : 'offset',
        subBuilder: ChatMessagesRequest_Offset.create)
    ..aI(2, _omitFieldNames ? '' : 'limit')
    ..pPS(3, _omitFieldNames ? '' : 'fields')
    ..aOS(5, _omitFieldNames ? '' : 'q')
    ..aOS(6, _omitFieldNames ? '' : 'chatId')
    ..aOM<$2.Peer>(7, _omitFieldNames ? '' : 'peer', subBuilder: $2.Peer.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChatMessagesRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChatMessagesRequest copyWith(void Function(ChatMessagesRequest) updates) =>
      super.copyWith((message) => updates(message as ChatMessagesRequest))
          as ChatMessagesRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ChatMessagesRequest create() => ChatMessagesRequest._();
  @$core.override
  ChatMessagesRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ChatMessagesRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ChatMessagesRequest>(create);
  static ChatMessagesRequest? _defaultInstance;

  @$pb.TagNumber(6)
  @$pb.TagNumber(7)
  ChatMessagesRequest_Chat whichChat() =>
      _ChatMessagesRequest_ChatByTag[$_whichOneof(0)]!;
  @$pb.TagNumber(6)
  @$pb.TagNumber(7)
  void clearChat() => $_clearField($_whichOneof(0));

  /// Offset messages.
  @$pb.TagNumber(1)
  ChatMessagesRequest_Offset get offset => $_getN(0);
  @$pb.TagNumber(1)
  set offset(ChatMessagesRequest_Offset value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasOffset() => $_has(0);
  @$pb.TagNumber(1)
  void clearOffset() => $_clearField(1);
  @$pb.TagNumber(1)
  ChatMessagesRequest_Offset ensureOffset() => $_ensure(0);

  /// Number of messages to return.
  @$pb.TagNumber(2)
  $core.int get limit => $_getIZ(1);
  @$pb.TagNumber(2)
  set limit($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasLimit() => $_has(1);
  @$pb.TagNumber(2)
  void clearLimit() => $_clearField(2);

  /// Fields to return into result.
  @$pb.TagNumber(3)
  $pb.PbList<$core.String> get fields => $_getList(2);

  /// Search term: message.text
  @$pb.TagNumber(5)
  $core.String get q => $_getSZ(3);
  @$pb.TagNumber(5)
  set q($core.String value) => $_setString(3, value);
  @$pb.TagNumber(5)
  $core.bool hasQ() => $_has(3);
  @$pb.TagNumber(5)
  void clearQ() => $_clearField(5);

  /// Unique chat dialog
  @$pb.TagNumber(6)
  $core.String get chatId => $_getSZ(4);
  @$pb.TagNumber(6)
  set chatId($core.String value) => $_setString(4, value);
  @$pb.TagNumber(6)
  $core.bool hasChatId() => $_has(4);
  @$pb.TagNumber(6)
  void clearChatId() => $_clearField(6);

  /// Unique peer contact
  @$pb.TagNumber(7)
  $2.Peer get peer => $_getN(5);
  @$pb.TagNumber(7)
  set peer($2.Peer value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasPeer() => $_has(5);
  @$pb.TagNumber(7)
  void clearPeer() => $_clearField(7);
  @$pb.TagNumber(7)
  $2.Peer ensurePeer() => $_ensure(5);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
