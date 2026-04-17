// This is a generated file - do not edit.
//
// Generated from chat/messages/chat.proto.

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
    as $1;

import 'peer.pb.dart' as $0;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class Chat_Invite extends $pb.GeneratedMessage {
  factory Chat_Invite({
    $fixnum.Int64? date,
    $core.String? from,
  }) {
    final result = create();
    if (date != null) result.date = date;
    if (from != null) result.from = from;
    return result;
  }

  Chat_Invite._();

  factory Chat_Invite.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Chat_Invite.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Chat.Invite',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'webitel.chat'),
      createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'date')
    ..aOS(2, _omitFieldNames ? '' : 'from')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Chat_Invite clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Chat_Invite copyWith(void Function(Chat_Invite) updates) =>
      super.copyWith((message) => updates(message as Chat_Invite))
          as Chat_Invite;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Chat_Invite create() => Chat_Invite._();
  @$core.override
  Chat_Invite createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Chat_Invite getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Chat_Invite>(create);
  static Chat_Invite? _defaultInstance;

  /// Timestamp when the invitation to join the chat was sent
  @$pb.TagNumber(1)
  $fixnum.Int64 get date => $_getI64(0);
  @$pb.TagNumber(1)
  set date($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasDate() => $_has(0);
  @$pb.TagNumber(1)
  void clearDate() => $_clearField(1);

  /// Chat member ID who invited to join the chat
  @$pb.TagNumber(2)
  $core.String get from => $_getSZ(1);
  @$pb.TagNumber(2)
  set from($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasFrom() => $_has(1);
  @$pb.TagNumber(2)
  void clearFrom() => $_clearField(2);
}

/// The Chat info.
/// Alias: participant, subscriber, member, peer, leg.
class Chat extends $pb.GeneratedMessage {
  factory Chat({
    $fixnum.Int64? dc,
    $core.String? id,
    $0.Peer? via,
    $0.Peer? peer,
    $core.String? title,
    $fixnum.Int64? left,
    $fixnum.Int64? join,
    Chat_Invite? invite,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? context,
  }) {
    final result = create();
    if (dc != null) result.dc = dc;
    if (id != null) result.id = id;
    if (via != null) result.via = via;
    if (peer != null) result.peer = peer;
    if (title != null) result.title = title;
    if (left != null) result.left = left;
    if (join != null) result.join = join;
    if (invite != null) result.invite = invite;
    if (context != null) result.context.addEntries(context);
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
      package: const $pb.PackageName(_omitMessageNames ? '' : 'webitel.chat'),
      createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'dc')
    ..aOS(2, _omitFieldNames ? '' : 'id')
    ..aOM<$0.Peer>(5, _omitFieldNames ? '' : 'via', subBuilder: $0.Peer.create)
    ..aOM<$0.Peer>(6, _omitFieldNames ? '' : 'peer', subBuilder: $0.Peer.create)
    ..aOS(8, _omitFieldNames ? '' : 'title')
    ..aInt64(10, _omitFieldNames ? '' : 'left')
    ..aInt64(11, _omitFieldNames ? '' : 'join')
    ..aOM<Chat_Invite>(13, _omitFieldNames ? '' : 'invite',
        subBuilder: Chat_Invite.create)
    ..m<$core.String, $core.String>(15, _omitFieldNames ? '' : 'context',
        entryClassName: 'Chat.ContextEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('webitel.chat'))
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

  /// [D]omain[C]omponent primary ID.
  @$pb.TagNumber(1)
  $fixnum.Int64 get dc => $_getI64(0);
  @$pb.TagNumber(1)
  set dc($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasDc() => $_has(0);
  @$pb.TagNumber(1)
  void clearDc() => $_clearField(1);

  /// Unique identifier for this chat.
  /// [FROM] Member / Channel ID.
  @$pb.TagNumber(2)
  $core.String get id => $_getSZ(1);
  @$pb.TagNumber(2)
  set id($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasId() => $_has(1);
  @$pb.TagNumber(2)
  void clearId() => $_clearField(2);

  /// [FROM] VIA text gateway profile.
  @$pb.TagNumber(5)
  $0.Peer get via => $_getN(2);
  @$pb.TagNumber(5)
  set via($0.Peer value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasVia() => $_has(2);
  @$pb.TagNumber(5)
  void clearVia() => $_clearField(5);
  @$pb.TagNumber(5)
  $0.Peer ensureVia() => $_ensure(2);

  /// [FROM]: User identity. Seed.
  @$pb.TagNumber(6)
  $0.Peer get peer => $_getN(3);
  @$pb.TagNumber(6)
  set peer($0.Peer value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasPeer() => $_has(3);
  @$pb.TagNumber(6)
  void clearPeer() => $_clearField(6);
  @$pb.TagNumber(6)
  $0.Peer ensurePeer() => $_ensure(3);

  /// [TO]: Chat title.
  @$pb.TagNumber(8)
  $core.String get title => $_getSZ(4);
  @$pb.TagNumber(8)
  set title($core.String value) => $_setString(4, value);
  @$pb.TagNumber(8)
  $core.bool hasTitle() => $_has(4);
  @$pb.TagNumber(8)
  void clearTitle() => $_clearField(8);

  /// OPTIONAL. A non-zero value indicates that
  /// the participant has left the chat. OFFLINE(!)
  @$pb.TagNumber(10)
  $fixnum.Int64 get left => $_getI64(5);
  @$pb.TagNumber(10)
  set left($fixnum.Int64 value) => $_setInt64(5, value);
  @$pb.TagNumber(10)
  $core.bool hasLeft() => $_has(5);
  @$pb.TagNumber(10)
  void clearLeft() => $_clearField(10);

  /// OPTIONAL. A non-zero value indicates that
  /// the participant has joined the chat.
  @$pb.TagNumber(11)
  $fixnum.Int64 get join => $_getI64(6);
  @$pb.TagNumber(11)
  set join($fixnum.Int64 value) => $_setInt64(6, value);
  @$pb.TagNumber(11)
  $core.bool hasJoin() => $_has(6);
  @$pb.TagNumber(11)
  void clearJoin() => $_clearField(11);

  /// OPTIONAL. Invite[d] BY member info.
  @$pb.TagNumber(13)
  Chat_Invite get invite => $_getN(7);
  @$pb.TagNumber(13)
  set invite(Chat_Invite value) => $_setField(13, value);
  @$pb.TagNumber(13)
  $core.bool hasInvite() => $_has(7);
  @$pb.TagNumber(13)
  void clearInvite() => $_clearField(13);
  @$pb.TagNumber(13)
  Chat_Invite ensureInvite() => $_ensure(7);

  /// Context. Variables.
  @$pb.TagNumber(15)
  $pb.PbMap<$core.String, $core.String> get context => $_getMap(8);
}

/// Timerange filter value.
class Timerange extends $pb.GeneratedMessage {
  factory Timerange({
    $fixnum.Int64? since,
    $fixnum.Int64? until,
  }) {
    final result = create();
    if (since != null) result.since = since;
    if (until != null) result.until = until;
    return result;
  }

  Timerange._();

  factory Timerange.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Timerange.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Timerange',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'webitel.chat'),
      createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'since')
    ..aInt64(2, _omitFieldNames ? '' : 'until')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Timerange clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Timerange copyWith(void Function(Timerange) updates) =>
      super.copyWith((message) => updates(message as Timerange)) as Timerange;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Timerange create() => Timerange._();
  @$core.override
  Timerange createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Timerange getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Timerange>(create);
  static Timerange? _defaultInstance;

  /// Since epochtime (milli).
  /// **Match**: greater than ..
  @$pb.TagNumber(1)
  $fixnum.Int64 get since => $_getI64(0);
  @$pb.TagNumber(1)
  set since($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSince() => $_has(0);
  @$pb.TagNumber(1)
  void clearSince() => $_clearField(1);

  /// Until epochtime (milli).
  /// **Match**: less or equal ..
  @$pb.TagNumber(2)
  $fixnum.Int64 get until => $_getI64(1);
  @$pb.TagNumber(2)
  set until($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasUntil() => $_has(1);
  @$pb.TagNumber(2)
  void clearUntil() => $_clearField(2);
}

class ChatMembersRequest extends $pb.GeneratedMessage {
  factory ChatMembersRequest({
    $core.int? page,
    $core.int? size,
    $core.Iterable<$core.String>? sort,
    $core.Iterable<$core.String>? fields,
    $core.String? chatId,
    $core.String? q,
    $core.Iterable<$core.String>? id,
    $0.Peer? via,
    $0.Peer? peer,
    Timerange? date,
    $1.BoolValue? online,
    $1.BoolValue? joined,
  }) {
    final result = create();
    if (page != null) result.page = page;
    if (size != null) result.size = size;
    if (sort != null) result.sort.addAll(sort);
    if (fields != null) result.fields.addAll(fields);
    if (chatId != null) result.chatId = chatId;
    if (q != null) result.q = q;
    if (id != null) result.id.addAll(id);
    if (via != null) result.via = via;
    if (peer != null) result.peer = peer;
    if (date != null) result.date = date;
    if (online != null) result.online = online;
    if (joined != null) result.joined = joined;
    return result;
  }

  ChatMembersRequest._();

  factory ChatMembersRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ChatMembersRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ChatMembersRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'webitel.chat'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'page')
    ..aI(2, _omitFieldNames ? '' : 'size')
    ..pPS(3, _omitFieldNames ? '' : 'sort')
    ..pPS(4, _omitFieldNames ? '' : 'fields')
    ..aOS(5, _omitFieldNames ? '' : 'chatId')
    ..aOS(6, _omitFieldNames ? '' : 'q')
    ..pPS(7, _omitFieldNames ? '' : 'id')
    ..aOM<$0.Peer>(8, _omitFieldNames ? '' : 'via', subBuilder: $0.Peer.create)
    ..aOM<$0.Peer>(9, _omitFieldNames ? '' : 'peer', subBuilder: $0.Peer.create)
    ..aOM<Timerange>(10, _omitFieldNames ? '' : 'date',
        subBuilder: Timerange.create)
    ..aOM<$1.BoolValue>(11, _omitFieldNames ? '' : 'online',
        subBuilder: $1.BoolValue.create)
    ..aOM<$1.BoolValue>(12, _omitFieldNames ? '' : 'joined',
        subBuilder: $1.BoolValue.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChatMembersRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChatMembersRequest copyWith(void Function(ChatMembersRequest) updates) =>
      super.copyWith((message) => updates(message as ChatMembersRequest))
          as ChatMembersRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ChatMembersRequest create() => ChatMembersRequest._();
  @$core.override
  ChatMembersRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ChatMembersRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ChatMembersRequest>(create);
  static ChatMembersRequest? _defaultInstance;

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

  /// ID of the chat dialog.
  @$pb.TagNumber(5)
  $core.String get chatId => $_getSZ(4);
  @$pb.TagNumber(5)
  set chatId($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasChatId() => $_has(4);
  @$pb.TagNumber(5)
  void clearChatId() => $_clearField(5);

  /// Search term: peer(type;name)
  @$pb.TagNumber(6)
  $core.String get q => $_getSZ(5);
  @$pb.TagNumber(6)
  set q($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasQ() => $_has(5);
  @$pb.TagNumber(6)
  void clearQ() => $_clearField(6);

  /// Set of unique chat member ID.
  @$pb.TagNumber(7)
  $pb.PbList<$core.String> get id => $_getList(6);

  /// [VIA] Text gateway.
  @$pb.TagNumber(8)
  $0.Peer get via => $_getN(7);
  @$pb.TagNumber(8)
  set via($0.Peer value) => $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasVia() => $_has(7);
  @$pb.TagNumber(8)
  void clearVia() => $_clearField(8);
  @$pb.TagNumber(8)
  $0.Peer ensureVia() => $_ensure(7);

  /// [PEER] Member of ...
  @$pb.TagNumber(9)
  $0.Peer get peer => $_getN(8);
  @$pb.TagNumber(9)
  set peer($0.Peer value) => $_setField(9, value);
  @$pb.TagNumber(9)
  $core.bool hasPeer() => $_has(8);
  @$pb.TagNumber(9)
  void clearPeer() => $_clearField(9);
  @$pb.TagNumber(9)
  $0.Peer ensurePeer() => $_ensure(8);

  /// Date within timerange.
  @$pb.TagNumber(10)
  Timerange get date => $_getN(9);
  @$pb.TagNumber(10)
  set date(Timerange value) => $_setField(10, value);
  @$pb.TagNumber(10)
  $core.bool hasDate() => $_has(9);
  @$pb.TagNumber(10)
  void clearDate() => $_clearField(10);
  @$pb.TagNumber(10)
  Timerange ensureDate() => $_ensure(9);

  /// Participants ONLY who are currently [not] connected to the chat.
  /// ( left: ( 0 ? online : offline ) )
  @$pb.TagNumber(11)
  $1.BoolValue get online => $_getN(10);
  @$pb.TagNumber(11)
  set online($1.BoolValue value) => $_setField(11, value);
  @$pb.TagNumber(11)
  $core.bool hasOnline() => $_has(10);
  @$pb.TagNumber(11)
  void clearOnline() => $_clearField(11);
  @$pb.TagNumber(11)
  $1.BoolValue ensureOnline() => $_ensure(10);

  /// Participants ONLY who have [not] been connected to the chat.
  /// ( join: ( 0 ? [request|abandoned] : connected ) )
  @$pb.TagNumber(12)
  $1.BoolValue get joined => $_getN(11);
  @$pb.TagNumber(12)
  set joined($1.BoolValue value) => $_setField(12, value);
  @$pb.TagNumber(12)
  $core.bool hasJoined() => $_has(11);
  @$pb.TagNumber(12)
  void clearJoined() => $_clearField(12);
  @$pb.TagNumber(12)
  $1.BoolValue ensureJoined() => $_ensure(11);
}

/// ChatMembers dataset
class ChatMembers extends $pb.GeneratedMessage {
  factory ChatMembers({
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

  ChatMembers._();

  factory ChatMembers.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ChatMembers.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ChatMembers',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'webitel.chat'),
      createEmptyInstance: create)
    ..pPM<Chat>(1, _omitFieldNames ? '' : 'data', subBuilder: Chat.create)
    ..aI(5, _omitFieldNames ? '' : 'page')
    ..aOB(6, _omitFieldNames ? '' : 'next')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChatMembers clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChatMembers copyWith(void Function(ChatMembers) updates) =>
      super.copyWith((message) => updates(message as ChatMembers))
          as ChatMembers;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ChatMembers create() => ChatMembers._();
  @$core.override
  ChatMembers createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ChatMembers getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ChatMembers>(create);
  static ChatMembers? _defaultInstance;

  /// Page of the chat participants.
  @$pb.TagNumber(1)
  $pb.PbList<Chat> get data => $_getList(0);

  /// Page number of results.
  @$pb.TagNumber(5)
  $core.int get page => $_getIZ(1);
  @$pb.TagNumber(5)
  set page($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(5)
  $core.bool hasPage() => $_has(1);
  @$pb.TagNumber(5)
  void clearPage() => $_clearField(5);

  /// Next page available ?
  @$pb.TagNumber(6)
  $core.bool get next => $_getBF(2);
  @$pb.TagNumber(6)
  set next($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(6)
  $core.bool hasNext() => $_has(2);
  @$pb.TagNumber(6)
  void clearNext() => $_clearField(6);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
