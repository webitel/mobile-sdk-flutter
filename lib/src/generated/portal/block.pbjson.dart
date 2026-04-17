// This is a generated file - do not edit.
//
// Generated from portal/block.proto.

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

@$core.Deprecated('Use blockDescriptor instead')
const Block$json = {
  '1': 'Block',
  '2': [
    {
      '1': 'status',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.google.rpc.Status',
      '10': 'status'
    },
    {'1': 'updated_at', '3': 2, '4': 1, '5': 3, '10': 'updatedAt'},
    {
      '1': 'updated_by',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.webitel.portal.Lookup',
      '10': 'updatedBy'
    },
  ],
};

/// Descriptor for `Block`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List blockDescriptor = $convert.base64Decode(
    'CgVCbG9jaxIqCgZzdGF0dXMYASABKAsyEi5nb29nbGUucnBjLlN0YXR1c1IGc3RhdHVzEh0KCn'
    'VwZGF0ZWRfYXQYAiABKANSCXVwZGF0ZWRBdBI1Cgp1cGRhdGVkX2J5GAMgASgLMhYud2ViaXRl'
    'bC5wb3J0YWwuTG9va3VwUgl1cGRhdGVkQnk=');
