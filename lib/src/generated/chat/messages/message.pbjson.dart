// This is a generated file - do not edit.
//
// Generated from chat/messages/message.proto.

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

@$core.Deprecated('Use messageDescriptor instead')
const Message$json = {
  '1': 'Message',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 3, '10': 'id'},
    {'1': 'date', '3': 2, '4': 1, '5': 3, '10': 'date'},
    {
      '1': 'from',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.webitel.chat.Peer',
      '10': 'from'
    },
    {
      '1': 'chat',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.webitel.chat.Chat',
      '10': 'chat'
    },
    {
      '1': 'sender',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.webitel.chat.Chat',
      '10': 'sender'
    },
    {'1': 'edit', '3': 6, '4': 1, '5': 3, '10': 'edit'},
    {'1': 'text', '3': 7, '4': 1, '5': 9, '10': 'text'},
    {
      '1': 'file',
      '3': 8,
      '4': 1,
      '5': 11,
      '6': '.webitel.chat.File',
      '10': 'file'
    },
    {
      '1': 'context',
      '3': 9,
      '4': 3,
      '5': 11,
      '6': '.webitel.chat.Message.ContextEntry',
      '10': 'context'
    },
    {
      '1': 'keyboard',
      '3': 10,
      '4': 1,
      '5': 11,
      '6': '.webitel.chat.ReplyMarkup',
      '10': 'keyboard'
    },
    {
      '1': 'postback',
      '3': 11,
      '4': 1,
      '5': 11,
      '6': '.webitel.chat.Postback',
      '10': 'postback'
    },
  ],
  '3': [Message_ContextEntry$json],
};

@$core.Deprecated('Use messageDescriptor instead')
const Message_ContextEntry$json = {
  '1': 'ContextEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `Message`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List messageDescriptor = $convert.base64Decode(
    'CgdNZXNzYWdlEg4KAmlkGAEgASgDUgJpZBISCgRkYXRlGAIgASgDUgRkYXRlEiYKBGZyb20YAy'
    'ABKAsyEi53ZWJpdGVsLmNoYXQuUGVlclIEZnJvbRImCgRjaGF0GAQgASgLMhIud2ViaXRlbC5j'
    'aGF0LkNoYXRSBGNoYXQSKgoGc2VuZGVyGAUgASgLMhIud2ViaXRlbC5jaGF0LkNoYXRSBnNlbm'
    'RlchISCgRlZGl0GAYgASgDUgRlZGl0EhIKBHRleHQYByABKAlSBHRleHQSJgoEZmlsZRgIIAEo'
    'CzISLndlYml0ZWwuY2hhdC5GaWxlUgRmaWxlEjwKB2NvbnRleHQYCSADKAsyIi53ZWJpdGVsLm'
    'NoYXQuTWVzc2FnZS5Db250ZXh0RW50cnlSB2NvbnRleHQSNQoIa2V5Ym9hcmQYCiABKAsyGS53'
    'ZWJpdGVsLmNoYXQuUmVwbHlNYXJrdXBSCGtleWJvYXJkEjIKCHBvc3RiYWNrGAsgASgLMhYud2'
    'ViaXRlbC5jaGF0LlBvc3RiYWNrUghwb3N0YmFjaxo6CgxDb250ZXh0RW50cnkSEAoDa2V5GAEg'
    'ASgJUgNrZXkSFAoFdmFsdWUYAiABKAlSBXZhbHVlOgI4AQ==');

@$core.Deprecated('Use fileDescriptor instead')
const File$json = {
  '1': 'File',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'size', '3': 3, '4': 1, '5': 3, '10': 'size'},
    {'1': 'type', '3': 4, '4': 1, '5': 9, '10': 'type'},
    {'1': 'name', '3': 5, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `File`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fileDescriptor = $convert.base64Decode(
    'CgRGaWxlEg4KAmlkGAEgASgJUgJpZBISCgRzaXplGAMgASgDUgRzaXplEhIKBHR5cGUYBCABKA'
    'lSBHR5cGUSEgoEbmFtZRgFIAEoCVIEbmFtZQ==');

@$core.Deprecated('Use replyMarkupDescriptor instead')
const ReplyMarkup$json = {
  '1': 'ReplyMarkup',
  '2': [
    {'1': 'no_input', '3': 2, '4': 1, '5': 8, '10': 'noInput'},
    {
      '1': 'buttons',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.webitel.chat.ButtonRow',
      '10': 'buttons'
    },
  ],
};

/// Descriptor for `ReplyMarkup`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List replyMarkupDescriptor = $convert.base64Decode(
    'CgtSZXBseU1hcmt1cBIZCghub19pbnB1dBgCIAEoCFIHbm9JbnB1dBIxCgdidXR0b25zGAEgAy'
    'gLMhcud2ViaXRlbC5jaGF0LkJ1dHRvblJvd1IHYnV0dG9ucw==');

@$core.Deprecated('Use buttonRowDescriptor instead')
const ButtonRow$json = {
  '1': 'ButtonRow',
  '2': [
    {
      '1': 'row',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.webitel.chat.Button',
      '10': 'row'
    },
  ],
};

/// Descriptor for `ButtonRow`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List buttonRowDescriptor = $convert.base64Decode(
    'CglCdXR0b25Sb3cSJgoDcm93GAEgAygLMhQud2ViaXRlbC5jaGF0LkJ1dHRvblIDcm93');

@$core.Deprecated('Use buttonDescriptor instead')
const Button$json = {
  '1': 'Button',
  '2': [
    {'1': 'text', '3': 1, '4': 1, '5': 9, '10': 'text'},
    {'1': 'url', '3': 2, '4': 1, '5': 9, '9': 0, '10': 'url'},
    {'1': 'code', '3': 3, '4': 1, '5': 9, '9': 0, '10': 'code'},
    {
      '1': 'share',
      '3': 4,
      '4': 1,
      '5': 14,
      '6': '.webitel.chat.Button.Request',
      '9': 0,
      '10': 'share'
    },
  ],
  '4': [Button_Request$json],
  '8': [
    {'1': 'type'},
  ],
};

@$core.Deprecated('Use buttonDescriptor instead')
const Button_Request$json = {
  '1': 'Request',
  '2': [
    {'1': 'phone', '2': 0},
    {'1': 'email', '2': 1},
    {'1': 'contact', '2': 2},
    {'1': 'location', '2': 3},
  ],
};

/// Descriptor for `Button`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List buttonDescriptor = $convert.base64Decode(
    'CgZCdXR0b24SEgoEdGV4dBgBIAEoCVIEdGV4dBISCgN1cmwYAiABKAlIAFIDdXJsEhQKBGNvZG'
    'UYAyABKAlIAFIEY29kZRI0CgVzaGFyZRgEIAEoDjIcLndlYml0ZWwuY2hhdC5CdXR0b24uUmVx'
    'dWVzdEgAUgVzaGFyZSI6CgdSZXF1ZXN0EgkKBXBob25lEAASCQoFZW1haWwQARILCgdjb250YW'
    'N0EAISDAoIbG9jYXRpb24QA0IGCgR0eXBl');

@$core.Deprecated('Use postbackDescriptor instead')
const Postback$json = {
  '1': 'Postback',
  '2': [
    {'1': 'mid', '3': 1, '4': 1, '5': 3, '10': 'mid'},
    {'1': 'code', '3': 2, '4': 1, '5': 9, '10': 'code'},
    {'1': 'text', '3': 3, '4': 1, '5': 9, '10': 'text'},
  ],
};

/// Descriptor for `Postback`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List postbackDescriptor = $convert.base64Decode(
    'CghQb3N0YmFjaxIQCgNtaWQYASABKANSA21pZBISCgRjb2RlGAIgASgJUgRjb2RlEhIKBHRleH'
    'QYAyABKAlSBHRleHQ=');
