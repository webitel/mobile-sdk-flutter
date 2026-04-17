// This is a generated file - do not edit.
//
// Generated from portal/block.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import '../google/rpc/status.pb.dart' as $0;
import 'lookup.pb.dart' as $1;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

/// Block
class Block extends $pb.GeneratedMessage {
  factory Block({
    $0.Status? status,
    $fixnum.Int64? updatedAt,
    $1.Lookup? updatedBy,
  }) {
    final result = create();
    if (status != null) result.status = status;
    if (updatedAt != null) result.updatedAt = updatedAt;
    if (updatedBy != null) result.updatedBy = updatedBy;
    return result;
  }

  Block._();

  factory Block.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Block.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Block',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'webitel.portal'),
      createEmptyInstance: create)
    ..aOM<$0.Status>(1, _omitFieldNames ? '' : 'status',
        subBuilder: $0.Status.create)
    ..aInt64(2, _omitFieldNames ? '' : 'updatedAt')
    ..aOM<$1.Lookup>(3, _omitFieldNames ? '' : 'updatedBy',
        subBuilder: $1.Lookup.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Block clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Block copyWith(void Function(Block) updates) =>
      super.copyWith((message) => updates(message as Block)) as Block;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Block create() => Block._();
  @$core.override
  Block createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Block getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Block>(create);
  static Block? _defaultInstance;

  /// Block reason.
  @$pb.TagNumber(1)
  $0.Status get status => $_getN(0);
  @$pb.TagNumber(1)
  set status($0.Status value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasStatus() => $_has(0);
  @$pb.TagNumber(1)
  void clearStatus() => $_clearField(1);
  @$pb.TagNumber(1)
  $0.Status ensureStatus() => $_ensure(0);

  /// Last update timestamp
  @$pb.TagNumber(2)
  $fixnum.Int64 get updatedAt => $_getI64(1);
  @$pb.TagNumber(2)
  set updatedAt($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasUpdatedAt() => $_has(1);
  @$pb.TagNumber(2)
  void clearUpdatedAt() => $_clearField(2);

  /// Last update performer
  @$pb.TagNumber(3)
  $1.Lookup get updatedBy => $_getN(2);
  @$pb.TagNumber(3)
  set updatedBy($1.Lookup value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasUpdatedBy() => $_has(2);
  @$pb.TagNumber(3)
  void clearUpdatedBy() => $_clearField(3);
  @$pb.TagNumber(3)
  $1.Lookup ensureUpdatedBy() => $_ensure(2);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
