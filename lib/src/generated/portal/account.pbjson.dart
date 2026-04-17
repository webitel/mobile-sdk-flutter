// This is a generated file - do not edit.
//
// Generated from portal/account.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports
// ignore_for_file: unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use sourceIdDescriptor instead')
const SourceId$json = {
  '1': 'SourceId',
  '2': [
    {'1': 'iss', '3': 1, '4': 1, '5': 9, '10': 'iss'},
    {'1': 'sub', '3': 2, '4': 1, '5': 9, '10': 'sub'},
  ],
};

/// Descriptor for `SourceId`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sourceIdDescriptor = $convert.base64Decode(
    'CghTb3VyY2VJZBIQCgNpc3MYASABKAlSA2lzcxIQCgNzdWIYAiABKAlSA3N1Yg==');

@$core.Deprecated('Use identityDescriptor instead')
const Identity$json = {
  '1': 'Identity',
  '2': [
    {'1': 'iss', '3': 1, '4': 1, '5': 9, '10': 'iss'},
    {'1': 'sub', '3': 2, '4': 1, '5': 9, '10': 'sub'},
    {'1': 'name', '3': 3, '4': 1, '5': 9, '10': 'name'},
    {'1': 'given_name', '3': 4, '4': 1, '5': 9, '10': 'givenName'},
    {'1': 'family_name', '3': 5, '4': 1, '5': 9, '10': 'familyName'},
    {'1': 'middle_name', '3': 6, '4': 1, '5': 9, '10': 'middleName'},
    {'1': 'birthdate', '3': 7, '4': 1, '5': 9, '10': 'birthdate'},
    {'1': 'zoneinfo', '3': 8, '4': 1, '5': 9, '10': 'zoneinfo'},
    {'1': 'profile', '3': 9, '4': 1, '5': 9, '10': 'profile'},
    {'1': 'picture', '3': 10, '4': 1, '5': 9, '10': 'picture'},
    {'1': 'gender', '3': 11, '4': 1, '5': 9, '10': 'gender'},
    {'1': 'locale', '3': 12, '4': 1, '5': 9, '10': 'locale'},
    {'1': 'email', '3': 13, '4': 1, '5': 9, '10': 'email'},
    {'1': 'email_verified', '3': 14, '4': 1, '5': 8, '10': 'emailVerified'},
    {'1': 'phone_number', '3': 15, '4': 1, '5': 9, '10': 'phoneNumber'},
    {
      '1': 'phone_number_verified',
      '3': 16,
      '4': 1,
      '5': 8,
      '10': 'phoneNumberVerified'
    },
    {
      '1': 'metadata',
      '3': 21,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Struct',
      '10': 'metadata'
    },
    {
      '1': 'sources',
      '3': 25,
      '4': 3,
      '5': 11,
      '6': '.webitel.portal.SourceId',
      '10': 'sources'
    },
    {'1': 'updated_at', '3': 22, '4': 1, '5': 3, '10': 'updatedAt'},
    {'1': 'created_at', '3': 23, '4': 1, '5': 3, '10': 'createdAt'},
    {'1': 'deleted_at', '3': 24, '4': 1, '5': 3, '10': 'deletedAt'},
  ],
};

/// Descriptor for `Identity`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List identityDescriptor = $convert.base64Decode(
    'CghJZGVudGl0eRIQCgNpc3MYASABKAlSA2lzcxIQCgNzdWIYAiABKAlSA3N1YhISCgRuYW1lGA'
    'MgASgJUgRuYW1lEh0KCmdpdmVuX25hbWUYBCABKAlSCWdpdmVuTmFtZRIfCgtmYW1pbHlfbmFt'
    'ZRgFIAEoCVIKZmFtaWx5TmFtZRIfCgttaWRkbGVfbmFtZRgGIAEoCVIKbWlkZGxlTmFtZRIcCg'
    'liaXJ0aGRhdGUYByABKAlSCWJpcnRoZGF0ZRIaCgh6b25laW5mbxgIIAEoCVIIem9uZWluZm8S'
    'GAoHcHJvZmlsZRgJIAEoCVIHcHJvZmlsZRIYCgdwaWN0dXJlGAogASgJUgdwaWN0dXJlEhYKBm'
    'dlbmRlchgLIAEoCVIGZ2VuZGVyEhYKBmxvY2FsZRgMIAEoCVIGbG9jYWxlEhQKBWVtYWlsGA0g'
    'ASgJUgVlbWFpbBIlCg5lbWFpbF92ZXJpZmllZBgOIAEoCFINZW1haWxWZXJpZmllZBIhCgxwaG'
    '9uZV9udW1iZXIYDyABKAlSC3Bob25lTnVtYmVyEjIKFXBob25lX251bWJlcl92ZXJpZmllZBgQ'
    'IAEoCFITcGhvbmVOdW1iZXJWZXJpZmllZBIzCghtZXRhZGF0YRgVIAEoCzIXLmdvb2dsZS5wcm'
    '90b2J1Zi5TdHJ1Y3RSCG1ldGFkYXRhEjIKB3NvdXJjZXMYGSADKAsyGC53ZWJpdGVsLnBvcnRh'
    'bC5Tb3VyY2VJZFIHc291cmNlcxIdCgp1cGRhdGVkX2F0GBYgASgDUgl1cGRhdGVkQXQSHQoKY3'
    'JlYXRlZF9hdBgXIAEoA1IJY3JlYXRlZEF0Eh0KCmRlbGV0ZWRfYXQYGCABKANSCWRlbGV0ZWRB'
    'dA==');

@$core.Deprecated('Use userProfileDescriptor instead')
const UserProfile$json = {
  '1': 'UserProfile',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'username', '3': 2, '4': 1, '5': 9, '10': 'username'},
    {
      '1': 'identity',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.webitel.portal.Identity',
      '10': 'identity'
    },
  ],
  '9': [
    {'1': 4, '2': 5},
  ],
};

/// Descriptor for `UserProfile`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userProfileDescriptor = $convert.base64Decode(
    'CgtVc2VyUHJvZmlsZRIOCgJpZBgBIAEoCVICaWQSGgoIdXNlcm5hbWUYAiABKAlSCHVzZXJuYW'
    '1lEjQKCGlkZW50aXR5GAMgASgLMhgud2ViaXRlbC5wb3J0YWwuSWRlbnRpdHlSCGlkZW50aXR5'
    'SgQIBBAF');

@$core.Deprecated('Use callAccountDescriptor instead')
const CallAccount$json = {
  '1': 'CallAccount',
  '2': [
    {'1': 'proxy', '3': 1, '4': 1, '5': 9, '10': 'proxy'},
    {'1': 'realm', '3': 2, '4': 1, '5': 9, '10': 'realm'},
    {'1': 'user_id', '3': 3, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'auth_id', '3': 4, '4': 1, '5': 9, '10': 'authId'},
    {'1': 'secret', '3': 5, '4': 1, '5': 9, '10': 'secret'},
    {'1': 'video', '3': 6, '4': 1, '5': 8, '10': 'video'},
  ],
};

/// Descriptor for `CallAccount`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List callAccountDescriptor = $convert.base64Decode(
    'CgtDYWxsQWNjb3VudBIUCgVwcm94eRgBIAEoCVIFcHJveHkSFAoFcmVhbG0YAiABKAlSBXJlYW'
    'xtEhcKB3VzZXJfaWQYAyABKAlSBnVzZXJJZBIXCgdhdXRoX2lkGAQgASgJUgZhdXRoSWQSFgoG'
    'c2VjcmV0GAUgASgJUgZzZWNyZXQSFAoFdmlkZW8YBiABKAhSBXZpZGVv');
