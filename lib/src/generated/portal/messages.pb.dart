// This is a generated file - do not edit.
//
// Generated from portal/messages.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;
import 'package:protobuf/well_known_types/google/protobuf/wrappers.pb.dart'
    as $5;

import '../chat/messages/chat.pb.dart' as $4;
import '../chat/messages/message.pb.dart' as $3;
import '../chat/messages/peer.pb.dart' as $2;
import 'messages.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'messages.pbenum.dart';

/// Customer end-User messaging account settings
class ChatAccount extends $pb.GeneratedMessage {
  factory ChatAccount({
    $2.Peer? user,
  }) {
    final result = create();
    if (user != null) result.user = user;
    return result;
  }

  ChatAccount._();

  factory ChatAccount.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ChatAccount.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ChatAccount',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'webitel.portal'),
      createEmptyInstance: create)
    ..aOM<$2.Peer>(1, _omitFieldNames ? '' : 'user', subBuilder: $2.Peer.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChatAccount clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChatAccount copyWith(void Function(ChatAccount) updates) =>
      super.copyWith((message) => updates(message as ChatAccount))
          as ChatAccount;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ChatAccount create() => ChatAccount._();
  @$core.override
  ChatAccount createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ChatAccount getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ChatAccount>(create);
  static ChatAccount? _defaultInstance;

  /// User self. The sender. You.
  @$pb.TagNumber(1)
  $2.Peer get user => $_getN(0);
  @$pb.TagNumber(1)
  set user($2.Peer value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasUser() => $_has(0);
  @$pb.TagNumber(1)
  void clearUser() => $_clearField(1);
  @$pb.TagNumber(1)
  $2.Peer ensureUser() => $_ensure(0);
}

/// Chat info.
/// Reflects chat/messages.Chat
class Chat extends $pb.GeneratedMessage {
  factory Chat({
    $core.int? inbox,
    $core.String? id,
    $2.Peer? peer,
    $fixnum.Int64? date,
    $core.String? title,
    $fixnum.Int64? left,
    $fixnum.Int64? join,
    $3.Message? message,
  }) {
    final result = create();
    if (inbox != null) result.inbox = inbox;
    if (id != null) result.id = id;
    if (peer != null) result.peer = peer;
    if (date != null) result.date = date;
    if (title != null) result.title = title;
    if (left != null) result.left = left;
    if (join != null) result.join = join;
    if (message != null) result.message = message;
    return result;
  }

  Chat._();

  factory Chat.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Chat.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Chat',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'webitel.portal'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'inbox')
    ..aOS(2, _omitFieldNames ? '' : 'id')
    ..aOM<$2.Peer>(4, _omitFieldNames ? '' : 'peer', subBuilder: $2.Peer.create)
    ..aInt64(6, _omitFieldNames ? '' : 'date')
    ..aOS(7, _omitFieldNames ? '' : 'title')
    ..aInt64(8, _omitFieldNames ? '' : 'left')
    ..aInt64(9, _omitFieldNames ? '' : 'join')
    ..aOM<$3.Message>(10, _omitFieldNames ? '' : 'message',
        subBuilder: $3.Message.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Chat clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Chat copyWith(void Function(Chat) updates) =>
      super.copyWith((message) => updates(message as Chat)) as Chat;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Chat create() => Chat._();
  @$core.override
  Chat createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Chat getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Chat>(create);
  static Chat? _defaultInstance;

  /// Inbox NEW [unread] message(s) count.
  /// ( chat.message.id ~ read.message.id )
  @$pb.TagNumber(1)
  $core.int get inbox => $_getIZ(0);
  @$pb.TagNumber(1)
  set inbox($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasInbox() => $_has(0);
  @$pb.TagNumber(1)
  void clearInbox() => $_clearField(1);

  /// ID of the chat.
  @$pb.TagNumber(2)
  $core.String get id => $_getSZ(1);
  @$pb.TagNumber(2)
  set id($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasId() => $_has(1);
  @$pb.TagNumber(2)
  void clearId() => $_clearField(2);

  /// The Interlocutor. Other side.
  @$pb.TagNumber(4)
  $2.Peer get peer => $_getN(2);
  @$pb.TagNumber(4)
  set peer($2.Peer value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasPeer() => $_has(2);
  @$pb.TagNumber(4)
  void clearPeer() => $_clearField(4);
  @$pb.TagNumber(4)
  $2.Peer ensurePeer() => $_ensure(2);

  /// Timestamp of the last activity in the chat.
  @$pb.TagNumber(6)
  $fixnum.Int64 get date => $_getI64(3);
  @$pb.TagNumber(6)
  set date($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(6)
  $core.bool hasDate() => $_has(3);
  @$pb.TagNumber(6)
  void clearDate() => $_clearField(6);

  /// Title of the chat.
  @$pb.TagNumber(7)
  $core.String get title => $_getSZ(4);
  @$pb.TagNumber(7)
  set title($core.String value) => $_setString(4, value);
  @$pb.TagNumber(7)
  $core.bool hasTitle() => $_has(4);
  @$pb.TagNumber(7)
  void clearTitle() => $_clearField(7);

  /// OPTIONAL. A non-zero value indicates that
  /// the participant has left the chat. CLOSED(!)
  @$pb.TagNumber(8)
  $fixnum.Int64 get left => $_getI64(5);
  @$pb.TagNumber(8)
  set left($fixnum.Int64 value) => $_setInt64(5, value);
  @$pb.TagNumber(8)
  $core.bool hasLeft() => $_has(5);
  @$pb.TagNumber(8)
  void clearLeft() => $_clearField(8);

  /// OPTIONAL. A non-zero value indicates when
  /// the participant joined this chat conversation.
  @$pb.TagNumber(9)
  $fixnum.Int64 get join => $_getI64(6);
  @$pb.TagNumber(9)
  set join($fixnum.Int64 value) => $_setInt64(6, value);
  @$pb.TagNumber(9)
  $core.bool hasJoin() => $_has(6);
  @$pb.TagNumber(9)
  void clearJoin() => $_clearField(9);

  /// Top (last) message in this chat.
  @$pb.TagNumber(10)
  $3.Message get message => $_getN(7);
  @$pb.TagNumber(10)
  set message($3.Message value) => $_setField(10, value);
  @$pb.TagNumber(10)
  $core.bool hasMessage() => $_has(7);
  @$pb.TagNumber(10)
  void clearMessage() => $_clearField(10);
  @$pb.TagNumber(10)
  $3.Message ensureMessage() => $_ensure(7);
}

class ChatDialogsRequest extends $pb.GeneratedMessage {
  factory ChatDialogsRequest({
    $core.int? page,
    $core.int? size,
    $core.Iterable<$core.String>? sort,
    $core.Iterable<$core.String>? fields,
    $core.String? q,
    $core.Iterable<$core.String>? id,
    $2.Peer? peer,
    $4.Timerange? date,
    $5.BoolValue? online,
  }) {
    final result = create();
    if (page != null) result.page = page;
    if (size != null) result.size = size;
    if (sort != null) result.sort.addAll(sort);
    if (fields != null) result.fields.addAll(fields);
    if (q != null) result.q = q;
    if (id != null) result.id.addAll(id);
    if (peer != null) result.peer = peer;
    if (date != null) result.date = date;
    if (online != null) result.online = online;
    return result;
  }

  ChatDialogsRequest._();

  factory ChatDialogsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ChatDialogsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ChatDialogsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'webitel.portal'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'page')
    ..aI(2, _omitFieldNames ? '' : 'size')
    ..pPS(3, _omitFieldNames ? '' : 'sort')
    ..pPS(4, _omitFieldNames ? '' : 'fields')
    ..aOS(5, _omitFieldNames ? '' : 'q')
    ..pPS(6, _omitFieldNames ? '' : 'id')
    ..aOM<$2.Peer>(8, _omitFieldNames ? '' : 'peer', subBuilder: $2.Peer.create)
    ..aOM<$4.Timerange>(9, _omitFieldNames ? '' : 'date',
        subBuilder: $4.Timerange.create)
    ..aOM<$5.BoolValue>(10, _omitFieldNames ? '' : 'online',
        subBuilder: $5.BoolValue.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChatDialogsRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChatDialogsRequest copyWith(void Function(ChatDialogsRequest) updates) =>
      super.copyWith((message) => updates(message as ChatDialogsRequest))
          as ChatDialogsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ChatDialogsRequest create() => ChatDialogsRequest._();
  @$core.override
  ChatDialogsRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ChatDialogsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ChatDialogsRequest>(create);
  static ChatDialogsRequest? _defaultInstance;

  /// Page number to return. **default**: 1.
  @$pb.TagNumber(1)
  $core.int get page => $_getIZ(0);
  @$pb.TagNumber(1)
  set page($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPage() => $_has(0);
  @$pb.TagNumber(1)
  void clearPage() => $_clearField(1);

  /// Page records limit. **default**: 16.
  @$pb.TagNumber(2)
  $core.int get size => $_getIZ(1);
  @$pb.TagNumber(2)
  set size($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSize() => $_has(1);
  @$pb.TagNumber(2)
  void clearSize() => $_clearField(2);

  /// Sort records by { fields } specification.
  @$pb.TagNumber(3)
  $pb.PbList<$core.String> get sort => $_getList(2);

  /// Fields [Q]uery to build result dataset record.
  @$pb.TagNumber(4)
  $pb.PbList<$core.String> get fields => $_getList(3);

  /// Search term: peer.name
  @$pb.TagNumber(5)
  $core.String get q => $_getSZ(4);
  @$pb.TagNumber(5)
  set q($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasQ() => $_has(4);
  @$pb.TagNumber(5)
  void clearQ() => $_clearField(5);

  /// Set of unique chat IDentifier(s).
  /// Accept: dialog -or- member ID.
  @$pb.TagNumber(6)
  $pb.PbList<$core.String> get id => $_getList(5);

  /// [PEER] Member of ...
  @$pb.TagNumber(8)
  $2.Peer get peer => $_getN(6);
  @$pb.TagNumber(8)
  set peer($2.Peer value) => $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasPeer() => $_has(6);
  @$pb.TagNumber(8)
  void clearPeer() => $_clearField(8);
  @$pb.TagNumber(8)
  $2.Peer ensurePeer() => $_ensure(6);

  /// Date within timerange.
  @$pb.TagNumber(9)
  $4.Timerange get date => $_getN(7);
  @$pb.TagNumber(9)
  set date($4.Timerange value) => $_setField(9, value);
  @$pb.TagNumber(9)
  $core.bool hasDate() => $_has(7);
  @$pb.TagNumber(9)
  void clearDate() => $_clearField(9);
  @$pb.TagNumber(9)
  $4.Timerange ensureDate() => $_ensure(7);

  /// Dialogs ONLY that are currently [not] active( closed: ? ).
  @$pb.TagNumber(10)
  $5.BoolValue get online => $_getN(8);
  @$pb.TagNumber(10)
  set online($5.BoolValue value) => $_setField(10, value);
  @$pb.TagNumber(10)
  $core.bool hasOnline() => $_has(8);
  @$pb.TagNumber(10)
  void clearOnline() => $_clearField(10);
  @$pb.TagNumber(10)
  $5.BoolValue ensureOnline() => $_ensure(8);
}

/// ChatDialogs dataset
class ChatList extends $pb.GeneratedMessage {
  factory ChatList({
    $core.Iterable<Chat>? data,
    $core.int? page,
    $core.bool? next,
  }) {
    final result = create();
    if (data != null) result.data.addAll(data);
    if (page != null) result.page = page;
    if (next != null) result.next = next;
    return result;
  }

  ChatList._();

  factory ChatList.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ChatList.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ChatList',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'webitel.portal'),
      createEmptyInstance: create)
    ..pPM<Chat>(1, _omitFieldNames ? '' : 'data', subBuilder: Chat.create)
    ..aI(2, _omitFieldNames ? '' : 'page')
    ..aOB(3, _omitFieldNames ? '' : 'next')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChatList clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChatList copyWith(void Function(ChatList) updates) =>
      super.copyWith((message) => updates(message as ChatList)) as ChatList;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ChatList create() => ChatList._();
  @$core.override
  ChatList createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ChatList getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ChatList>(create);
  static ChatList? _defaultInstance;

  /// Dataset page of Chat(s).
  @$pb.TagNumber(1)
  $pb.PbList<Chat> get data => $_getList(0);

  /// Page number of results.
  @$pb.TagNumber(2)
  $core.int get page => $_getIZ(1);
  @$pb.TagNumber(2)
  set page($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPage() => $_has(1);
  @$pb.TagNumber(2)
  void clearPage() => $_clearField(2);

  /// Next page available ?
  @$pb.TagNumber(3)
  $core.bool get next => $_getBF(2);
  @$pb.TagNumber(3)
  set next($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(3)
  $core.bool hasNext() => $_has(2);
  @$pb.TagNumber(3)
  void clearNext() => $_clearField(3);
}

class SendMessageRequest extends $pb.GeneratedMessage {
  factory SendMessageRequest({
    $2.Peer? peer,
    $3.File? file,
    $core.String? text,
    $core.String? id,
    $3.Postback? postback,
  }) {
    final result = create();
    if (peer != null) result.peer = peer;
    if (file != null) result.file = file;
    if (text != null) result.text = text;
    if (id != null) result.id = id;
    if (postback != null) result.postback = postback;
    return result;
  }

  SendMessageRequest._();

  factory SendMessageRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SendMessageRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SendMessageRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'webitel.portal'),
      createEmptyInstance: create)
    ..aOM<$2.Peer>(1, _omitFieldNames ? '' : 'peer', subBuilder: $2.Peer.create)
    ..aOM<$3.File>(2, _omitFieldNames ? '' : 'file', subBuilder: $3.File.create)
    ..aOS(3, _omitFieldNames ? '' : 'text')
    ..aOS(4, _omitFieldNames ? '' : 'id')
    ..aOM<$3.Postback>(5, _omitFieldNames ? '' : 'postback',
        subBuilder: $3.Postback.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SendMessageRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SendMessageRequest copyWith(void Function(SendMessageRequest) updates) =>
      super.copyWith((message) => updates(message as SendMessageRequest))
          as SendMessageRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SendMessageRequest create() => SendMessageRequest._();
  @$core.override
  SendMessageRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static SendMessageRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SendMessageRequest>(create);
  static SendMessageRequest? _defaultInstance;

  /// The destination where the message will be sent.
  /// - peer{ type:"chat", id: $chat_id }
  /// - peer{ type:"user", id: $user_id }
  /// Missing peer - points TO the default
  /// portal "Service" (bot) chat dialog.
  @$pb.TagNumber(1)
  $2.Peer get peer => $_getN(0);
  @$pb.TagNumber(1)
  set peer($2.Peer value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasPeer() => $_has(0);
  @$pb.TagNumber(1)
  void clearPeer() => $_clearField(1);
  @$pb.TagNumber(1)
  $2.Peer ensurePeer() => $_ensure(0);

  /// Media file uploaded.
  /// Not implemented yet.
  @$pb.TagNumber(2)
  $3.File get file => $_getN(1);
  @$pb.TagNumber(2)
  set file($3.File value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasFile() => $_has(1);
  @$pb.TagNumber(2)
  void clearFile() => $_clearField(2);
  @$pb.TagNumber(2)
  $3.File ensureFile() => $_ensure(1);

  /// Media text message.
  @$pb.TagNumber(3)
  $core.String get text => $_getSZ(2);
  @$pb.TagNumber(3)
  set text($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasText() => $_has(2);
  @$pb.TagNumber(3)
  void clearText() => $_clearField(3);

  /// Client associated message id.
  /// DEFAULT: Connect.Request.id
  @$pb.TagNumber(4)
  $core.String get id => $_getSZ(3);
  @$pb.TagNumber(4)
  set id($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasId() => $_has(3);
  @$pb.TagNumber(4)
  void clearId() => $_clearField(4);

  /// Postback. Quick Reply Button Click[ed].
  @$pb.TagNumber(5)
  $3.Postback get postback => $_getN(4);
  @$pb.TagNumber(5)
  set postback($3.Postback value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasPostback() => $_has(4);
  @$pb.TagNumber(5)
  void clearPostback() => $_clearField(5);
  @$pb.TagNumber(5)
  $3.Postback ensurePostback() => $_ensure(4);
}

class ReadHistoryRequest extends $pb.GeneratedMessage {
  factory ReadHistoryRequest({
    $2.Peer? peer,
    $fixnum.Int64? maxId,
  }) {
    final result = create();
    if (peer != null) result.peer = peer;
    if (maxId != null) result.maxId = maxId;
    return result;
  }

  ReadHistoryRequest._();

  factory ReadHistoryRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ReadHistoryRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ReadHistoryRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'webitel.portal'),
      createEmptyInstance: create)
    ..aOM<$2.Peer>(1, _omitFieldNames ? '' : 'peer', subBuilder: $2.Peer.create)
    ..aInt64(2, _omitFieldNames ? '' : 'maxId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReadHistoryRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReadHistoryRequest copyWith(void Function(ReadHistoryRequest) updates) =>
      super.copyWith((message) => updates(message as ReadHistoryRequest))
          as ReadHistoryRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ReadHistoryRequest create() => ReadHistoryRequest._();
  @$core.override
  ReadHistoryRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ReadHistoryRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ReadHistoryRequest>(create);
  static ReadHistoryRequest? _defaultInstance;

  /// Target chat dialog or user.
  /// - peer{ type:"chat", id: $chat_id }
  /// - peer{ type:"user", id: $user_id }
  /// Missing peer - points TO the default
  /// portal service chat Bot dialog.
  @$pb.TagNumber(1)
  $2.Peer get peer => $_getN(0);
  @$pb.TagNumber(1)
  set peer($2.Peer value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasPeer() => $_has(0);
  @$pb.TagNumber(1)
  void clearPeer() => $_clearField(1);
  @$pb.TagNumber(1)
  $2.Peer ensurePeer() => $_ensure(0);

  /// If a positive value is passed,
  /// only messages with identifiers
  /// less or equal than the given one
  /// will be read.
  @$pb.TagNumber(2)
  $fixnum.Int64 get maxId => $_getI64(1);
  @$pb.TagNumber(2)
  set maxId($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMaxId() => $_has(1);
  @$pb.TagNumber(2)
  void clearMaxId() => $_clearField(2);
}

/// New message in a chat history.
class UpdateNewMessage extends $pb.GeneratedMessage {
  factory UpdateNewMessage({
    Disposition? dispo,
    $3.Message? message,
    $core.String? id,
  }) {
    final result = create();
    if (dispo != null) result.dispo = dispo;
    if (message != null) result.message = message;
    if (id != null) result.id = id;
    return result;
  }

  UpdateNewMessage._();

  factory UpdateNewMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateNewMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateNewMessage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'webitel.portal'),
      createEmptyInstance: create)
    ..aE<Disposition>(1, _omitFieldNames ? '' : 'dispo',
        enumValues: Disposition.values)
    ..aOM<$3.Message>(2, _omitFieldNames ? '' : 'message',
        subBuilder: $3.Message.create)
    ..aOS(3, _omitFieldNames ? '' : 'id')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateNewMessage clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateNewMessage copyWith(void Function(UpdateNewMessage) updates) =>
      super.copyWith((message) => updates(message as UpdateNewMessage))
          as UpdateNewMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateNewMessage create() => UpdateNewMessage._();
  @$core.override
  UpdateNewMessage createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static UpdateNewMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateNewMessage>(create);
  static UpdateNewMessage? _defaultInstance;

  /// Disposition of the current user.
  @$pb.TagNumber(1)
  Disposition get dispo => $_getN(0);
  @$pb.TagNumber(1)
  set dispo(Disposition value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasDispo() => $_has(0);
  @$pb.TagNumber(1)
  void clearDispo() => $_clearField(1);

  /// NEW message details.
  @$pb.TagNumber(2)
  $3.Message get message => $_getN(1);
  @$pb.TagNumber(2)
  set message($3.Message value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);
  @$pb.TagNumber(2)
  $3.Message ensureMessage() => $_ensure(1);

  /// OPTIONAL. Client [send] message id.
  /// DEFAULT: Connect.Request.id
  @$pb.TagNumber(3)
  $core.String get id => $_getSZ(2);
  @$pb.TagNumber(3)
  set id($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasId() => $_has(2);
  @$pb.TagNumber(3)
  void clearId() => $_clearField(3);
}

/// Update about join NEW member(s) to the chat.
class UpdateChatMember extends $pb.GeneratedMessage {
  factory UpdateChatMember({
    $4.Chat? chat,
    $core.Iterable<$2.Peer>? join,
  }) {
    final result = create();
    if (chat != null) result.chat = chat;
    if (join != null) result.join.addAll(join);
    return result;
  }

  UpdateChatMember._();

  factory UpdateChatMember.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateChatMember.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateChatMember',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'webitel.portal'),
      createEmptyInstance: create)
    ..aOM<$4.Chat>(1, _omitFieldNames ? '' : 'chat', subBuilder: $4.Chat.create)
    ..pPM<$2.Peer>(2, _omitFieldNames ? '' : 'join', subBuilder: $2.Peer.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateChatMember clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateChatMember copyWith(void Function(UpdateChatMember) updates) =>
      super.copyWith((message) => updates(message as UpdateChatMember))
          as UpdateChatMember;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateChatMember create() => UpdateChatMember._();
  @$core.override
  UpdateChatMember createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static UpdateChatMember getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateChatMember>(create);
  static UpdateChatMember? _defaultInstance;

  /// Chat [TO] Update.
  @$pb.TagNumber(1)
  $4.Chat get chat => $_getN(0);
  @$pb.TagNumber(1)
  set chat($4.Chat value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasChat() => $_has(0);
  @$pb.TagNumber(1)
  void clearChat() => $_clearField(1);
  @$pb.TagNumber(1)
  $4.Chat ensureChat() => $_ensure(0);

  /// Join NEW member(s)..
  @$pb.TagNumber(2)
  $pb.PbList<$2.Peer> get join => $_getList(1);
}

/// Update about that the member left the chat.
class UpdateLeftMember extends $pb.GeneratedMessage {
  factory UpdateLeftMember({
    $4.Chat? chat,
    $2.Peer? left,
  }) {
    final result = create();
    if (chat != null) result.chat = chat;
    if (left != null) result.left = left;
    return result;
  }

  UpdateLeftMember._();

  factory UpdateLeftMember.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateLeftMember.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateLeftMember',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'webitel.portal'),
      createEmptyInstance: create)
    ..aOM<$4.Chat>(1, _omitFieldNames ? '' : 'chat', subBuilder: $4.Chat.create)
    ..aOM<$2.Peer>(2, _omitFieldNames ? '' : 'left', subBuilder: $2.Peer.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateLeftMember clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateLeftMember copyWith(void Function(UpdateLeftMember) updates) =>
      super.copyWith((message) => updates(message as UpdateLeftMember))
          as UpdateLeftMember;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateLeftMember create() => UpdateLeftMember._();
  @$core.override
  UpdateLeftMember createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static UpdateLeftMember getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateLeftMember>(create);
  static UpdateLeftMember? _defaultInstance;

  /// Chat [TO] Update.
  @$pb.TagNumber(1)
  $4.Chat get chat => $_getN(0);
  @$pb.TagNumber(1)
  set chat($4.Chat value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasChat() => $_has(0);
  @$pb.TagNumber(1)
  void clearChat() => $_clearField(1);
  @$pb.TagNumber(1)
  $4.Chat ensureChat() => $_ensure(0);

  /// The member who left the chat.
  @$pb.TagNumber(2)
  $2.Peer get left => $_getN(1);
  @$pb.TagNumber(2)
  set left($2.Peer value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasLeft() => $_has(1);
  @$pb.TagNumber(2)
  void clearLeft() => $_clearField(2);
  @$pb.TagNumber(2)
  $2.Peer ensureLeft() => $_ensure(1);
}

/// Update about that the chat dialog is complete.
/// NOTE: Next Messages.SendMessage call will open NEW dialog.chat
class UpdateChatComplete extends $pb.GeneratedMessage {
  factory UpdateChatComplete({
    $4.Chat? chat,
    $2.Peer? from,
  }) {
    final result = create();
    if (chat != null) result.chat = chat;
    if (from != null) result.from = from;
    return result;
  }

  UpdateChatComplete._();

  factory UpdateChatComplete.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateChatComplete.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateChatComplete',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'webitel.portal'),
      createEmptyInstance: create)
    ..aOM<$4.Chat>(1, _omitFieldNames ? '' : 'chat', subBuilder: $4.Chat.create)
    ..aOM<$2.Peer>(2, _omitFieldNames ? '' : 'from', subBuilder: $2.Peer.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateChatComplete clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateChatComplete copyWith(void Function(UpdateChatComplete) updates) =>
      super.copyWith((message) => updates(message as UpdateChatComplete))
          as UpdateChatComplete;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateChatComplete create() => UpdateChatComplete._();
  @$core.override
  UpdateChatComplete createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static UpdateChatComplete getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateChatComplete>(create);
  static UpdateChatComplete? _defaultInstance;

  /// Chat [TO] Update.
  @$pb.TagNumber(1)
  $4.Chat get chat => $_getN(0);
  @$pb.TagNumber(1)
  set chat($4.Chat value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasChat() => $_has(0);
  @$pb.TagNumber(1)
  void clearChat() => $_clearField(1);
  @$pb.TagNumber(1)
  $4.Chat ensureChat() => $_ensure(0);

  /// Side member who closed this chat dialog.
  @$pb.TagNumber(2)
  $2.Peer get from => $_getN(1);
  @$pb.TagNumber(2)
  set from($2.Peer value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasFrom() => $_has(1);
  @$pb.TagNumber(2)
  void clearFrom() => $_clearField(2);
  @$pb.TagNumber(2)
  $2.Peer ensureFrom() => $_ensure(1);
}

/// Incoming messages were read
class UpdateReadHistoryInbox extends $pb.GeneratedMessage {
  factory UpdateReadHistoryInbox({
    $2.Peer? peer,
    $fixnum.Int64? maxId,
    $core.int? inbox,
  }) {
    final result = create();
    if (peer != null) result.peer = peer;
    if (maxId != null) result.maxId = maxId;
    if (inbox != null) result.inbox = inbox;
    return result;
  }

  UpdateReadHistoryInbox._();

  factory UpdateReadHistoryInbox.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateReadHistoryInbox.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateReadHistoryInbox',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'webitel.portal'),
      createEmptyInstance: create)
    ..aOM<$2.Peer>(1, _omitFieldNames ? '' : 'peer', subBuilder: $2.Peer.create)
    ..aInt64(2, _omitFieldNames ? '' : 'maxId')
    ..aI(3, _omitFieldNames ? '' : 'inbox')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateReadHistoryInbox clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateReadHistoryInbox copyWith(
          void Function(UpdateReadHistoryInbox) updates) =>
      super.copyWith((message) => updates(message as UpdateReadHistoryInbox))
          as UpdateReadHistoryInbox;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateReadHistoryInbox create() => UpdateReadHistoryInbox._();
  @$core.override
  UpdateReadHistoryInbox createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static UpdateReadHistoryInbox getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateReadHistoryInbox>(create);
  static UpdateReadHistoryInbox? _defaultInstance;

  /// Peer chat dialog
  @$pb.TagNumber(1)
  $2.Peer get peer => $_getN(0);
  @$pb.TagNumber(1)
  set peer($2.Peer value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasPeer() => $_has(0);
  @$pb.TagNumber(1)
  void clearPeer() => $_clearField(1);
  @$pb.TagNumber(1)
  $2.Peer ensurePeer() => $_ensure(0);

  /// Maximum ID of messages read
  @$pb.TagNumber(2)
  $fixnum.Int64 get maxId => $_getI64(1);
  @$pb.TagNumber(2)
  set maxId($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMaxId() => $_has(1);
  @$pb.TagNumber(2)
  void clearMaxId() => $_clearField(2);

  /// Number of messages that are still unread
  @$pb.TagNumber(3)
  $core.int get inbox => $_getIZ(2);
  @$pb.TagNumber(3)
  set inbox($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasInbox() => $_has(2);
  @$pb.TagNumber(3)
  void clearInbox() => $_clearField(3);
}

/// Outgoing messages were read
/// Not Implemented yet !
class UpdateReadHistoryOutbox extends $pb.GeneratedMessage {
  factory UpdateReadHistoryOutbox({
    $2.Peer? peer,
    $fixnum.Int64? maxId,
  }) {
    final result = create();
    if (peer != null) result.peer = peer;
    if (maxId != null) result.maxId = maxId;
    return result;
  }

  UpdateReadHistoryOutbox._();

  factory UpdateReadHistoryOutbox.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateReadHistoryOutbox.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateReadHistoryOutbox',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'webitel.portal'),
      createEmptyInstance: create)
    ..aOM<$2.Peer>(1, _omitFieldNames ? '' : 'peer', subBuilder: $2.Peer.create)
    ..aInt64(2, _omitFieldNames ? '' : 'maxId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateReadHistoryOutbox clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateReadHistoryOutbox copyWith(
          void Function(UpdateReadHistoryOutbox) updates) =>
      super.copyWith((message) => updates(message as UpdateReadHistoryOutbox))
          as UpdateReadHistoryOutbox;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateReadHistoryOutbox create() => UpdateReadHistoryOutbox._();
  @$core.override
  UpdateReadHistoryOutbox createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static UpdateReadHistoryOutbox getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateReadHistoryOutbox>(create);
  static UpdateReadHistoryOutbox? _defaultInstance;

  /// Peer chat dialog
  @$pb.TagNumber(1)
  $2.Peer get peer => $_getN(0);
  @$pb.TagNumber(1)
  set peer($2.Peer value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasPeer() => $_has(0);
  @$pb.TagNumber(1)
  void clearPeer() => $_clearField(1);
  @$pb.TagNumber(1)
  $2.Peer ensurePeer() => $_ensure(0);

  /// Maximum ID of read outgoing messages
  @$pb.TagNumber(2)
  $fixnum.Int64 get maxId => $_getI64(1);
  @$pb.TagNumber(2)
  set maxId($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMaxId() => $_has(1);
  @$pb.TagNumber(2)
  void clearMaxId() => $_clearField(2);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
