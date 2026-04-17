// This is a generated file - do not edit.
//
// Generated from chat/messages/dialog.proto.

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
    as $3;

import 'chat.pb.dart' as $2;
import 'message.pb.dart' as $1;
import 'peer.pb.dart' as $0;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

/// Chat Dialog. Conversation info.
class Dialog extends $pb.GeneratedMessage {
  factory Dialog({
    $fixnum.Int64? dc,
    $core.String? id,
    $0.Peer? via,
    $0.Peer? from,
    $fixnum.Int64? date,
    $core.String? title,
    $fixnum.Int64? closed,
    $fixnum.Int64? started,
    $1.Message? message,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? context,
    $core.Iterable<$2.Chat>? members,
  }) {
    final result = create();
    if (dc != null) result.dc = dc;
    if (id != null) result.id = id;
    if (via != null) result.via = via;
    if (from != null) result.from = from;
    if (date != null) result.date = date;
    if (title != null) result.title = title;
    if (closed != null) result.closed = closed;
    if (started != null) result.started = started;
    if (message != null) result.message = message;
    if (context != null) result.context.addEntries(context);
    if (members != null) result.members.addAll(members);
    return result;
  }

  Dialog._();

  factory Dialog.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Dialog.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Dialog',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'webitel.chat'),
      createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'dc')
    ..aOS(2, _omitFieldNames ? '' : 'id')
    ..aOM<$0.Peer>(3, _omitFieldNames ? '' : 'via', subBuilder: $0.Peer.create)
    ..aOM<$0.Peer>(4, _omitFieldNames ? '' : 'from', subBuilder: $0.Peer.create)
    ..aInt64(6, _omitFieldNames ? '' : 'date')
    ..aOS(7, _omitFieldNames ? '' : 'title')
    ..aInt64(8, _omitFieldNames ? '' : 'closed')
    ..aInt64(9, _omitFieldNames ? '' : 'started')
    ..aOM<$1.Message>(10, _omitFieldNames ? '' : 'message',
        subBuilder: $1.Message.create)
    ..m<$core.String, $core.String>(11, _omitFieldNames ? '' : 'context',
        entryClassName: 'Dialog.ContextEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('webitel.chat'))
    ..pPM<$2.Chat>(12, _omitFieldNames ? '' : 'members',
        subBuilder: $2.Chat.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Dialog clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Dialog copyWith(void Function(Dialog) updates) =>
      super.copyWith((message) => updates(message as Dialog)) as Dialog;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Dialog create() => Dialog._();
  @$core.override
  Dialog createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Dialog getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Dialog>(create);
  static Dialog? _defaultInstance;

  /// [D]omain[C]omponent primary ID.
  @$pb.TagNumber(1)
  $fixnum.Int64 get dc => $_getI64(0);
  @$pb.TagNumber(1)
  set dc($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasDc() => $_has(0);
  @$pb.TagNumber(1)
  void clearDc() => $_clearField(1);

  /// The Conversation thread unique ID.
  @$pb.TagNumber(2)
  $core.String get id => $_getSZ(1);
  @$pb.TagNumber(2)
  set id($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasId() => $_has(1);
  @$pb.TagNumber(2)
  void clearId() => $_clearField(2);

  /// [VIA] Text gateway [FROM] originated thru ...
  @$pb.TagNumber(3)
  $0.Peer get via => $_getN(2);
  @$pb.TagNumber(3)
  set via($0.Peer value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasVia() => $_has(2);
  @$pb.TagNumber(3)
  void clearVia() => $_clearField(3);
  @$pb.TagNumber(3)
  $0.Peer ensureVia() => $_ensure(2);

  /// [FROM]: Originator.
  /// Leg[A]. Contact / User.
  @$pb.TagNumber(4)
  $0.Peer get from => $_getN(3);
  @$pb.TagNumber(4)
  set from($0.Peer value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasFrom() => $_has(3);
  @$pb.TagNumber(4)
  void clearFrom() => $_clearField(4);
  @$pb.TagNumber(4)
  $0.Peer ensureFrom() => $_ensure(3);

  /// Timestamp of the latest activity.
  @$pb.TagNumber(6)
  $fixnum.Int64 get date => $_getI64(4);
  @$pb.TagNumber(6)
  set date($fixnum.Int64 value) => $_setInt64(4, value);
  @$pb.TagNumber(6)
  $core.bool hasDate() => $_has(4);
  @$pb.TagNumber(6)
  void clearDate() => $_clearField(6);

  /// Title of the dialog.
  @$pb.TagNumber(7)
  $core.String get title => $_getSZ(5);
  @$pb.TagNumber(7)
  set title($core.String value) => $_setString(5, value);
  @$pb.TagNumber(7)
  $core.bool hasTitle() => $_has(5);
  @$pb.TagNumber(7)
  void clearTitle() => $_clearField(7);

  /// Timestamp when dialog was closed.
  /// Zero value means - connected (online)
  /// Otherwise - disconnected (offline)
  @$pb.TagNumber(8)
  $fixnum.Int64 get closed => $_getI64(6);
  @$pb.TagNumber(8)
  set closed($fixnum.Int64 value) => $_setInt64(6, value);
  @$pb.TagNumber(8)
  $core.bool hasClosed() => $_has(6);
  @$pb.TagNumber(8)
  void clearClosed() => $_clearField(8);

  /// Timestamp when dialog started.
  @$pb.TagNumber(9)
  $fixnum.Int64 get started => $_getI64(7);
  @$pb.TagNumber(9)
  set started($fixnum.Int64 value) => $_setInt64(7, value);
  @$pb.TagNumber(9)
  $core.bool hasStarted() => $_has(7);
  @$pb.TagNumber(9)
  void clearStarted() => $_clearField(9);

  /// The latest (top) message.
  @$pb.TagNumber(10)
  $1.Message get message => $_getN(8);
  @$pb.TagNumber(10)
  set message($1.Message value) => $_setField(10, value);
  @$pb.TagNumber(10)
  $core.bool hasMessage() => $_has(8);
  @$pb.TagNumber(10)
  void clearMessage() => $_clearField(10);
  @$pb.TagNumber(10)
  $1.Message ensureMessage() => $_ensure(8);

  /// Context. Variables. Environment.
  @$pb.TagNumber(11)
  $pb.PbMap<$core.String, $core.String> get context => $_getMap(9);

  /// [TO]: Participants.
  /// Leg[A+]. Schema / Agent.
  @$pb.TagNumber(12)
  $pb.PbList<$2.Chat> get members => $_getList(10);
}

/// ChatDialogs dataset
class ChatDialogs extends $pb.GeneratedMessage {
  factory ChatDialogs({
    $core.Iterable<Dialog>? data,
    $core.int? page,
    $core.bool? next,
  }) {
    final result = create();
    if (data != null) result.data.addAll(data);
    if (page != null) result.page = page;
    if (next != null) result.next = next;
    return result;
  }

  ChatDialogs._();

  factory ChatDialogs.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ChatDialogs.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ChatDialogs',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'webitel.chat'),
      createEmptyInstance: create)
    ..pPM<Dialog>(1, _omitFieldNames ? '' : 'data', subBuilder: Dialog.create)
    ..aI(2, _omitFieldNames ? '' : 'page')
    ..aOB(3, _omitFieldNames ? '' : 'next')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChatDialogs clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChatDialogs copyWith(void Function(ChatDialogs) updates) =>
      super.copyWith((message) => updates(message as ChatDialogs))
          as ChatDialogs;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ChatDialogs create() => ChatDialogs._();
  @$core.override
  ChatDialogs createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ChatDialogs getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ChatDialogs>(create);
  static ChatDialogs? _defaultInstance;

  /// Dataset page of Dialog(s).
  @$pb.TagNumber(1)
  $pb.PbList<Dialog> get data => $_getList(0);

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

class ChatDialogsRequest extends $pb.GeneratedMessage {
  factory ChatDialogsRequest({
    $core.int? page,
    $core.int? size,
    $core.Iterable<$core.String>? sort,
    $core.Iterable<$core.String>? fields,
    $core.String? q,
    $core.Iterable<$core.String>? id,
    $0.Peer? via,
    $0.Peer? peer,
    $2.Timerange? date,
    $3.BoolValue? online,
  }) {
    final result = create();
    if (page != null) result.page = page;
    if (size != null) result.size = size;
    if (sort != null) result.sort.addAll(sort);
    if (fields != null) result.fields.addAll(fields);
    if (q != null) result.q = q;
    if (id != null) result.id.addAll(id);
    if (via != null) result.via = via;
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
      package: const $pb.PackageName(_omitMessageNames ? '' : 'webitel.chat'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'page')
    ..aI(2, _omitFieldNames ? '' : 'size')
    ..pPS(3, _omitFieldNames ? '' : 'sort')
    ..pPS(4, _omitFieldNames ? '' : 'fields')
    ..aOS(5, _omitFieldNames ? '' : 'q')
    ..pPS(6, _omitFieldNames ? '' : 'id')
    ..aOM<$0.Peer>(7, _omitFieldNames ? '' : 'via', subBuilder: $0.Peer.create)
    ..aOM<$0.Peer>(8, _omitFieldNames ? '' : 'peer', subBuilder: $0.Peer.create)
    ..aOM<$2.Timerange>(9, _omitFieldNames ? '' : 'date',
        subBuilder: $2.Timerange.create)
    ..aOM<$3.BoolValue>(10, _omitFieldNames ? '' : 'online',
        subBuilder: $3.BoolValue.create)
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

  /// [VIA] Text gateway.
  @$pb.TagNumber(7)
  $0.Peer get via => $_getN(6);
  @$pb.TagNumber(7)
  set via($0.Peer value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasVia() => $_has(6);
  @$pb.TagNumber(7)
  void clearVia() => $_clearField(7);
  @$pb.TagNumber(7)
  $0.Peer ensureVia() => $_ensure(6);

  /// [PEER] Member of ...
  @$pb.TagNumber(8)
  $0.Peer get peer => $_getN(7);
  @$pb.TagNumber(8)
  set peer($0.Peer value) => $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasPeer() => $_has(7);
  @$pb.TagNumber(8)
  void clearPeer() => $_clearField(8);
  @$pb.TagNumber(8)
  $0.Peer ensurePeer() => $_ensure(7);

  /// Date within timerange.
  @$pb.TagNumber(9)
  $2.Timerange get date => $_getN(8);
  @$pb.TagNumber(9)
  set date($2.Timerange value) => $_setField(9, value);
  @$pb.TagNumber(9)
  $core.bool hasDate() => $_has(8);
  @$pb.TagNumber(9)
  void clearDate() => $_clearField(9);
  @$pb.TagNumber(9)
  $2.Timerange ensureDate() => $_ensure(8);

  /// Dialogs ONLY that are currently [not] active( closed: ? ).
  @$pb.TagNumber(10)
  $3.BoolValue get online => $_getN(9);
  @$pb.TagNumber(10)
  set online($3.BoolValue value) => $_setField(10, value);
  @$pb.TagNumber(10)
  $core.bool hasOnline() => $_has(9);
  @$pb.TagNumber(10)
  void clearOnline() => $_clearField(10);
  @$pb.TagNumber(10)
  $3.BoolValue ensureOnline() => $_ensure(9);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
