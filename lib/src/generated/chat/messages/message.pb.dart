// This is a generated file - do not edit.
//
// Generated from chat/messages/message.proto.

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
import 'message.pbenum.dart';
import 'peer.pb.dart' as $0;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'message.pbenum.dart';

/// Chat Message.
class Message extends $pb.GeneratedMessage {
  factory Message({
    $fixnum.Int64? id,
    $fixnum.Int64? date,
    $0.Peer? from,
    $1.Chat? chat,
    $1.Chat? sender,
    $fixnum.Int64? edit,
    $core.String? text,
    File? file,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? context,
    ReplyMarkup? keyboard,
    Postback? postback,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (date != null) result.date = date;
    if (from != null) result.from = from;
    if (chat != null) result.chat = chat;
    if (sender != null) result.sender = sender;
    if (edit != null) result.edit = edit;
    if (text != null) result.text = text;
    if (file != null) result.file = file;
    if (context != null) result.context.addEntries(context);
    if (keyboard != null) result.keyboard = keyboard;
    if (postback != null) result.postback = postback;
    return result;
  }

  Message._();

  factory Message.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Message.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Message',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'webitel.chat'),
      createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'id')
    ..aInt64(2, _omitFieldNames ? '' : 'date')
    ..aOM<$0.Peer>(3, _omitFieldNames ? '' : 'from', subBuilder: $0.Peer.create)
    ..aOM<$1.Chat>(4, _omitFieldNames ? '' : 'chat', subBuilder: $1.Chat.create)
    ..aOM<$1.Chat>(5, _omitFieldNames ? '' : 'sender',
        subBuilder: $1.Chat.create)
    ..aInt64(6, _omitFieldNames ? '' : 'edit')
    ..aOS(7, _omitFieldNames ? '' : 'text')
    ..aOM<File>(8, _omitFieldNames ? '' : 'file', subBuilder: File.create)
    ..m<$core.String, $core.String>(9, _omitFieldNames ? '' : 'context',
        entryClassName: 'Message.ContextEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('webitel.chat'))
    ..aOM<ReplyMarkup>(10, _omitFieldNames ? '' : 'keyboard',
        subBuilder: ReplyMarkup.create)
    ..aOM<Postback>(11, _omitFieldNames ? '' : 'postback',
        subBuilder: Postback.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Message clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Message copyWith(void Function(Message) updates) =>
      super.copyWith((message) => updates(message as Message)) as Message;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Message create() => Message._();
  @$core.override
  Message createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Message getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Message>(create);
  static Message? _defaultInstance;

  /// Unique message identifier inside this chat.
  @$pb.TagNumber(1)
  $fixnum.Int64 get id => $_getI64(0);
  @$pb.TagNumber(1)
  set id($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  /// Timestamp when this message was sent (published).
  @$pb.TagNumber(2)
  $fixnum.Int64 get date => $_getI64(1);
  @$pb.TagNumber(2)
  set date($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasDate() => $_has(1);
  @$pb.TagNumber(2)
  void clearDate() => $_clearField(2);

  /// Sender of the message.
  @$pb.TagNumber(3)
  $0.Peer get from => $_getN(2);
  @$pb.TagNumber(3)
  set from($0.Peer value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasFrom() => $_has(2);
  @$pb.TagNumber(3)
  void clearFrom() => $_clearField(3);
  @$pb.TagNumber(3)
  $0.Peer ensureFrom() => $_ensure(2);

  /// Conversation the message belongs to ..
  @$pb.TagNumber(4)
  $1.Chat get chat => $_getN(3);
  @$pb.TagNumber(4)
  set chat($1.Chat value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasChat() => $_has(3);
  @$pb.TagNumber(4)
  void clearChat() => $_clearField(4);
  @$pb.TagNumber(4)
  $1.Chat ensureChat() => $_ensure(3);

  /// Chat Sender of the message, sent on behalf of a chat (member).
  @$pb.TagNumber(5)
  $1.Chat get sender => $_getN(4);
  @$pb.TagNumber(5)
  set sender($1.Chat value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasSender() => $_has(4);
  @$pb.TagNumber(5)
  void clearSender() => $_clearField(5);
  @$pb.TagNumber(5)
  $1.Chat ensureSender() => $_ensure(4);

  /// Timestamp when this message was last edited.
  @$pb.TagNumber(6)
  $fixnum.Int64 get edit => $_getI64(5);
  @$pb.TagNumber(6)
  set edit($fixnum.Int64 value) => $_setInt64(5, value);
  @$pb.TagNumber(6)
  $core.bool hasEdit() => $_has(5);
  @$pb.TagNumber(6)
  void clearEdit() => $_clearField(6);

  /// Message Text.
  @$pb.TagNumber(7)
  $core.String get text => $_getSZ(6);
  @$pb.TagNumber(7)
  set text($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasText() => $_has(6);
  @$pb.TagNumber(7)
  void clearText() => $_clearField(7);

  /// Message Media. Attachment.
  @$pb.TagNumber(8)
  File get file => $_getN(7);
  @$pb.TagNumber(8)
  set file(File value) => $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasFile() => $_has(7);
  @$pb.TagNumber(8)
  void clearFile() => $_clearField(8);
  @$pb.TagNumber(8)
  File ensureFile() => $_ensure(7);

  /// Context. Variables. Environment.
  @$pb.TagNumber(9)
  $pb.PbMap<$core.String, $core.String> get context => $_getMap(8);

  /// Keyboard. Buttons. Quick Replies.
  @$pb.TagNumber(10)
  ReplyMarkup get keyboard => $_getN(9);
  @$pb.TagNumber(10)
  set keyboard(ReplyMarkup value) => $_setField(10, value);
  @$pb.TagNumber(10)
  $core.bool hasKeyboard() => $_has(9);
  @$pb.TagNumber(10)
  void clearKeyboard() => $_clearField(10);
  @$pb.TagNumber(10)
  ReplyMarkup ensureKeyboard() => $_ensure(9);

  /// Postback. Reply Button Click[ed].
  @$pb.TagNumber(11)
  Postback get postback => $_getN(10);
  @$pb.TagNumber(11)
  set postback(Postback value) => $_setField(11, value);
  @$pb.TagNumber(11)
  $core.bool hasPostback() => $_has(10);
  @$pb.TagNumber(11)
  void clearPostback() => $_clearField(11);
  @$pb.TagNumber(11)
  Postback ensurePostback() => $_ensure(10);
}

/// Media File.
class File extends $pb.GeneratedMessage {
  factory File({
    $core.String? id,
    $fixnum.Int64? size,
    $core.String? type,
    $core.String? name,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (size != null) result.size = size;
    if (type != null) result.type = type;
    if (name != null) result.name = name;
    return result;
  }

  File._();

  factory File.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory File.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'File',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'webitel.chat'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aInt64(3, _omitFieldNames ? '' : 'size')
    ..aOS(4, _omitFieldNames ? '' : 'type')
    ..aOS(5, _omitFieldNames ? '' : 'name')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  File clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  File copyWith(void Function(File) updates) =>
      super.copyWith((message) => updates(message as File)) as File;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static File create() => File._();
  @$core.override
  File createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static File getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<File>(create);
  static File? _defaultInstance;

  /// File location
  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  /// Size in bytes
  @$pb.TagNumber(3)
  $fixnum.Int64 get size => $_getI64(1);
  @$pb.TagNumber(3)
  set size($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(3)
  $core.bool hasSize() => $_has(1);
  @$pb.TagNumber(3)
  void clearSize() => $_clearField(3);

  /// MIME media type
  @$pb.TagNumber(4)
  $core.String get type => $_getSZ(2);
  @$pb.TagNumber(4)
  set type($core.String value) => $_setString(2, value);
  @$pb.TagNumber(4)
  $core.bool hasType() => $_has(2);
  @$pb.TagNumber(4)
  void clearType() => $_clearField(4);

  /// Filename
  @$pb.TagNumber(5)
  $core.String get name => $_getSZ(3);
  @$pb.TagNumber(5)
  set name($core.String value) => $_setString(3, value);
  @$pb.TagNumber(5)
  $core.bool hasName() => $_has(3);
  @$pb.TagNumber(5)
  void clearName() => $_clearField(5);
}

class ReplyMarkup extends $pb.GeneratedMessage {
  factory ReplyMarkup({
    $core.Iterable<ButtonRow>? buttons,
    $core.bool? noInput,
  }) {
    final result = create();
    if (buttons != null) result.buttons.addAll(buttons);
    if (noInput != null) result.noInput = noInput;
    return result;
  }

  ReplyMarkup._();

  factory ReplyMarkup.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ReplyMarkup.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ReplyMarkup',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'webitel.chat'),
      createEmptyInstance: create)
    ..pPM<ButtonRow>(1, _omitFieldNames ? '' : 'buttons',
        subBuilder: ButtonRow.create)
    ..aOB(2, _omitFieldNames ? '' : 'noInput')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReplyMarkup clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReplyMarkup copyWith(void Function(ReplyMarkup) updates) =>
      super.copyWith((message) => updates(message as ReplyMarkup))
          as ReplyMarkup;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ReplyMarkup create() => ReplyMarkup._();
  @$core.override
  ReplyMarkup createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ReplyMarkup getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ReplyMarkup>(create);
  static ReplyMarkup? _defaultInstance;

  /// Markup of button(s)
  @$pb.TagNumber(1)
  $pb.PbList<ButtonRow> get buttons => $_getList(0);

  /// An option used to block input to force
  /// the user to respond with one of the buttons.
  @$pb.TagNumber(2)
  $core.bool get noInput => $_getBF(1);
  @$pb.TagNumber(2)
  set noInput($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasNoInput() => $_has(1);
  @$pb.TagNumber(2)
  void clearNoInput() => $_clearField(2);
}

class ButtonRow extends $pb.GeneratedMessage {
  factory ButtonRow({
    $core.Iterable<Button>? row,
  }) {
    final result = create();
    if (row != null) result.row.addAll(row);
    return result;
  }

  ButtonRow._();

  factory ButtonRow.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ButtonRow.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ButtonRow',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'webitel.chat'),
      createEmptyInstance: create)
    ..pPM<Button>(1, _omitFieldNames ? '' : 'row', subBuilder: Button.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ButtonRow clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ButtonRow copyWith(void Function(ButtonRow) updates) =>
      super.copyWith((message) => updates(message as ButtonRow)) as ButtonRow;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ButtonRow create() => ButtonRow._();
  @$core.override
  ButtonRow createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ButtonRow getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ButtonRow>(create);
  static ButtonRow? _defaultInstance;

  /// Button(s) in a row
  @$pb.TagNumber(1)
  $pb.PbList<Button> get row => $_getList(0);
}

enum Button_Type { url, code, share, notSet }

class Button extends $pb.GeneratedMessage {
  factory Button({
    $core.String? text,
    $core.String? url,
    $core.String? code,
    Button_Request? share,
  }) {
    final result = create();
    if (text != null) result.text = text;
    if (url != null) result.url = url;
    if (code != null) result.code = code;
    if (share != null) result.share = share;
    return result;
  }

  Button._();

  factory Button.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Button.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static const $core.Map<$core.int, Button_Type> _Button_TypeByTag = {
    2: Button_Type.url,
    3: Button_Type.code,
    4: Button_Type.share,
    0: Button_Type.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Button',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'webitel.chat'),
      createEmptyInstance: create)
    ..oo(0, [2, 3, 4])
    ..aOS(1, _omitFieldNames ? '' : 'text')
    ..aOS(2, _omitFieldNames ? '' : 'url')
    ..aOS(3, _omitFieldNames ? '' : 'code')
    ..aE<Button_Request>(4, _omitFieldNames ? '' : 'share',
        enumValues: Button_Request.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Button clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Button copyWith(void Function(Button) updates) =>
      super.copyWith((message) => updates(message as Button)) as Button;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Button create() => Button._();
  @$core.override
  Button createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Button getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Button>(create);
  static Button? _defaultInstance;

  @$pb.TagNumber(2)
  @$pb.TagNumber(3)
  @$pb.TagNumber(4)
  Button_Type whichType() => _Button_TypeByTag[$_whichOneof(0)]!;
  @$pb.TagNumber(2)
  @$pb.TagNumber(3)
  @$pb.TagNumber(4)
  void clearType() => $_clearField($_whichOneof(0));

  /// Caption to display.
  @$pb.TagNumber(1)
  $core.String get text => $_getSZ(0);
  @$pb.TagNumber(1)
  set text($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasText() => $_has(0);
  @$pb.TagNumber(1)
  void clearText() => $_clearField(1);

  /// URL to navigate to ..
  @$pb.TagNumber(2)
  $core.String get url => $_getSZ(1);
  @$pb.TagNumber(2)
  set url($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasUrl() => $_has(1);
  @$pb.TagNumber(2)
  void clearUrl() => $_clearField(2);

  /// Postback/Callback data.
  @$pb.TagNumber(3)
  $core.String get code => $_getSZ(2);
  @$pb.TagNumber(3)
  set code($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCode() => $_has(2);
  @$pb.TagNumber(3)
  void clearCode() => $_clearField(3);

  /// Request to share contact info.
  @$pb.TagNumber(4)
  Button_Request get share => $_getN(3);
  @$pb.TagNumber(4)
  set share(Button_Request value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasShare() => $_has(3);
  @$pb.TagNumber(4)
  void clearShare() => $_clearField(4);
}

/// Postback. Reply Button Click[ed].
class Postback extends $pb.GeneratedMessage {
  factory Postback({
    $fixnum.Int64? mid,
    $core.String? code,
    $core.String? text,
  }) {
    final result = create();
    if (mid != null) result.mid = mid;
    if (code != null) result.code = code;
    if (text != null) result.text = text;
    return result;
  }

  Postback._();

  factory Postback.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Postback.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Postback',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'webitel.chat'),
      createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'mid')
    ..aOS(2, _omitFieldNames ? '' : 'code')
    ..aOS(3, _omitFieldNames ? '' : 'text')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Postback clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Postback copyWith(void Function(Postback) updates) =>
      super.copyWith((message) => updates(message as Postback)) as Postback;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Postback create() => Postback._();
  @$core.override
  Postback createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Postback getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Postback>(create);
  static Postback? _defaultInstance;

  /// Message ID of the button.
  @$pb.TagNumber(1)
  $fixnum.Int64 get mid => $_getI64(0);
  @$pb.TagNumber(1)
  set mid($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasMid() => $_has(0);
  @$pb.TagNumber(1)
  void clearMid() => $_clearField(1);

  /// Data associated with the Button.
  @$pb.TagNumber(2)
  $core.String get code => $_getSZ(1);
  @$pb.TagNumber(2)
  set code($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearCode() => $_clearField(2);

  /// Button's display caption.
  @$pb.TagNumber(3)
  $core.String get text => $_getSZ(2);
  @$pb.TagNumber(3)
  set text($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasText() => $_has(2);
  @$pb.TagNumber(3)
  void clearText() => $_clearField(3);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
