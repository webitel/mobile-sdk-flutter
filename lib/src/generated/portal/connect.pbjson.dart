// This is a generated file - do not edit.
//
// Generated from portal/connect.proto.

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

@$core.Deprecated('Use updateDescriptor instead')
const Update$json = {
  '1': 'Update',
  '2': [
    {'1': 'date', '3': 1, '4': 1, '5': 3, '10': 'date'},
    {
      '1': 'data',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Any',
      '10': 'data'
    },
  ],
};

/// Descriptor for `Update`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateDescriptor = $convert.base64Decode(
    'CgZVcGRhdGUSEgoEZGF0ZRgBIAEoA1IEZGF0ZRIoCgRkYXRhGAMgASgLMhQuZ29vZ2xlLnByb3'
    'RvYnVmLkFueVIEZGF0YQ==');

@$core.Deprecated('Use requestDescriptor instead')
const Request$json = {
  '1': 'Request',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'path', '3': 2, '4': 1, '5': 9, '10': 'path'},
    {
      '1': 'meta',
      '3': 4,
      '4': 3,
      '5': 11,
      '6': '.webitel.portal.Request.MetaEntry',
      '10': 'meta'
    },
    {
      '1': 'data',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Any',
      '10': 'data'
    },
  ],
  '3': [Request_MetaEntry$json],
};

@$core.Deprecated('Use requestDescriptor instead')
const Request_MetaEntry$json = {
  '1': 'MetaEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `Request`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List requestDescriptor = $convert.base64Decode(
    'CgdSZXF1ZXN0Eg4KAmlkGAEgASgJUgJpZBISCgRwYXRoGAIgASgJUgRwYXRoEjUKBG1ldGEYBC'
    'ADKAsyIS53ZWJpdGVsLnBvcnRhbC5SZXF1ZXN0Lk1ldGFFbnRyeVIEbWV0YRIoCgRkYXRhGAMg'
    'ASgLMhQuZ29vZ2xlLnByb3RvYnVmLkFueVIEZGF0YRo3CglNZXRhRW50cnkSEAoDa2V5GAEgAS'
    'gJUgNrZXkSFAoFdmFsdWUYAiABKAlSBXZhbHVlOgI4AQ==');

@$core.Deprecated('Use responseDescriptor instead')
const Response$json = {
  '1': 'Response',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {
      '1': 'meta',
      '3': 4,
      '4': 3,
      '5': 11,
      '6': '.webitel.portal.Response.MetaEntry',
      '10': 'meta'
    },
    {
      '1': 'data',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Any',
      '10': 'data'
    },
    {
      '1': 'err',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.rpc.Status',
      '10': 'err'
    },
  ],
  '3': [Response_MetaEntry$json],
};

@$core.Deprecated('Use responseDescriptor instead')
const Response_MetaEntry$json = {
  '1': 'MetaEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `Response`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List responseDescriptor = $convert.base64Decode(
    'CghSZXNwb25zZRIOCgJpZBgBIAEoCVICaWQSNgoEbWV0YRgEIAMoCzIiLndlYml0ZWwucG9ydG'
    'FsLlJlc3BvbnNlLk1ldGFFbnRyeVIEbWV0YRIoCgRkYXRhGAMgASgLMhQuZ29vZ2xlLnByb3Rv'
    'YnVmLkFueVIEZGF0YRIkCgNlcnIYAiABKAsyEi5nb29nbGUucnBjLlN0YXR1c1IDZXJyGjcKCU'
    '1ldGFFbnRyeRIQCgNrZXkYASABKAlSA2tleRIUCgV2YWx1ZRgCIAEoCVIFdmFsdWU6AjgB');

@$core.Deprecated('Use echoDescriptor instead')
const Echo$json = {
  '1': 'Echo',
  '2': [
    {'1': 'data', '3': 1, '4': 1, '5': 12, '10': 'data'},
  ],
};

/// Descriptor for `Echo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List echoDescriptor =
    $convert.base64Decode('CgRFY2hvEhIKBGRhdGEYASABKAxSBGRhdGE=');

@$core.Deprecated('Use updateDisconnectDescriptor instead')
const UpdateDisconnect$json = {
  '1': 'UpdateDisconnect',
  '2': [
    {
      '1': 'cause',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.google.rpc.Status',
      '10': 'cause'
    },
  ],
};

/// Descriptor for `UpdateDisconnect`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateDisconnectDescriptor = $convert.base64Decode(
    'ChBVcGRhdGVEaXNjb25uZWN0EigKBWNhdXNlGAEgASgLMhIuZ29vZ2xlLnJwYy5TdGF0dXNSBW'
    'NhdXNl');
