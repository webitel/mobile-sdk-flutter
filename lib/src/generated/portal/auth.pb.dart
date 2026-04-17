// This is a generated file - do not edit.
//
// Generated from portal/auth.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'account.pb.dart' as $0;
import 'messages.pb.dart' as $2;
import 'push.pb.dart' as $1;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

/// Access Token Request
class TokenRequest extends $pb.GeneratedMessage {
  factory TokenRequest({
    $core.String? state,
    $core.Iterable<$core.String>? scope,
    $core.String? appToken,
    $core.String? grantType,
    $core.Iterable<$core.String>? responseType,
    $core.String? refreshToken,
    $0.Identity? identity,
    $core.String? code,
    $1.DevicePush? push,
  }) {
    final result = create();
    if (state != null) result.state = state;
    if (scope != null) result.scope.addAll(scope);
    if (appToken != null) result.appToken = appToken;
    if (grantType != null) result.grantType = grantType;
    if (responseType != null) result.responseType.addAll(responseType);
    if (refreshToken != null) result.refreshToken = refreshToken;
    if (identity != null) result.identity = identity;
    if (code != null) result.code = code;
    if (push != null) result.push = push;
    return result;
  }

  TokenRequest._();

  factory TokenRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TokenRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TokenRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'webitel.portal'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'state')
    ..pPS(2, _omitFieldNames ? '' : 'scope')
    ..aOS(3, _omitFieldNames ? '' : 'appToken')
    ..aOS(4, _omitFieldNames ? '' : 'grantType')
    ..pPS(5, _omitFieldNames ? '' : 'responseType')
    ..aOS(11, _omitFieldNames ? '' : 'refreshToken')
    ..aOM<$0.Identity>(12, _omitFieldNames ? '' : 'identity',
        subBuilder: $0.Identity.create)
    ..aOS(13, _omitFieldNames ? '' : 'code')
    ..aOM<$1.DevicePush>(21, _omitFieldNames ? '' : 'push',
        subBuilder: $1.DevicePush.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TokenRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TokenRequest copyWith(void Function(TokenRequest) updates) =>
      super.copyWith((message) => updates(message as TokenRequest))
          as TokenRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TokenRequest create() => TokenRequest._();
  @$core.override
  TokenRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static TokenRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TokenRequest>(create);
  static TokenRequest? _defaultInstance;

  /// RECOMMENDED. An opaque value used by the client to maintain
  /// state between the request and callback.  The authorization
  /// server includes this value when redirecting the user-agent back
  /// to the client.  The parameter SHOULD be used for preventing
  /// cross-site request forgery
  @$pb.TagNumber(1)
  $core.String get state => $_getSZ(0);
  @$pb.TagNumber(1)
  set state($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasState() => $_has(0);
  @$pb.TagNumber(1)
  void clearState() => $_clearField(1);

  /// OPTIONAL. The scope of the access request
  /// Posible values are:
  /// * chat ; [I]nstant [M]essaging service
  /// * call ; [V]oice[o]ver[IP] SIP service
  @$pb.TagNumber(2)
  $pb.PbList<$core.String> get scope => $_getList(1);

  /// REQUIRED. Confidential client authorization token.
  /// May be transmitted in header: X-Portal-Client.
  /// Keep it a secret.
  @$pb.TagNumber(3)
  $core.String get appToken => $_getSZ(2);
  @$pb.TagNumber(3)
  set appToken($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAppToken() => $_has(2);
  @$pb.TagNumber(3)
  void clearAppToken() => $_clearField(3);

  /// REQUIRED. Grant type.
  /// Posible values ; - not implemented ; + supported
  /// - authorization_code ; Authorization Code Grant
  /// - client_credentials ; Client Credentials Grant
  /// - refresh_token      ; Refreshing an Access Token
  /// - password           ; Resource Owner Password Credentials Grant
  /// Extension Grants
  /// + identity           ; Public end-User Identity Grant
  @$pb.TagNumber(4)
  $core.String get grantType => $_getSZ(3);
  @$pb.TagNumber(4)
  set grantType($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasGrantType() => $_has(3);
  @$pb.TagNumber(4)
  void clearGrantType() => $_clearField(4);

  /// REQUIRED. Response type.
  /// Posible values ; - not implemented ; + supported
  /// + token    ; Access token response
  /// - id_token ;
  /// Extensions
  /// + user     ; End-User account profile
  /// + call     ; SIP account credentials
  /// + chat     ; IM account details
  @$pb.TagNumber(5)
  $pb.PbList<$core.String> get responseType => $_getList(4);

  /// Refresh token string to obtain NEW access token.
  /// REQUIRED. When grant_type is set to "refresh_token".
  @$pb.TagNumber(11)
  $core.String get refreshToken => $_getSZ(5);
  @$pb.TagNumber(11)
  set refreshToken($core.String value) => $_setString(5, value);
  @$pb.TagNumber(11)
  $core.bool hasRefreshToken() => $_has(5);
  @$pb.TagNumber(11)
  void clearRefreshToken() => $_clearField(11);

  /// Identity of the end-User account association.
  /// REQUIRED. When grant_type is set to "identity".
  @$pb.TagNumber(12)
  $0.Identity get identity => $_getN(6);
  @$pb.TagNumber(12)
  set identity($0.Identity value) => $_setField(12, value);
  @$pb.TagNumber(12)
  $core.bool hasIdentity() => $_has(6);
  @$pb.TagNumber(12)
  void clearIdentity() => $_clearField(12);
  @$pb.TagNumber(12)
  $0.Identity ensureIdentity() => $_ensure(6);

  /// Authorization code grant.
  /// REQUIRED. When grant_type is set to "authorization_code".
  @$pb.TagNumber(13)
  $core.String get code => $_getSZ(7);
  @$pb.TagNumber(13)
  set code($core.String value) => $_setString(7, value);
  @$pb.TagNumber(13)
  $core.bool hasCode() => $_has(7);
  @$pb.TagNumber(13)
  void clearCode() => $_clearField(13);

  /// OPTIONAL. Sign up client device for PUSH notifications.
  @$pb.TagNumber(21)
  $1.DevicePush get push => $_getN(8);
  @$pb.TagNumber(21)
  set push($1.DevicePush value) => $_setField(21, value);
  @$pb.TagNumber(21)
  $core.bool hasPush() => $_has(8);
  @$pb.TagNumber(21)
  void clearPush() => $_clearField(21);
  @$pb.TagNumber(21)
  $1.DevicePush ensurePush() => $_ensure(8);
}

/// Access Token Response
class AccessToken extends $pb.GeneratedMessage {
  factory AccessToken({
    $core.int? expiresIn,
    $core.String? tokenType,
    $core.String? accessToken,
    $core.String? refreshToken,
    $core.Iterable<$core.String>? scope,
    $core.String? state,
    $0.UserProfile? user,
    $0.CallAccount? call,
    $2.ChatAccount? chat,
  }) {
    final result = create();
    if (expiresIn != null) result.expiresIn = expiresIn;
    if (tokenType != null) result.tokenType = tokenType;
    if (accessToken != null) result.accessToken = accessToken;
    if (refreshToken != null) result.refreshToken = refreshToken;
    if (scope != null) result.scope.addAll(scope);
    if (state != null) result.state = state;
    if (user != null) result.user = user;
    if (call != null) result.call = call;
    if (chat != null) result.chat = chat;
    return result;
  }

  AccessToken._();

  factory AccessToken.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AccessToken.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AccessToken',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'webitel.portal'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'expiresIn')
    ..aOS(2, _omitFieldNames ? '' : 'tokenType')
    ..aOS(3, _omitFieldNames ? '' : 'accessToken')
    ..aOS(4, _omitFieldNames ? '' : 'refreshToken')
    ..pPS(5, _omitFieldNames ? '' : 'scope')
    ..aOS(6, _omitFieldNames ? '' : 'state')
    ..aOM<$0.UserProfile>(21, _omitFieldNames ? '' : 'user',
        subBuilder: $0.UserProfile.create)
    ..aOM<$0.CallAccount>(22, _omitFieldNames ? '' : 'call',
        subBuilder: $0.CallAccount.create)
    ..aOM<$2.ChatAccount>(23, _omitFieldNames ? '' : 'chat',
        subBuilder: $2.ChatAccount.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AccessToken clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AccessToken copyWith(void Function(AccessToken) updates) =>
      super.copyWith((message) => updates(message as AccessToken))
          as AccessToken;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AccessToken create() => AccessToken._();
  @$core.override
  AccessToken createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static AccessToken getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AccessToken>(create);
  static AccessToken? _defaultInstance;

  /// RECOMMENDED. The lifetime in seconds of the access token.
  @$pb.TagNumber(1)
  $core.int get expiresIn => $_getIZ(0);
  @$pb.TagNumber(1)
  set expiresIn($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasExpiresIn() => $_has(0);
  @$pb.TagNumber(1)
  void clearExpiresIn() => $_clearField(1);

  /// REQUIRED. The type of the token issued. Value is case insensitive.
  @$pb.TagNumber(2)
  $core.String get tokenType => $_getSZ(1);
  @$pb.TagNumber(2)
  set tokenType($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTokenType() => $_has(1);
  @$pb.TagNumber(2)
  void clearTokenType() => $_clearField(2);

  /// REQUIRED. The access token issued by the authorization server.
  @$pb.TagNumber(3)
  $core.String get accessToken => $_getSZ(2);
  @$pb.TagNumber(3)
  set accessToken($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAccessToken() => $_has(2);
  @$pb.TagNumber(3)
  void clearAccessToken() => $_clearField(3);

  /// OPTIONAL. The refresh token, which can be used to obtain
  /// new access tokens using the same authorization grant.
  @$pb.TagNumber(4)
  $core.String get refreshToken => $_getSZ(3);
  @$pb.TagNumber(4)
  set refreshToken($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasRefreshToken() => $_has(3);
  @$pb.TagNumber(4)
  void clearRefreshToken() => $_clearField(4);

  /// OPTIONAL, if identical to the scope requested by the client;
  /// otherwise, REQUIRED. The scope of the access token.
  @$pb.TagNumber(5)
  $pb.PbList<$core.String> get scope => $_getList(4);

  /// REQUIRED if the "state" parameter was present in the client
  /// authorization request. The exact value received from the client.
  @$pb.TagNumber(6)
  $core.String get state => $_getSZ(5);
  @$pb.TagNumber(6)
  set state($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasState() => $_has(5);
  @$pb.TagNumber(6)
  void clearState() => $_clearField(6);

  /// End-User account profile.
  @$pb.TagNumber(21)
  $0.UserProfile get user => $_getN(6);
  @$pb.TagNumber(21)
  set user($0.UserProfile value) => $_setField(21, value);
  @$pb.TagNumber(21)
  $core.bool hasUser() => $_has(6);
  @$pb.TagNumber(21)
  void clearUser() => $_clearField(21);
  @$pb.TagNumber(21)
  $0.UserProfile ensureUser() => $_ensure(6);

  /// VoIP / SIP service credentials.
  @$pb.TagNumber(22)
  $0.CallAccount get call => $_getN(7);
  @$pb.TagNumber(22)
  set call($0.CallAccount value) => $_setField(22, value);
  @$pb.TagNumber(22)
  $core.bool hasCall() => $_has(7);
  @$pb.TagNumber(22)
  void clearCall() => $_clearField(22);
  @$pb.TagNumber(22)
  $0.CallAccount ensureCall() => $_ensure(7);

  /// [I]nstant [M]essaging dialog state.
  @$pb.TagNumber(23)
  $2.ChatAccount get chat => $_getN(8);
  @$pb.TagNumber(23)
  set chat($2.ChatAccount value) => $_setField(23, value);
  @$pb.TagNumber(23)
  $core.bool hasChat() => $_has(8);
  @$pb.TagNumber(23)
  void clearChat() => $_clearField(23);
  @$pb.TagNumber(23)
  $2.ChatAccount ensureChat() => $_ensure(8);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
