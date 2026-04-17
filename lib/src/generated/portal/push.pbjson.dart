// This is a generated file - do not edit.
//
// Generated from portal/push.proto.

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

@$core.Deprecated('Use devicePushDescriptor instead')
const DevicePush$json = {
  '1': 'DevicePush',
  '2': [
    {'1': 'FCM', '3': 1, '4': 1, '5': 9, '9': 0, '10': 'FCM'},
    {'1': 'APN', '3': 2, '4': 1, '5': 9, '9': 0, '10': 'APN'},
    {
      '1': 'web',
      '3': 10,
      '4': 1,
      '5': 11,
      '6': '.webitel.portal.WebPush',
      '9': 0,
      '10': 'web'
    },
    {'1': 'secret', '3': 20, '4': 1, '5': 9, '10': 'secret'},
  ],
  '8': [
    {'1': 'token'},
  ],
};

/// Descriptor for `DevicePush`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List devicePushDescriptor = $convert.base64Decode(
    'CgpEZXZpY2VQdXNoEhIKA0ZDTRgBIAEoCUgAUgNGQ00SEgoDQVBOGAIgASgJSABSA0FQThIrCg'
    'N3ZWIYCiABKAsyFy53ZWJpdGVsLnBvcnRhbC5XZWJQdXNoSABSA3dlYhIWCgZzZWNyZXQYFCAB'
    'KAlSBnNlY3JldEIHCgV0b2tlbg==');

@$core.Deprecated('Use webPushDescriptor instead')
const WebPush$json = {
  '1': 'WebPush',
  '2': [
    {'1': 'endpoint', '3': 1, '4': 1, '5': 9, '10': 'endpoint'},
    {
      '1': 'key',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.webitel.portal.WebPush.Key',
      '10': 'key'
    },
  ],
  '3': [WebPush_Key$json],
};

@$core.Deprecated('Use webPushDescriptor instead')
const WebPush_Key$json = {
  '1': 'Key',
  '2': [
    {'1': 'auth', '3': 1, '4': 1, '5': 12, '10': 'auth'},
    {'1': 'p256dh', '3': 2, '4': 1, '5': 12, '10': 'p256dh'},
  ],
};

/// Descriptor for `WebPush`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List webPushDescriptor = $convert.base64Decode(
    'CgdXZWJQdXNoEhoKCGVuZHBvaW50GAEgASgJUghlbmRwb2ludBItCgNrZXkYAiABKAsyGy53ZW'
    'JpdGVsLnBvcnRhbC5XZWJQdXNoLktleVIDa2V5GjEKA0tleRISCgRhdXRoGAEgASgMUgRhdXRo'
    'EhYKBnAyNTZkaBgCIAEoDFIGcDI1NmRo');
