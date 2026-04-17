// This is a generated file - do not edit.
//
// Generated from portal/auth.proto.

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

@$core.Deprecated('Use tokenRequestDescriptor instead')
const TokenRequest$json = {
  '1': 'TokenRequest',
  '2': [
    {'1': 'state', '3': 1, '4': 1, '5': 9, '10': 'state'},
    {'1': 'scope', '3': 2, '4': 3, '5': 9, '10': 'scope'},
    {'1': 'app_token', '3': 3, '4': 1, '5': 9, '10': 'appToken'},
    {'1': 'grant_type', '3': 4, '4': 1, '5': 9, '10': 'grantType'},
    {'1': 'response_type', '3': 5, '4': 3, '5': 9, '10': 'responseType'},
    {'1': 'refresh_token', '3': 11, '4': 1, '5': 9, '10': 'refreshToken'},
    {
      '1': 'identity',
      '3': 12,
      '4': 1,
      '5': 11,
      '6': '.webitel.portal.Identity',
      '10': 'identity'
    },
    {'1': 'code', '3': 13, '4': 1, '5': 9, '10': 'code'},
    {
      '1': 'push',
      '3': 21,
      '4': 1,
      '5': 11,
      '6': '.webitel.portal.DevicePush',
      '10': 'push'
    },
  ],
};

/// Descriptor for `TokenRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List tokenRequestDescriptor = $convert.base64Decode(
    'CgxUb2tlblJlcXVlc3QSFAoFc3RhdGUYASABKAlSBXN0YXRlEhQKBXNjb3BlGAIgAygJUgVzY2'
    '9wZRIbCglhcHBfdG9rZW4YAyABKAlSCGFwcFRva2VuEh0KCmdyYW50X3R5cGUYBCABKAlSCWdy'
    'YW50VHlwZRIjCg1yZXNwb25zZV90eXBlGAUgAygJUgxyZXNwb25zZVR5cGUSIwoNcmVmcmVzaF'
    '90b2tlbhgLIAEoCVIMcmVmcmVzaFRva2VuEjQKCGlkZW50aXR5GAwgASgLMhgud2ViaXRlbC5w'
    'b3J0YWwuSWRlbnRpdHlSCGlkZW50aXR5EhIKBGNvZGUYDSABKAlSBGNvZGUSLgoEcHVzaBgVIA'
    'EoCzIaLndlYml0ZWwucG9ydGFsLkRldmljZVB1c2hSBHB1c2g=');

@$core.Deprecated('Use accessTokenDescriptor instead')
const AccessToken$json = {
  '1': 'AccessToken',
  '2': [
    {'1': 'expires_in', '3': 1, '4': 1, '5': 5, '10': 'expiresIn'},
    {'1': 'token_type', '3': 2, '4': 1, '5': 9, '10': 'tokenType'},
    {'1': 'access_token', '3': 3, '4': 1, '5': 9, '10': 'accessToken'},
    {'1': 'refresh_token', '3': 4, '4': 1, '5': 9, '10': 'refreshToken'},
    {'1': 'scope', '3': 5, '4': 3, '5': 9, '10': 'scope'},
    {'1': 'state', '3': 6, '4': 1, '5': 9, '10': 'state'},
    {
      '1': 'user',
      '3': 21,
      '4': 1,
      '5': 11,
      '6': '.webitel.portal.UserProfile',
      '10': 'user'
    },
    {
      '1': 'call',
      '3': 22,
      '4': 1,
      '5': 11,
      '6': '.webitel.portal.CallAccount',
      '10': 'call'
    },
    {
      '1': 'chat',
      '3': 23,
      '4': 1,
      '5': 11,
      '6': '.webitel.portal.ChatAccount',
      '10': 'chat'
    },
  ],
};

/// Descriptor for `AccessToken`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List accessTokenDescriptor = $convert.base64Decode(
    'CgtBY2Nlc3NUb2tlbhIdCgpleHBpcmVzX2luGAEgASgFUglleHBpcmVzSW4SHQoKdG9rZW5fdH'
    'lwZRgCIAEoCVIJdG9rZW5UeXBlEiEKDGFjY2Vzc190b2tlbhgDIAEoCVILYWNjZXNzVG9rZW4S'
    'IwoNcmVmcmVzaF90b2tlbhgEIAEoCVIMcmVmcmVzaFRva2VuEhQKBXNjb3BlGAUgAygJUgVzY2'
    '9wZRIUCgVzdGF0ZRgGIAEoCVIFc3RhdGUSLwoEdXNlchgVIAEoCzIbLndlYml0ZWwucG9ydGFs'
    'LlVzZXJQcm9maWxlUgR1c2VyEi8KBGNhbGwYFiABKAsyGy53ZWJpdGVsLnBvcnRhbC5DYWxsQW'
    'Njb3VudFIEY2FsbBIvCgRjaGF0GBcgASgLMhsud2ViaXRlbC5wb3J0YWwuQ2hhdEFjY291bnRS'
    'BGNoYXQ=');
