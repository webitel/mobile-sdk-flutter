// This is a generated file - do not edit.
//
// Generated from portal/account.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;
import 'package:protobuf/well_known_types/google/protobuf/struct.pb.dart' as $0;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

/// Subject source identification
class SourceId extends $pb.GeneratedMessage {
  factory SourceId({
    $core.String? iss,
    $core.String? sub,
  }) {
    final result = create();
    if (iss != null) result.iss = iss;
    if (sub != null) result.sub = sub;
    return result;
  }

  SourceId._();

  factory SourceId.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SourceId.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SourceId',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'webitel.portal'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'iss')
    ..aOS(2, _omitFieldNames ? '' : 'sub')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SourceId clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SourceId copyWith(void Function(SourceId) updates) =>
      super.copyWith((message) => updates(message as SourceId)) as SourceId;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SourceId create() => SourceId._();
  @$core.override
  SourceId createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static SourceId getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SourceId>(create);
  static SourceId? _defaultInstance;

  /// REQUIRED. Issuer Identifier for the Issuer of the response.
  /// The iss value is a case sensitive URL using the https scheme that contains scheme, host,
  /// and optionally, port number and path components and no query or fragment components.
  @$pb.TagNumber(1)
  $core.String get iss => $_getSZ(0);
  @$pb.TagNumber(1)
  set iss($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasIss() => $_has(0);
  @$pb.TagNumber(1)
  void clearIss() => $_clearField(1);

  /// REQUIRED. Subject Identifier.
  /// A locally unique and never reassigned identifier within the Issuer for the End-User,
  /// which is intended to be consumed by the Client, e.g., 24400320 or AItOawmwtWwcT0k51BayewNvutrJUqsvl6qs7A4.
  /// It MUST NOT exceed 255 ASCII characters in length.
  /// The sub value is a case sensitive string.
  @$pb.TagNumber(2)
  $core.String get sub => $_getSZ(1);
  @$pb.TagNumber(2)
  set sub($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSub() => $_has(1);
  @$pb.TagNumber(2)
  void clearSub() => $_clearField(2);
}

/// Identity of the End-User at the Issuer.
/// https://openid.net/specs/openid-connect-core-1_0.html#Claims
class Identity extends $pb.GeneratedMessage {
  factory Identity({
    $core.String? iss,
    $core.String? sub,
    $core.String? name,
    $core.String? givenName,
    $core.String? familyName,
    $core.String? middleName,
    $core.String? birthdate,
    $core.String? zoneinfo,
    $core.String? profile,
    $core.String? picture,
    $core.String? gender,
    $core.String? locale,
    $core.String? email,
    $core.bool? emailVerified,
    $core.String? phoneNumber,
    $core.bool? phoneNumberVerified,
    $0.Struct? metadata,
    $fixnum.Int64? updatedAt,
    $fixnum.Int64? createdAt,
    $fixnum.Int64? deletedAt,
    $core.Iterable<SourceId>? sources,
  }) {
    final result = create();
    if (iss != null) result.iss = iss;
    if (sub != null) result.sub = sub;
    if (name != null) result.name = name;
    if (givenName != null) result.givenName = givenName;
    if (familyName != null) result.familyName = familyName;
    if (middleName != null) result.middleName = middleName;
    if (birthdate != null) result.birthdate = birthdate;
    if (zoneinfo != null) result.zoneinfo = zoneinfo;
    if (profile != null) result.profile = profile;
    if (picture != null) result.picture = picture;
    if (gender != null) result.gender = gender;
    if (locale != null) result.locale = locale;
    if (email != null) result.email = email;
    if (emailVerified != null) result.emailVerified = emailVerified;
    if (phoneNumber != null) result.phoneNumber = phoneNumber;
    if (phoneNumberVerified != null)
      result.phoneNumberVerified = phoneNumberVerified;
    if (metadata != null) result.metadata = metadata;
    if (updatedAt != null) result.updatedAt = updatedAt;
    if (createdAt != null) result.createdAt = createdAt;
    if (deletedAt != null) result.deletedAt = deletedAt;
    if (sources != null) result.sources.addAll(sources);
    return result;
  }

  Identity._();

  factory Identity.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Identity.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Identity',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'webitel.portal'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'iss')
    ..aOS(2, _omitFieldNames ? '' : 'sub')
    ..aOS(3, _omitFieldNames ? '' : 'name')
    ..aOS(4, _omitFieldNames ? '' : 'givenName')
    ..aOS(5, _omitFieldNames ? '' : 'familyName')
    ..aOS(6, _omitFieldNames ? '' : 'middleName')
    ..aOS(7, _omitFieldNames ? '' : 'birthdate')
    ..aOS(8, _omitFieldNames ? '' : 'zoneinfo')
    ..aOS(9, _omitFieldNames ? '' : 'profile')
    ..aOS(10, _omitFieldNames ? '' : 'picture')
    ..aOS(11, _omitFieldNames ? '' : 'gender')
    ..aOS(12, _omitFieldNames ? '' : 'locale')
    ..aOS(13, _omitFieldNames ? '' : 'email')
    ..aOB(14, _omitFieldNames ? '' : 'emailVerified')
    ..aOS(15, _omitFieldNames ? '' : 'phoneNumber')
    ..aOB(16, _omitFieldNames ? '' : 'phoneNumberVerified')
    ..aOM<$0.Struct>(21, _omitFieldNames ? '' : 'metadata',
        subBuilder: $0.Struct.create)
    ..aInt64(22, _omitFieldNames ? '' : 'updatedAt')
    ..aInt64(23, _omitFieldNames ? '' : 'createdAt')
    ..aInt64(24, _omitFieldNames ? '' : 'deletedAt')
    ..pPM<SourceId>(25, _omitFieldNames ? '' : 'sources',
        subBuilder: SourceId.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Identity clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Identity copyWith(void Function(Identity) updates) =>
      super.copyWith((message) => updates(message as Identity)) as Identity;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Identity create() => Identity._();
  @$core.override
  Identity createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Identity getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Identity>(create);
  static Identity? _defaultInstance;

  /// REQUIRED. Issuer Identifier for the Issuer of the response.
  /// The iss value is a case sensitive URL using the https scheme that contains scheme, host,
  /// and optionally, port number and path components and no query or fragment components.
  @$pb.TagNumber(1)
  $core.String get iss => $_getSZ(0);
  @$pb.TagNumber(1)
  set iss($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasIss() => $_has(0);
  @$pb.TagNumber(1)
  void clearIss() => $_clearField(1);

  /// REQUIRED. Subject Identifier.
  /// A locally unique and never reassigned identifier within the Issuer for the End-User,
  /// which is intended to be consumed by the Client, e.g., 24400320 or AItOawmwtWwcT0k51BayewNvutrJUqsvl6qs7A4.
  /// It MUST NOT exceed 255 ASCII characters in length.
  /// The sub value is a case sensitive string.
  @$pb.TagNumber(2)
  $core.String get sub => $_getSZ(1);
  @$pb.TagNumber(2)
  set sub($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSub() => $_has(1);
  @$pb.TagNumber(2)
  void clearSub() => $_clearField(2);

  /// REQUIRED. End-User's full name in displayable form including all name parts,
  /// possibly including titles and suffixes, ordered according to the End-User's locale and preferences.
  @$pb.TagNumber(3)
  $core.String get name => $_getSZ(2);
  @$pb.TagNumber(3)
  set name($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasName() => $_has(2);
  @$pb.TagNumber(3)
  void clearName() => $_clearField(3);

  /// Given name(s) or first name(s) of the End-User.
  /// Note that in some cultures, people can have multiple given names;
  /// all can be present, with the names being separated by space characters.
  @$pb.TagNumber(4)
  $core.String get givenName => $_getSZ(3);
  @$pb.TagNumber(4)
  set givenName($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasGivenName() => $_has(3);
  @$pb.TagNumber(4)
  void clearGivenName() => $_clearField(4);

  /// Surname(s) or last name(s) of the End-User.
  /// Note that in some cultures, people can have multiple family names or no family name;
  /// all can be present, with the names being separated by space characters.
  @$pb.TagNumber(5)
  $core.String get familyName => $_getSZ(4);
  @$pb.TagNumber(5)
  set familyName($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasFamilyName() => $_has(4);
  @$pb.TagNumber(5)
  void clearFamilyName() => $_clearField(5);

  /// Middle name(s) of the End-User.
  /// Note that in some cultures, people can have multiple middle names;
  /// all can be present, with the names being separated by space characters.
  /// Also note that in some cultures, middle names are not used.
  @$pb.TagNumber(6)
  $core.String get middleName => $_getSZ(5);
  @$pb.TagNumber(6)
  set middleName($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasMiddleName() => $_has(5);
  @$pb.TagNumber(6)
  void clearMiddleName() => $_clearField(6);

  /// OPTIONAL. End-User's birthday, represented as an ISO 8601:2004 [ISO8601‑2004] YYYY-MM-DD format.
  /// The year MAY be 0000, indicating that it is omitted.
  /// To represent only the year, YYYY format is allowed.
  @$pb.TagNumber(7)
  $core.String get birthdate => $_getSZ(6);
  @$pb.TagNumber(7)
  set birthdate($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasBirthdate() => $_has(6);
  @$pb.TagNumber(7)
  void clearBirthdate() => $_clearField(7);

  /// OPTIONAL. String from zoneinfo [zoneinfo] time zone database representing the End-User's time zone.
  /// For example, Europe/Kyiv or America/Los_Angeles.
  @$pb.TagNumber(8)
  $core.String get zoneinfo => $_getSZ(7);
  @$pb.TagNumber(8)
  set zoneinfo($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasZoneinfo() => $_has(7);
  @$pb.TagNumber(8)
  void clearZoneinfo() => $_clearField(8);

  /// OPTIONAL. URL of the End-User's profile page.
  /// The contents of this Web page SHOULD be about the End-User.
  /// NOTE: Issuer SP (IdP) related URL.
  @$pb.TagNumber(9)
  $core.String get profile => $_getSZ(8);
  @$pb.TagNumber(9)
  set profile($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasProfile() => $_has(8);
  @$pb.TagNumber(9)
  void clearProfile() => $_clearField(9);

  /// OPTIONAL. URL of the End-User's profile picture.
  /// This URL MUST refer to an image file
  /// (for example, a PNG, JPEG, or GIF image file),
  /// rather than to a Web page containing an image.
  @$pb.TagNumber(10)
  $core.String get picture => $_getSZ(9);
  @$pb.TagNumber(10)
  set picture($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasPicture() => $_has(9);
  @$pb.TagNumber(10)
  void clearPicture() => $_clearField(10);

  /// OPTIONAL. End-User's gender.
  /// Values defined by this specification are `female` and `male`.
  /// Other values MAY be used when neither of the defined values are applicable.
  @$pb.TagNumber(11)
  $core.String get gender => $_getSZ(10);
  @$pb.TagNumber(11)
  set gender($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasGender() => $_has(10);
  @$pb.TagNumber(11)
  void clearGender() => $_clearField(11);

  /// End-User's locale, represented as a BCP47 [RFC5646] language tag.
  /// This is typically an ISO 639-1 Alpha-2 [ISO639‑1] language code in lowercase
  /// and an ISO 3166-1 Alpha-2 [ISO3166‑1] country code in uppercase,
  /// separated by a dash. For example, `en-US` or `uk-UA`.
  @$pb.TagNumber(12)
  $core.String get locale => $_getSZ(11);
  @$pb.TagNumber(12)
  set locale($core.String value) => $_setString(11, value);
  @$pb.TagNumber(12)
  $core.bool hasLocale() => $_has(11);
  @$pb.TagNumber(12)
  void clearLocale() => $_clearField(12);

  /// End-User's preferred e-mail address.
  /// Its value MUST conform to the RFC 5322 [RFC5322] addr-spec syntax.
  /// The RP MUST NOT rely upon this value being unique, as discussed in Section 5.7.
  @$pb.TagNumber(13)
  $core.String get email => $_getSZ(12);
  @$pb.TagNumber(13)
  set email($core.String value) => $_setString(12, value);
  @$pb.TagNumber(13)
  $core.bool hasEmail() => $_has(12);
  @$pb.TagNumber(13)
  void clearEmail() => $_clearField(13);

  /// True if the End-User's e-mail address has been verified; otherwise false.
  @$pb.TagNumber(14)
  $core.bool get emailVerified => $_getBF(13);
  @$pb.TagNumber(14)
  set emailVerified($core.bool value) => $_setBool(13, value);
  @$pb.TagNumber(14)
  $core.bool hasEmailVerified() => $_has(13);
  @$pb.TagNumber(14)
  void clearEmailVerified() => $_clearField(14);

  /// End-User's preferred telephone number.
  /// E.164 is RECOMMENDED as the format of this Claim, for example, +1 (425) 555-1212 or +56 (2) 687 2400.
  /// If the phone number contains an extension, it is RECOMMENDED that
  /// the extension be represented using the RFC 3966 [RFC3966] extension syntax, for example, +1 (604) 555-1234;ext=5678.
  @$pb.TagNumber(15)
  $core.String get phoneNumber => $_getSZ(14);
  @$pb.TagNumber(15)
  set phoneNumber($core.String value) => $_setString(14, value);
  @$pb.TagNumber(15)
  $core.bool hasPhoneNumber() => $_has(14);
  @$pb.TagNumber(15)
  void clearPhoneNumber() => $_clearField(15);

  /// True if the End-User's phone number has been verified; otherwise false.
  @$pb.TagNumber(16)
  $core.bool get phoneNumberVerified => $_getBF(15);
  @$pb.TagNumber(16)
  set phoneNumberVerified($core.bool value) => $_setBool(15, value);
  @$pb.TagNumber(16)
  $core.bool hasPhoneNumberVerified() => $_has(15);
  @$pb.TagNumber(16)
  void clearPhoneNumberVerified() => $_clearField(16);

  /// End-User's extra attributes metadata.
  @$pb.TagNumber(21)
  $0.Struct get metadata => $_getN(16);
  @$pb.TagNumber(21)
  set metadata($0.Struct value) => $_setField(21, value);
  @$pb.TagNumber(21)
  $core.bool hasMetadata() => $_has(16);
  @$pb.TagNumber(21)
  void clearMetadata() => $_clearField(21);
  @$pb.TagNumber(21)
  $0.Struct ensureMetadata() => $_ensure(16);

  /// Time the End-User's information was last updated.
  /// Its value is a JSON number representing the number of seconds from 1970-01-01T0:0:0Z as measured in UTC until the date/time.
  @$pb.TagNumber(22)
  $fixnum.Int64 get updatedAt => $_getI64(17);
  @$pb.TagNumber(22)
  set updatedAt($fixnum.Int64 value) => $_setInt64(17, value);
  @$pb.TagNumber(22)
  $core.bool hasUpdatedAt() => $_has(17);
  @$pb.TagNumber(22)
  void clearUpdatedAt() => $_clearField(22);

  @$pb.TagNumber(23)
  $fixnum.Int64 get createdAt => $_getI64(18);
  @$pb.TagNumber(23)
  set createdAt($fixnum.Int64 value) => $_setInt64(18, value);
  @$pb.TagNumber(23)
  $core.bool hasCreatedAt() => $_has(18);
  @$pb.TagNumber(23)
  void clearCreatedAt() => $_clearField(23);

  @$pb.TagNumber(24)
  $fixnum.Int64 get deletedAt => $_getI64(19);
  @$pb.TagNumber(24)
  set deletedAt($fixnum.Int64 value) => $_setInt64(19, value);
  @$pb.TagNumber(24)
  $core.bool hasDeletedAt() => $_has(19);
  @$pb.TagNumber(24)
  void clearDeletedAt() => $_clearField(24);

  /// Additional source(s) associated with given "identity".
  /// Used to merge two or more well-known end-user subjects.
  @$pb.TagNumber(25)
  $pb.PbList<SourceId> get sources => $_getList(20);
}

/// End-User Owner Profile.
class UserProfile extends $pb.GeneratedMessage {
  factory UserProfile({
    $core.String? id,
    $core.String? username,
    Identity? identity,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (username != null) result.username = username;
    if (identity != null) result.identity = identity;
    return result;
  }

  UserProfile._();

  factory UserProfile.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UserProfile.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UserProfile',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'webitel.portal'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'username')
    ..aOM<Identity>(3, _omitFieldNames ? '' : 'identity',
        subBuilder: Identity.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserProfile clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserProfile copyWith(void Function(UserProfile) updates) =>
      super.copyWith((message) => updates(message as UserProfile))
          as UserProfile;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UserProfile create() => UserProfile._();
  @$core.override
  UserProfile createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static UserProfile getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UserProfile>(create);
  static UserProfile? _defaultInstance;

  /// READONLY. profile.id
  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  /// OPTIONAL.
  /// Shorthand name by which the End-User
  /// wishes to be referred to at the RP,
  /// such as janedoe or j.doe.
  @$pb.TagNumber(2)
  $core.String get username => $_getSZ(1);
  @$pb.TagNumber(2)
  set username($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasUsername() => $_has(1);
  @$pb.TagNumber(2)
  void clearUsername() => $_clearField(2);

  /// READONLY. End-User profile info.
  @$pb.TagNumber(3)
  Identity get identity => $_getN(2);
  @$pb.TagNumber(3)
  set identity(Identity value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasIdentity() => $_has(2);
  @$pb.TagNumber(3)
  void clearIdentity() => $_clearField(3);
  @$pb.TagNumber(3)
  Identity ensureIdentity() => $_ensure(2);
}

/// Portal Service VoIP/SIP Account
class CallAccount extends $pb.GeneratedMessage {
  factory CallAccount({
    $core.String? proxy,
    $core.String? realm,
    $core.String? userId,
    $core.String? authId,
    $core.String? secret,
    $core.bool? video,
  }) {
    final result = create();
    if (proxy != null) result.proxy = proxy;
    if (realm != null) result.realm = realm;
    if (userId != null) result.userId = userId;
    if (authId != null) result.authId = authId;
    if (secret != null) result.secret = secret;
    if (video != null) result.video = video;
    return result;
  }

  CallAccount._();

  factory CallAccount.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CallAccount.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CallAccount',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'webitel.portal'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'proxy')
    ..aOS(2, _omitFieldNames ? '' : 'realm')
    ..aOS(3, _omitFieldNames ? '' : 'userId')
    ..aOS(4, _omitFieldNames ? '' : 'authId')
    ..aOS(5, _omitFieldNames ? '' : 'secret')
    ..aOB(6, _omitFieldNames ? '' : 'video')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CallAccount clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CallAccount copyWith(void Function(CallAccount) updates) =>
      super.copyWith((message) => updates(message as CallAccount))
          as CallAccount;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CallAccount create() => CallAccount._();
  @$core.override
  CallAccount createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static CallAccount getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CallAccount>(create);
  static CallAccount? _defaultInstance;

  /// SIP host / proxy
  @$pb.TagNumber(1)
  $core.String get proxy => $_getSZ(0);
  @$pb.TagNumber(1)
  set proxy($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasProxy() => $_has(0);
  @$pb.TagNumber(1)
  void clearProxy() => $_clearField(1);

  /// SIP realm / domain
  @$pb.TagNumber(2)
  $core.String get realm => $_getSZ(1);
  @$pb.TagNumber(2)
  set realm($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasRealm() => $_has(1);
  @$pb.TagNumber(2)
  void clearRealm() => $_clearField(2);

  /// SIP username; extension
  @$pb.TagNumber(3)
  $core.String get userId => $_getSZ(2);
  @$pb.TagNumber(3)
  set userId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasUserId() => $_has(2);
  @$pb.TagNumber(3)
  void clearUserId() => $_clearField(3);

  /// SIP authorization
  @$pb.TagNumber(4)
  $core.String get authId => $_getSZ(3);
  @$pb.TagNumber(4)
  set authId($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasAuthId() => $_has(3);
  @$pb.TagNumber(4)
  void clearAuthId() => $_clearField(4);

  /// SIP password
  @$pb.TagNumber(5)
  $core.String get secret => $_getSZ(4);
  @$pb.TagNumber(5)
  set secret($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasSecret() => $_has(4);
  @$pb.TagNumber(5)
  void clearSecret() => $_clearField(5);

  /// Video is allowed ?
  @$pb.TagNumber(6)
  $core.bool get video => $_getBF(5);
  @$pb.TagNumber(6)
  set video($core.bool value) => $_setBool(5, value);
  @$pb.TagNumber(6)
  $core.bool hasVideo() => $_has(5);
  @$pb.TagNumber(6)
  void clearVideo() => $_clearField(6);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
