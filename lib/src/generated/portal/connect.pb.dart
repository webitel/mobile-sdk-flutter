// This is a generated file - do not edit.
//
// Generated from portal/connect.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;
import 'package:protobuf/well_known_types/google/protobuf/any.pb.dart' as $0;

import '../google/rpc/status.pb.dart' as $1;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

/// Update notification message.
/// MAY be `Response` to the `Request`
/// -OR- well-known Update *like message
class Update extends $pb.GeneratedMessage {
  factory Update({
    $fixnum.Int64? date,
    $0.Any? data,
  }) {
    final result = create();
    if (date != null) result.date = date;
    if (data != null) result.data = data;
    return result;
  }

  Update._();

  factory Update.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Update.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Update',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'webitel.portal'),
      createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'date')
    ..aOM<$0.Any>(3, _omitFieldNames ? '' : 'data', subBuilder: $0.Any.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Update clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Update copyWith(void Function(Update) updates) =>
      super.copyWith((message) => updates(message as Update)) as Update;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Update create() => Update._();
  @$core.override
  Update createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Update getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Update>(create);
  static Update? _defaultInstance;

  /// Date when this update was sent.
  @$pb.TagNumber(1)
  $fixnum.Int64 get date => $_getI64(0);
  @$pb.TagNumber(1)
  set date($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasDate() => $_has(0);
  @$pb.TagNumber(1)
  void clearDate() => $_clearField(1);

  /// Update notification message data
  @$pb.TagNumber(3)
  $0.Any get data => $_getN(1);
  @$pb.TagNumber(3)
  set data($0.Any value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasData() => $_has(1);
  @$pb.TagNumber(3)
  void clearData() => $_clearField(3);
  @$pb.TagNumber(3)
  $0.Any ensureData() => $_ensure(1);
}

/// RPC Request envelope
class Request extends $pb.GeneratedMessage {
  factory Request({
    $core.String? id,
    $core.String? path,
    $0.Any? data,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? meta,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (path != null) result.path = path;
    if (data != null) result.data = data;
    if (meta != null) result.meta.addEntries(meta);
    return result;
  }

  Request._();

  factory Request.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Request.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Request',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'webitel.portal'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'path')
    ..aOM<$0.Any>(3, _omitFieldNames ? '' : 'data', subBuilder: $0.Any.create)
    ..m<$core.String, $core.String>(4, _omitFieldNames ? '' : 'meta',
        entryClassName: 'Request.MetaEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('webitel.portal'))
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Request clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Request copyWith(void Function(Request) updates) =>
      super.copyWith((message) => updates(message as Request)) as Request;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Request create() => Request._();
  @$core.override
  Request createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Request getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Request>(create);
  static Request? _defaultInstance;

  /// Client generated request id ; mostly: integer sequence
  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  /// /path/to/pkg/Service.Method
  @$pb.TagNumber(2)
  $core.String get path => $_getSZ(1);
  @$pb.TagNumber(2)
  set path($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPath() => $_has(1);
  @$pb.TagNumber(2)
  void clearPath() => $_clearField(2);

  /// Method *related request @type arguments
  @$pb.TagNumber(3)
  $0.Any get data => $_getN(2);
  @$pb.TagNumber(3)
  set data($0.Any value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasData() => $_has(2);
  @$pb.TagNumber(3)
  void clearData() => $_clearField(3);
  @$pb.TagNumber(3)
  $0.Any ensureData() => $_ensure(2);

  /// Metadata. Headers
  @$pb.TagNumber(4)
  $pb.PbMap<$core.String, $core.String> get meta => $_getMap(3);
}

/// RPC Response to the Request
class Response extends $pb.GeneratedMessage {
  factory Response({
    $core.String? id,
    $1.Status? err,
    $0.Any? data,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? meta,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (err != null) result.err = err;
    if (data != null) result.data = data;
    if (meta != null) result.meta.addEntries(meta);
    return result;
  }

  Response._();

  factory Response.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Response.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Response',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'webitel.portal'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOM<$1.Status>(2, _omitFieldNames ? '' : 'err',
        subBuilder: $1.Status.create)
    ..aOM<$0.Any>(3, _omitFieldNames ? '' : 'data', subBuilder: $0.Any.create)
    ..m<$core.String, $core.String>(4, _omitFieldNames ? '' : 'meta',
        entryClassName: 'Response.MetaEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('webitel.portal'))
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Response clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Response copyWith(void Function(Response) updates) =>
      super.copyWith((message) => updates(message as Response)) as Response;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Response create() => Response._();
  @$core.override
  Response createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Response getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Response>(create);
  static Response? _defaultInstance;

  /// Client request id
  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  /// RPC failure status
  @$pb.TagNumber(2)
  $1.Status get err => $_getN(1);
  @$pb.TagNumber(2)
  set err($1.Status value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasErr() => $_has(1);
  @$pb.TagNumber(2)
  void clearErr() => $_clearField(2);
  @$pb.TagNumber(2)
  $1.Status ensureErr() => $_ensure(1);

  /// Result payload data
  @$pb.TagNumber(3)
  $0.Any get data => $_getN(2);
  @$pb.TagNumber(3)
  set data($0.Any value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasData() => $_has(2);
  @$pb.TagNumber(3)
  void clearData() => $_clearField(3);
  @$pb.TagNumber(3)
  $0.Any ensureData() => $_ensure(2);

  /// Metadata. Headers
  @$pb.TagNumber(4)
  $pb.PbMap<$core.String, $core.String> get meta => $_getMap(3);
}

class Echo extends $pb.GeneratedMessage {
  factory Echo({
    $core.List<$core.int>? data,
  }) {
    final result = create();
    if (data != null) result.data = data;
    return result;
  }

  Echo._();

  factory Echo.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Echo.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Echo',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'webitel.portal'),
      createEmptyInstance: create)
    ..a<$core.List<$core.int>>(
        1, _omitFieldNames ? '' : 'data', $pb.PbFieldType.OY)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Echo clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Echo copyWith(void Function(Echo) updates) =>
      super.copyWith((message) => updates(message as Echo)) as Echo;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Echo create() => Echo._();
  @$core.override
  Echo createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Echo getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Echo>(create);
  static Echo? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get data => $_getN(0);
  @$pb.TagNumber(1)
  set data($core.List<$core.int> value) => $_setBytes(0, value);
  @$pb.TagNumber(1)
  $core.bool hasData() => $_has(0);
  @$pb.TagNumber(1)
  void clearData() => $_clearField(1);
}

/// UpdateDisconnect notifies the client about
/// an imminent disconnect due to specified reason.
class UpdateDisconnect extends $pb.GeneratedMessage {
  factory UpdateDisconnect({
    $1.Status? cause,
  }) {
    final result = create();
    if (cause != null) result.cause = cause;
    return result;
  }

  UpdateDisconnect._();

  factory UpdateDisconnect.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateDisconnect.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateDisconnect',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'webitel.portal'),
      createEmptyInstance: create)
    ..aOM<$1.Status>(1, _omitFieldNames ? '' : 'cause',
        subBuilder: $1.Status.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateDisconnect clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateDisconnect copyWith(void Function(UpdateDisconnect) updates) =>
      super.copyWith((message) => updates(message as UpdateDisconnect))
          as UpdateDisconnect;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateDisconnect create() => UpdateDisconnect._();
  @$core.override
  UpdateDisconnect createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static UpdateDisconnect getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateDisconnect>(create);
  static UpdateDisconnect? _defaultInstance;

  /// The disconnect reason
  @$pb.TagNumber(1)
  $1.Status get cause => $_getN(0);
  @$pb.TagNumber(1)
  set cause($1.Status value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasCause() => $_has(0);
  @$pb.TagNumber(1)
  void clearCause() => $_clearField(1);
  @$pb.TagNumber(1)
  $1.Status ensureCause() => $_ensure(0);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
