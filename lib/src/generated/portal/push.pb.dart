// This is a generated file - do not edit.
//
// Generated from portal/push.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

enum DevicePush_Token { fCM, aPN, web, notSet }

/// PUSH Subscription
/// https://core.telegram.org/api/push-updates#subscribing-to-notifications
class DevicePush extends $pb.GeneratedMessage {
  factory DevicePush({
    $core.String? fCM,
    $core.String? aPN,
    WebPush? web,
    $core.String? secret,
  }) {
    final result = create();
    if (fCM != null) result.fCM = fCM;
    if (aPN != null) result.aPN = aPN;
    if (web != null) result.web = web;
    if (secret != null) result.secret = secret;
    return result;
  }

  DevicePush._();

  factory DevicePush.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DevicePush.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static const $core.Map<$core.int, DevicePush_Token> _DevicePush_TokenByTag = {
    1: DevicePush_Token.fCM,
    2: DevicePush_Token.aPN,
    10: DevicePush_Token.web,
    0: DevicePush_Token.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DevicePush',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'webitel.portal'),
      createEmptyInstance: create)
    ..oo(0, [1, 2, 10])
    ..aOS(1, _omitFieldNames ? '' : 'FCM', protoName: 'FCM')
    ..aOS(2, _omitFieldNames ? '' : 'APN', protoName: 'APN')
    ..aOM<WebPush>(10, _omitFieldNames ? '' : 'web', subBuilder: WebPush.create)
    ..aOS(20, _omitFieldNames ? '' : 'secret')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DevicePush clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DevicePush copyWith(void Function(DevicePush) updates) =>
      super.copyWith((message) => updates(message as DevicePush)) as DevicePush;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DevicePush create() => DevicePush._();
  @$core.override
  DevicePush createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static DevicePush getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DevicePush>(create);
  static DevicePush? _defaultInstance;

  @$pb.TagNumber(1)
  @$pb.TagNumber(2)
  @$pb.TagNumber(10)
  DevicePush_Token whichToken() => _DevicePush_TokenByTag[$_whichOneof(0)]!;
  @$pb.TagNumber(1)
  @$pb.TagNumber(2)
  @$pb.TagNumber(10)
  void clearToken() => $_clearField($_whichOneof(0));

  /// [F]irebase [C]loud [M]essaging Service (firebase token for google firebase)
  @$pb.TagNumber(1)
  $core.String get fCM => $_getSZ(0);
  @$pb.TagNumber(1)
  set fCM($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasFCM() => $_has(0);
  @$pb.TagNumber(1)
  void clearFCM() => $_clearField(1);

  /// [A]pple [P]ush [N]otification Service (device token for apple push)
  @$pb.TagNumber(2)
  $core.String get aPN => $_getSZ(1);
  @$pb.TagNumber(2)
  set aPN($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAPN() => $_has(1);
  @$pb.TagNumber(2)
  void clearAPN() => $_clearField(2);

  /// For 10 web push, the token must be a JSON-encoded object with the following keys:
  /// endpoint: Absolute URL exposed by the push service where the application server can send push messages
  /// keys: P-256 elliptic curve Diffie-Hellman parameters in the following object
  /// p256dh: Base64url-encoded P-256 elliptic curve Diffie-Hellman public key
  /// auth: Base64url-encoded authentication secret
  @$pb.TagNumber(10)
  WebPush get web => $_getN(2);
  @$pb.TagNumber(10)
  set web(WebPush value) => $_setField(10, value);
  @$pb.TagNumber(10)
  $core.bool hasWeb() => $_has(2);
  @$pb.TagNumber(10)
  void clearWeb() => $_clearField(10);
  @$pb.TagNumber(10)
  WebPush ensureWeb() => $_ensure(2);

  /// For FCM and APNS VoIP, optional encryption key used to encrypt push notifications
  @$pb.TagNumber(20)
  $core.String get secret => $_getSZ(3);
  @$pb.TagNumber(20)
  set secret($core.String value) => $_setString(3, value);
  @$pb.TagNumber(20)
  $core.bool hasSecret() => $_has(3);
  @$pb.TagNumber(20)
  void clearSecret() => $_clearField(20);
}

/// keys: P-256 elliptic curve Diffie-Hellman parameters in the following object
/// p256dh: Base64url-encoded P-256 elliptic curve Diffie-Hellman public key
/// auth: Base64url-encoded authentication secret
class WebPush_Key extends $pb.GeneratedMessage {
  factory WebPush_Key({
    $core.List<$core.int>? auth,
    $core.List<$core.int>? p256dh,
  }) {
    final result = create();
    if (auth != null) result.auth = auth;
    if (p256dh != null) result.p256dh = p256dh;
    return result;
  }

  WebPush_Key._();

  factory WebPush_Key.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory WebPush_Key.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'WebPush.Key',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'webitel.portal'),
      createEmptyInstance: create)
    ..a<$core.List<$core.int>>(
        1, _omitFieldNames ? '' : 'auth', $pb.PbFieldType.OY)
    ..a<$core.List<$core.int>>(
        2, _omitFieldNames ? '' : 'p256dh', $pb.PbFieldType.OY)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WebPush_Key clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WebPush_Key copyWith(void Function(WebPush_Key) updates) =>
      super.copyWith((message) => updates(message as WebPush_Key))
          as WebPush_Key;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static WebPush_Key create() => WebPush_Key._();
  @$core.override
  WebPush_Key createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static WebPush_Key getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<WebPush_Key>(create);
  static WebPush_Key? _defaultInstance;

  /// auth: Base64url-encoded authentication secret
  @$pb.TagNumber(1)
  $core.List<$core.int> get auth => $_getN(0);
  @$pb.TagNumber(1)
  set auth($core.List<$core.int> value) => $_setBytes(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAuth() => $_has(0);
  @$pb.TagNumber(1)
  void clearAuth() => $_clearField(1);

  /// p256dh: Base64url-encoded P-256 elliptic curve Diffie-Hellman public key
  @$pb.TagNumber(2)
  $core.List<$core.int> get p256dh => $_getN(1);
  @$pb.TagNumber(2)
  set p256dh($core.List<$core.int> value) => $_setBytes(1, value);
  @$pb.TagNumber(2)
  $core.bool hasP256dh() => $_has(1);
  @$pb.TagNumber(2)
  void clearP256dh() => $_clearField(2);
}

/// WebPUSH subscription
class WebPush extends $pb.GeneratedMessage {
  factory WebPush({
    $core.String? endpoint,
    WebPush_Key? key,
  }) {
    final result = create();
    if (endpoint != null) result.endpoint = endpoint;
    if (key != null) result.key = key;
    return result;
  }

  WebPush._();

  factory WebPush.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory WebPush.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'WebPush',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'webitel.portal'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'endpoint')
    ..aOM<WebPush_Key>(2, _omitFieldNames ? '' : 'key',
        subBuilder: WebPush_Key.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WebPush clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WebPush copyWith(void Function(WebPush) updates) =>
      super.copyWith((message) => updates(message as WebPush)) as WebPush;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static WebPush create() => WebPush._();
  @$core.override
  WebPush createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static WebPush getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<WebPush>(create);
  static WebPush? _defaultInstance;

  /// endpoint: Absolute URL exposed by the push service where the application server can send push messages
  @$pb.TagNumber(1)
  $core.String get endpoint => $_getSZ(0);
  @$pb.TagNumber(1)
  set endpoint($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasEndpoint() => $_has(0);
  @$pb.TagNumber(1)
  void clearEndpoint() => $_clearField(1);

  /// P-256 elliptic curve Diffie-Hellman parameters
  @$pb.TagNumber(2)
  WebPush_Key get key => $_getN(1);
  @$pb.TagNumber(2)
  set key(WebPush_Key value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasKey() => $_has(1);
  @$pb.TagNumber(2)
  void clearKey() => $_clearField(2);
  @$pb.TagNumber(2)
  WebPush_Key ensureKey() => $_ensure(1);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
