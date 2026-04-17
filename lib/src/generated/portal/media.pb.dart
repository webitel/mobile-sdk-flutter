// This is a generated file - do not edit.
//
// Generated from portal/media.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import '../chat/messages/message.pb.dart' as $1;
import 'connect.pb.dart' as $2;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class InputFile extends $pb.GeneratedMessage {
  factory InputFile({
    $core.String? type,
    $core.String? name,
  }) {
    final result = create();
    if (type != null) result.type = type;
    if (name != null) result.name = name;
    return result;
  }

  InputFile._();

  factory InputFile.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory InputFile.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'InputFile',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'webitel.portal'),
      createEmptyInstance: create)
    ..aOS(4, _omitFieldNames ? '' : 'type')
    ..aOS(5, _omitFieldNames ? '' : 'name')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InputFile clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InputFile copyWith(void Function(InputFile) updates) =>
      super.copyWith((message) => updates(message as InputFile)) as InputFile;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InputFile create() => InputFile._();
  @$core.override
  InputFile createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static InputFile getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<InputFile>(create);
  static InputFile? _defaultInstance;

  /// MIME type
  @$pb.TagNumber(4)
  $core.String get type => $_getSZ(0);
  @$pb.TagNumber(4)
  set type($core.String value) => $_setString(0, value);
  @$pb.TagNumber(4)
  $core.bool hasType() => $_has(0);
  @$pb.TagNumber(4)
  void clearType() => $_clearField(4);

  /// Filename
  @$pb.TagNumber(5)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(5)
  set name($core.String value) => $_setString(1, value);
  @$pb.TagNumber(5)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(5)
  void clearName() => $_clearField(5);
}

/// Start Request
class UploadRequest_Start extends $pb.GeneratedMessage {
  factory UploadRequest_Start({
    InputFile? file,
    $core.bool? progress,
  }) {
    final result = create();
    if (file != null) result.file = file;
    if (progress != null) result.progress = progress;
    return result;
  }

  UploadRequest_Start._();

  factory UploadRequest_Start.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UploadRequest_Start.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UploadRequest.Start',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'webitel.portal'),
      createEmptyInstance: create)
    ..aOM<InputFile>(1, _omitFieldNames ? '' : 'file',
        subBuilder: InputFile.create)
    ..aOB(2, _omitFieldNames ? '' : 'progress')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UploadRequest_Start clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UploadRequest_Start copyWith(void Function(UploadRequest_Start) updates) =>
      super.copyWith((message) => updates(message as UploadRequest_Start))
          as UploadRequest_Start;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UploadRequest_Start create() => UploadRequest_Start._();
  @$core.override
  UploadRequest_Start createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static UploadRequest_Start getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UploadRequest_Start>(create);
  static UploadRequest_Start? _defaultInstance;

  /// Fileinfo header.
  @$pb.TagNumber(1)
  InputFile get file => $_getN(0);
  @$pb.TagNumber(1)
  set file(InputFile value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasFile() => $_has(0);
  @$pb.TagNumber(1)
  void clearFile() => $_clearField(1);
  @$pb.TagNumber(1)
  InputFile ensureFile() => $_ensure(0);

  /// Confirm receipt ?
  ///
  /// If true, in response to the transfer of each part,
  /// you will receive an acknowledgement of receipt
  /// in the form of the total size of the stored data.
  ///
  /// This setting will be associated with upload process
  /// and cannot be changed later.
  @$pb.TagNumber(2)
  $core.bool get progress => $_getBF(1);
  @$pb.TagNumber(2)
  set progress($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasProgress() => $_has(1);
  @$pb.TagNumber(2)
  void clearProgress() => $_clearField(2);
}

/// Abort Request
class UploadRequest_Abort extends $pb.GeneratedMessage {
  factory UploadRequest_Abort() => create();

  UploadRequest_Abort._();

  factory UploadRequest_Abort.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UploadRequest_Abort.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UploadRequest.Abort',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'webitel.portal'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UploadRequest_Abort clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UploadRequest_Abort copyWith(void Function(UploadRequest_Abort) updates) =>
      super.copyWith((message) => updates(message as UploadRequest_Abort))
          as UploadRequest_Abort;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UploadRequest_Abort create() => UploadRequest_Abort._();
  @$core.override
  UploadRequest_Abort createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static UploadRequest_Abort getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UploadRequest_Abort>(create);
  static UploadRequest_Abort? _defaultInstance;
}

enum UploadRequest_Data { pid, new_2, part, kill, notSet }

class UploadRequest extends $pb.GeneratedMessage {
  factory UploadRequest({
    $core.String? pid,
    UploadRequest_Start? new_2,
    $core.List<$core.int>? part,
    UploadRequest_Abort? kill,
  }) {
    final result = create();
    if (pid != null) result.pid = pid;
    if (new_2 != null) result.new_2 = new_2;
    if (part != null) result.part = part;
    if (kill != null) result.kill = kill;
    return result;
  }

  UploadRequest._();

  factory UploadRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UploadRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static const $core.Map<$core.int, UploadRequest_Data>
      _UploadRequest_DataByTag = {
    1: UploadRequest_Data.pid,
    2: UploadRequest_Data.new_2,
    3: UploadRequest_Data.part,
    4: UploadRequest_Data.kill,
    0: UploadRequest_Data.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UploadRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'webitel.portal'),
      createEmptyInstance: create)
    ..oo(0, [1, 2, 3, 4])
    ..aOS(1, _omitFieldNames ? '' : 'pid')
    ..aOM<UploadRequest_Start>(2, _omitFieldNames ? '' : 'new',
        subBuilder: UploadRequest_Start.create)
    ..a<$core.List<$core.int>>(
        3, _omitFieldNames ? '' : 'part', $pb.PbFieldType.OY)
    ..aOM<UploadRequest_Abort>(4, _omitFieldNames ? '' : 'kill',
        subBuilder: UploadRequest_Abort.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UploadRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UploadRequest copyWith(void Function(UploadRequest) updates) =>
      super.copyWith((message) => updates(message as UploadRequest))
          as UploadRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UploadRequest create() => UploadRequest._();
  @$core.override
  UploadRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static UploadRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UploadRequest>(create);
  static UploadRequest? _defaultInstance;

  @$pb.TagNumber(1)
  @$pb.TagNumber(2)
  @$pb.TagNumber(3)
  @$pb.TagNumber(4)
  UploadRequest_Data whichData() => _UploadRequest_DataByTag[$_whichOneof(0)]!;
  @$pb.TagNumber(1)
  @$pb.TagNumber(2)
  @$pb.TagNumber(3)
  @$pb.TagNumber(4)
  void clearData() => $_clearField($_whichOneof(0));

  /// Continue upload ...
  @$pb.TagNumber(1)
  $core.String get pid => $_getSZ(0);
  @$pb.TagNumber(1)
  set pid($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPid() => $_has(0);
  @$pb.TagNumber(1)
  void clearPid() => $_clearField(1);

  /// Start NEW upload ...
  @$pb.TagNumber(2)
  UploadRequest_Start get new_2 => $_getN(1);
  @$pb.TagNumber(2)
  set new_2(UploadRequest_Start value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasNew_2() => $_has(1);
  @$pb.TagNumber(2)
  void clearNew_2() => $_clearField(2);
  @$pb.TagNumber(2)
  UploadRequest_Start ensureNew_2() => $_ensure(1);

  /// Multipart(s) data ...
  @$pb.TagNumber(3)
  $core.List<$core.int> get part => $_getN(2);
  @$pb.TagNumber(3)
  set part($core.List<$core.int> value) => $_setBytes(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPart() => $_has(2);
  @$pb.TagNumber(3)
  void clearPart() => $_clearField(3);

  /// Abort upload progress !?
  @$pb.TagNumber(4)
  UploadRequest_Abort get kill => $_getN(3);
  @$pb.TagNumber(4)
  set kill(UploadRequest_Abort value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasKill() => $_has(3);
  @$pb.TagNumber(4)
  void clearKill() => $_clearField(4);
  @$pb.TagNumber(4)
  UploadRequest_Abort ensureKill() => $_ensure(3);
}

/// Partial state
class UploadProgress_Partial extends $pb.GeneratedMessage {
  factory UploadProgress_Partial({
    $core.String? pid,
    $fixnum.Int64? size,
  }) {
    final result = create();
    if (pid != null) result.pid = pid;
    if (size != null) result.size = size;
    return result;
  }

  UploadProgress_Partial._();

  factory UploadProgress_Partial.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UploadProgress_Partial.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UploadProgress.Partial',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'webitel.portal'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'pid')
    ..aInt64(2, _omitFieldNames ? '' : 'size')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UploadProgress_Partial clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UploadProgress_Partial copyWith(
          void Function(UploadProgress_Partial) updates) =>
      super.copyWith((message) => updates(message as UploadProgress_Partial))
          as UploadProgress_Partial;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UploadProgress_Partial create() => UploadProgress_Partial._();
  @$core.override
  UploadProgress_Partial createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static UploadProgress_Partial getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UploadProgress_Partial>(create);
  static UploadProgress_Partial? _defaultInstance;

  /// Upload process unique ID.
  /// You can use this ID to continue an interrupted upload
  @$pb.TagNumber(1)
  $core.String get pid => $_getSZ(0);
  @$pb.TagNumber(1)
  set pid($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPid() => $_has(0);
  @$pb.TagNumber(1)
  void clearPid() => $_clearField(1);

  /// Total size of saved data.
  @$pb.TagNumber(2)
  $fixnum.Int64 get size => $_getI64(1);
  @$pb.TagNumber(2)
  set size($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSize() => $_has(1);
  @$pb.TagNumber(2)
  void clearSize() => $_clearField(2);
}

/// Uploaded file info.
class UploadProgress_Complete extends $pb.GeneratedMessage {
  factory UploadProgress_Complete({
    $1.File? file,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? hash,
  }) {
    final result = create();
    if (file != null) result.file = file;
    if (hash != null) result.hash.addEntries(hash);
    return result;
  }

  UploadProgress_Complete._();

  factory UploadProgress_Complete.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UploadProgress_Complete.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UploadProgress.Complete',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'webitel.portal'),
      createEmptyInstance: create)
    ..aOM<$1.File>(1, _omitFieldNames ? '' : 'file', subBuilder: $1.File.create)
    ..m<$core.String, $core.String>(2, _omitFieldNames ? '' : 'hash',
        entryClassName: 'UploadProgress.Complete.HashEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('webitel.portal'))
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UploadProgress_Complete clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UploadProgress_Complete copyWith(
          void Function(UploadProgress_Complete) updates) =>
      super.copyWith((message) => updates(message as UploadProgress_Complete))
          as UploadProgress_Complete;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UploadProgress_Complete create() => UploadProgress_Complete._();
  @$core.override
  UploadProgress_Complete createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static UploadProgress_Complete getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UploadProgress_Complete>(create);
  static UploadProgress_Complete? _defaultInstance;

  /// Saved document metadata.
  @$pb.TagNumber(1)
  $1.File get file => $_getN(0);
  @$pb.TagNumber(1)
  set file($1.File value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasFile() => $_has(0);
  @$pb.TagNumber(1)
  void clearFile() => $_clearField(1);
  @$pb.TagNumber(1)
  $1.File ensureFile() => $_ensure(0);

  /// Hashsum variants of stored data. map[algo]hash
  @$pb.TagNumber(2)
  $pb.PbMap<$core.String, $core.String> get hash => $_getMap(1);
}

enum UploadProgress_Data { part, stat, end, notSet }

class UploadProgress extends $pb.GeneratedMessage {
  factory UploadProgress({
    UploadProgress_Partial? part,
    UploadProgress_Complete? stat,
    $2.UpdateDisconnect? end,
  }) {
    final result = create();
    if (part != null) result.part = part;
    if (stat != null) result.stat = stat;
    if (end != null) result.end = end;
    return result;
  }

  UploadProgress._();

  factory UploadProgress.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UploadProgress.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static const $core.Map<$core.int, UploadProgress_Data>
      _UploadProgress_DataByTag = {
    1: UploadProgress_Data.part,
    2: UploadProgress_Data.stat,
    3: UploadProgress_Data.end,
    0: UploadProgress_Data.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UploadProgress',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'webitel.portal'),
      createEmptyInstance: create)
    ..oo(0, [1, 2, 3])
    ..aOM<UploadProgress_Partial>(1, _omitFieldNames ? '' : 'part',
        subBuilder: UploadProgress_Partial.create)
    ..aOM<UploadProgress_Complete>(2, _omitFieldNames ? '' : 'stat',
        subBuilder: UploadProgress_Complete.create)
    ..aOM<$2.UpdateDisconnect>(3, _omitFieldNames ? '' : 'end',
        subBuilder: $2.UpdateDisconnect.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UploadProgress clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UploadProgress copyWith(void Function(UploadProgress) updates) =>
      super.copyWith((message) => updates(message as UploadProgress))
          as UploadProgress;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UploadProgress create() => UploadProgress._();
  @$core.override
  UploadProgress createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static UploadProgress getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UploadProgress>(create);
  static UploadProgress? _defaultInstance;

  @$pb.TagNumber(1)
  @$pb.TagNumber(2)
  @$pb.TagNumber(3)
  UploadProgress_Data whichData() =>
      _UploadProgress_DataByTag[$_whichOneof(0)]!;
  @$pb.TagNumber(1)
  @$pb.TagNumber(2)
  @$pb.TagNumber(3)
  void clearData() => $_clearField($_whichOneof(0));

  /// Partial progress. Start/ACK.
  @$pb.TagNumber(1)
  UploadProgress_Partial get part => $_getN(0);
  @$pb.TagNumber(1)
  set part(UploadProgress_Partial value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasPart() => $_has(0);
  @$pb.TagNumber(1)
  void clearPart() => $_clearField(1);
  @$pb.TagNumber(1)
  UploadProgress_Partial ensurePart() => $_ensure(0);

  /// Upload complete. Result.
  @$pb.TagNumber(2)
  UploadProgress_Complete get stat => $_getN(1);
  @$pb.TagNumber(2)
  set stat(UploadProgress_Complete value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasStat() => $_has(1);
  @$pb.TagNumber(2)
  void clearStat() => $_clearField(2);
  @$pb.TagNumber(2)
  UploadProgress_Complete ensureStat() => $_ensure(1);

  /// Early notification about
  /// upstream disconnect init.
  @$pb.TagNumber(3)
  $2.UpdateDisconnect get end => $_getN(2);
  @$pb.TagNumber(3)
  set end($2.UpdateDisconnect value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasEnd() => $_has(2);
  @$pb.TagNumber(3)
  void clearEnd() => $_clearField(3);
  @$pb.TagNumber(3)
  $2.UpdateDisconnect ensureEnd() => $_ensure(2);
}

enum UploadMedia_MediaType { file, data, notSet }

class UploadMedia extends $pb.GeneratedMessage {
  factory UploadMedia({
    InputFile? file,
    $core.List<$core.int>? data,
  }) {
    final result = create();
    if (file != null) result.file = file;
    if (data != null) result.data = data;
    return result;
  }

  UploadMedia._();

  factory UploadMedia.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UploadMedia.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static const $core.Map<$core.int, UploadMedia_MediaType>
      _UploadMedia_MediaTypeByTag = {
    1: UploadMedia_MediaType.file,
    2: UploadMedia_MediaType.data,
    0: UploadMedia_MediaType.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UploadMedia',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'webitel.portal'),
      createEmptyInstance: create)
    ..oo(0, [1, 2])
    ..aOM<InputFile>(1, _omitFieldNames ? '' : 'file',
        subBuilder: InputFile.create)
    ..a<$core.List<$core.int>>(
        2, _omitFieldNames ? '' : 'data', $pb.PbFieldType.OY)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UploadMedia clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UploadMedia copyWith(void Function(UploadMedia) updates) =>
      super.copyWith((message) => updates(message as UploadMedia))
          as UploadMedia;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UploadMedia create() => UploadMedia._();
  @$core.override
  UploadMedia createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static UploadMedia getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UploadMedia>(create);
  static UploadMedia? _defaultInstance;

  @$pb.TagNumber(1)
  @$pb.TagNumber(2)
  UploadMedia_MediaType whichMediaType() =>
      _UploadMedia_MediaTypeByTag[$_whichOneof(0)]!;
  @$pb.TagNumber(1)
  @$pb.TagNumber(2)
  void clearMediaType() => $_clearField($_whichOneof(0));

  /// File metadata info
  @$pb.TagNumber(1)
  InputFile get file => $_getN(0);
  @$pb.TagNumber(1)
  set file(InputFile value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasFile() => $_has(0);
  @$pb.TagNumber(1)
  void clearFile() => $_clearField(1);
  @$pb.TagNumber(1)
  InputFile ensureFile() => $_ensure(0);

  /// File content part
  @$pb.TagNumber(2)
  $core.List<$core.int> get data => $_getN(1);
  @$pb.TagNumber(2)
  set data($core.List<$core.int> value) => $_setBytes(1, value);
  @$pb.TagNumber(2)
  $core.bool hasData() => $_has(1);
  @$pb.TagNumber(2)
  void clearData() => $_clearField(2);
}

class GetFileRequest extends $pb.GeneratedMessage {
  factory GetFileRequest({
    $core.String? fileId,
    $fixnum.Int64? offset,
  }) {
    final result = create();
    if (fileId != null) result.fileId = fileId;
    if (offset != null) result.offset = offset;
    return result;
  }

  GetFileRequest._();

  factory GetFileRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetFileRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetFileRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'webitel.portal'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'fileId')
    ..aInt64(2, _omitFieldNames ? '' : 'offset')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetFileRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetFileRequest copyWith(void Function(GetFileRequest) updates) =>
      super.copyWith((message) => updates(message as GetFileRequest))
          as GetFileRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetFileRequest create() => GetFileRequest._();
  @$core.override
  GetFileRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetFileRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetFileRequest>(create);
  static GetFileRequest? _defaultInstance;

  /// File location
  @$pb.TagNumber(1)
  $core.String get fileId => $_getSZ(0);
  @$pb.TagNumber(1)
  set fileId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasFileId() => $_has(0);
  @$pb.TagNumber(1)
  void clearFileId() => $_clearField(1);

  /// Range: bytes=<start>
  @$pb.TagNumber(2)
  $fixnum.Int64 get offset => $_getI64(1);
  @$pb.TagNumber(2)
  set offset($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasOffset() => $_has(1);
  @$pb.TagNumber(2)
  void clearOffset() => $_clearField(2);
}

enum MediaFile_MediaType { file, data, end, notSet }

class MediaFile extends $pb.GeneratedMessage {
  factory MediaFile({
    $1.File? file,
    $core.List<$core.int>? data,
    $2.UpdateDisconnect? end,
  }) {
    final result = create();
    if (file != null) result.file = file;
    if (data != null) result.data = data;
    if (end != null) result.end = end;
    return result;
  }

  MediaFile._();

  factory MediaFile.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MediaFile.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static const $core.Map<$core.int, MediaFile_MediaType>
      _MediaFile_MediaTypeByTag = {
    1: MediaFile_MediaType.file,
    2: MediaFile_MediaType.data,
    3: MediaFile_MediaType.end,
    0: MediaFile_MediaType.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MediaFile',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'webitel.portal'),
      createEmptyInstance: create)
    ..oo(0, [1, 2, 3])
    ..aOM<$1.File>(1, _omitFieldNames ? '' : 'file', subBuilder: $1.File.create)
    ..a<$core.List<$core.int>>(
        2, _omitFieldNames ? '' : 'data', $pb.PbFieldType.OY)
    ..aOM<$2.UpdateDisconnect>(3, _omitFieldNames ? '' : 'end',
        subBuilder: $2.UpdateDisconnect.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MediaFile clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MediaFile copyWith(void Function(MediaFile) updates) =>
      super.copyWith((message) => updates(message as MediaFile)) as MediaFile;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MediaFile create() => MediaFile._();
  @$core.override
  MediaFile createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static MediaFile getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MediaFile>(create);
  static MediaFile? _defaultInstance;

  @$pb.TagNumber(1)
  @$pb.TagNumber(2)
  @$pb.TagNumber(3)
  MediaFile_MediaType whichMediaType() =>
      _MediaFile_MediaTypeByTag[$_whichOneof(0)]!;
  @$pb.TagNumber(1)
  @$pb.TagNumber(2)
  @$pb.TagNumber(3)
  void clearMediaType() => $_clearField($_whichOneof(0));

  /// File metadata info
  @$pb.TagNumber(1)
  $1.File get file => $_getN(0);
  @$pb.TagNumber(1)
  set file($1.File value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasFile() => $_has(0);
  @$pb.TagNumber(1)
  void clearFile() => $_clearField(1);
  @$pb.TagNumber(1)
  $1.File ensureFile() => $_ensure(0);

  /// File content part
  @$pb.TagNumber(2)
  $core.List<$core.int> get data => $_getN(1);
  @$pb.TagNumber(2)
  set data($core.List<$core.int> value) => $_setBytes(1, value);
  @$pb.TagNumber(2)
  $core.bool hasData() => $_has(1);
  @$pb.TagNumber(2)
  void clearData() => $_clearField(2);

  /// Early notification about
  /// upstream disconnect init.
  @$pb.TagNumber(3)
  $2.UpdateDisconnect get end => $_getN(2);
  @$pb.TagNumber(3)
  set end($2.UpdateDisconnect value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasEnd() => $_has(2);
  @$pb.TagNumber(3)
  void clearEnd() => $_clearField(3);
  @$pb.TagNumber(3)
  $2.UpdateDisconnect ensureEnd() => $_ensure(2);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
