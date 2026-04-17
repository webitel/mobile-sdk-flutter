// This is a generated file - do not edit.
//
// Generated from portal/media.proto.

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

@$core.Deprecated('Use inputFileDescriptor instead')
const InputFile$json = {
  '1': 'InputFile',
  '2': [
    {'1': 'type', '3': 4, '4': 1, '5': 9, '10': 'type'},
    {'1': 'name', '3': 5, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `InputFile`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List inputFileDescriptor = $convert.base64Decode(
    'CglJbnB1dEZpbGUSEgoEdHlwZRgEIAEoCVIEdHlwZRISCgRuYW1lGAUgASgJUgRuYW1l');

@$core.Deprecated('Use uploadRequestDescriptor instead')
const UploadRequest$json = {
  '1': 'UploadRequest',
  '2': [
    {'1': 'pid', '3': 1, '4': 1, '5': 9, '9': 0, '10': 'pid'},
    {
      '1': 'new',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.webitel.portal.UploadRequest.Start',
      '9': 0,
      '10': 'new'
    },
    {'1': 'part', '3': 3, '4': 1, '5': 12, '9': 0, '10': 'part'},
    {
      '1': 'kill',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.webitel.portal.UploadRequest.Abort',
      '9': 0,
      '10': 'kill'
    },
  ],
  '3': [UploadRequest_Start$json, UploadRequest_Abort$json],
  '8': [
    {'1': 'data'},
  ],
};

@$core.Deprecated('Use uploadRequestDescriptor instead')
const UploadRequest_Start$json = {
  '1': 'Start',
  '2': [
    {
      '1': 'file',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.webitel.portal.InputFile',
      '10': 'file'
    },
    {'1': 'progress', '3': 2, '4': 1, '5': 8, '10': 'progress'},
  ],
};

@$core.Deprecated('Use uploadRequestDescriptor instead')
const UploadRequest_Abort$json = {
  '1': 'Abort',
};

/// Descriptor for `UploadRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List uploadRequestDescriptor = $convert.base64Decode(
    'Cg1VcGxvYWRSZXF1ZXN0EhIKA3BpZBgBIAEoCUgAUgNwaWQSNwoDbmV3GAIgASgLMiMud2ViaX'
    'RlbC5wb3J0YWwuVXBsb2FkUmVxdWVzdC5TdGFydEgAUgNuZXcSFAoEcGFydBgDIAEoDEgAUgRw'
    'YXJ0EjkKBGtpbGwYBCABKAsyIy53ZWJpdGVsLnBvcnRhbC5VcGxvYWRSZXF1ZXN0LkFib3J0SA'
    'BSBGtpbGwaUgoFU3RhcnQSLQoEZmlsZRgBIAEoCzIZLndlYml0ZWwucG9ydGFsLklucHV0Rmls'
    'ZVIEZmlsZRIaCghwcm9ncmVzcxgCIAEoCFIIcHJvZ3Jlc3MaBwoFQWJvcnRCBgoEZGF0YQ==');

@$core.Deprecated('Use uploadProgressDescriptor instead')
const UploadProgress$json = {
  '1': 'UploadProgress',
  '2': [
    {
      '1': 'part',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.webitel.portal.UploadProgress.Partial',
      '9': 0,
      '10': 'part'
    },
    {
      '1': 'stat',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.webitel.portal.UploadProgress.Complete',
      '9': 0,
      '10': 'stat'
    },
    {
      '1': 'end',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.webitel.portal.UpdateDisconnect',
      '9': 0,
      '10': 'end'
    },
  ],
  '3': [UploadProgress_Partial$json, UploadProgress_Complete$json],
  '8': [
    {'1': 'data'},
  ],
};

@$core.Deprecated('Use uploadProgressDescriptor instead')
const UploadProgress_Partial$json = {
  '1': 'Partial',
  '2': [
    {'1': 'pid', '3': 1, '4': 1, '5': 9, '10': 'pid'},
    {'1': 'size', '3': 2, '4': 1, '5': 3, '10': 'size'},
  ],
};

@$core.Deprecated('Use uploadProgressDescriptor instead')
const UploadProgress_Complete$json = {
  '1': 'Complete',
  '2': [
    {
      '1': 'file',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.webitel.chat.File',
      '10': 'file'
    },
    {
      '1': 'hash',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.webitel.portal.UploadProgress.Complete.HashEntry',
      '10': 'hash'
    },
  ],
  '3': [UploadProgress_Complete_HashEntry$json],
};

@$core.Deprecated('Use uploadProgressDescriptor instead')
const UploadProgress_Complete_HashEntry$json = {
  '1': 'HashEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `UploadProgress`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List uploadProgressDescriptor = $convert.base64Decode(
    'Cg5VcGxvYWRQcm9ncmVzcxI8CgRwYXJ0GAEgASgLMiYud2ViaXRlbC5wb3J0YWwuVXBsb2FkUH'
    'JvZ3Jlc3MuUGFydGlhbEgAUgRwYXJ0Ej0KBHN0YXQYAiABKAsyJy53ZWJpdGVsLnBvcnRhbC5V'
    'cGxvYWRQcm9ncmVzcy5Db21wbGV0ZUgAUgRzdGF0EjQKA2VuZBgDIAEoCzIgLndlYml0ZWwucG'
    '9ydGFsLlVwZGF0ZURpc2Nvbm5lY3RIAFIDZW5kGi8KB1BhcnRpYWwSEAoDcGlkGAEgASgJUgNw'
    'aWQSEgoEc2l6ZRgCIAEoA1IEc2l6ZRqyAQoIQ29tcGxldGUSJgoEZmlsZRgBIAEoCzISLndlYm'
    'l0ZWwuY2hhdC5GaWxlUgRmaWxlEkUKBGhhc2gYAiADKAsyMS53ZWJpdGVsLnBvcnRhbC5VcGxv'
    'YWRQcm9ncmVzcy5Db21wbGV0ZS5IYXNoRW50cnlSBGhhc2gaNwoJSGFzaEVudHJ5EhAKA2tleR'
    'gBIAEoCVIDa2V5EhQKBXZhbHVlGAIgASgJUgV2YWx1ZToCOAFCBgoEZGF0YQ==');

@$core.Deprecated('Use uploadMediaDescriptor instead')
const UploadMedia$json = {
  '1': 'UploadMedia',
  '2': [
    {
      '1': 'file',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.webitel.portal.InputFile',
      '9': 0,
      '10': 'file'
    },
    {'1': 'data', '3': 2, '4': 1, '5': 12, '9': 0, '10': 'data'},
  ],
  '8': [
    {'1': 'media_type'},
  ],
};

/// Descriptor for `UploadMedia`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List uploadMediaDescriptor = $convert.base64Decode(
    'CgtVcGxvYWRNZWRpYRIvCgRmaWxlGAEgASgLMhkud2ViaXRlbC5wb3J0YWwuSW5wdXRGaWxlSA'
    'BSBGZpbGUSFAoEZGF0YRgCIAEoDEgAUgRkYXRhQgwKCm1lZGlhX3R5cGU=');

@$core.Deprecated('Use getFileRequestDescriptor instead')
const GetFileRequest$json = {
  '1': 'GetFileRequest',
  '2': [
    {'1': 'file_id', '3': 1, '4': 1, '5': 9, '10': 'fileId'},
    {'1': 'offset', '3': 2, '4': 1, '5': 3, '10': 'offset'},
  ],
};

/// Descriptor for `GetFileRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getFileRequestDescriptor = $convert.base64Decode(
    'Cg5HZXRGaWxlUmVxdWVzdBIXCgdmaWxlX2lkGAEgASgJUgZmaWxlSWQSFgoGb2Zmc2V0GAIgAS'
    'gDUgZvZmZzZXQ=');

@$core.Deprecated('Use mediaFileDescriptor instead')
const MediaFile$json = {
  '1': 'MediaFile',
  '2': [
    {
      '1': 'file',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.webitel.chat.File',
      '9': 0,
      '10': 'file'
    },
    {'1': 'data', '3': 2, '4': 1, '5': 12, '9': 0, '10': 'data'},
    {
      '1': 'end',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.webitel.portal.UpdateDisconnect',
      '9': 0,
      '10': 'end'
    },
  ],
  '8': [
    {'1': 'media_type'},
  ],
};

/// Descriptor for `MediaFile`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List mediaFileDescriptor = $convert.base64Decode(
    'CglNZWRpYUZpbGUSKAoEZmlsZRgBIAEoCzISLndlYml0ZWwuY2hhdC5GaWxlSABSBGZpbGUSFA'
    'oEZGF0YRgCIAEoDEgAUgRkYXRhEjQKA2VuZBgDIAEoCzIgLndlYml0ZWwucG9ydGFsLlVwZGF0'
    'ZURpc2Nvbm5lY3RIAFIDZW5kQgwKCm1lZGlhX3R5cGU=');
