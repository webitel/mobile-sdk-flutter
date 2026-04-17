// This is a generated file - do not edit.
//
// Generated from chat/messages/dialog.proto.

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

@$core.Deprecated('Use dialogDescriptor instead')
const Dialog$json = {
  '1': 'Dialog',
  '2': [
    {'1': 'dc', '3': 1, '4': 1, '5': 3, '10': 'dc'},
    {'1': 'id', '3': 2, '4': 1, '5': 9, '10': 'id'},
    {
      '1': 'via',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.webitel.chat.Peer',
      '10': 'via'
    },
    {
      '1': 'from',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.webitel.chat.Peer',
      '10': 'from'
    },
    {'1': 'date', '3': 6, '4': 1, '5': 3, '10': 'date'},
    {'1': 'title', '3': 7, '4': 1, '5': 9, '10': 'title'},
    {'1': 'closed', '3': 8, '4': 1, '5': 3, '10': 'closed'},
    {'1': 'started', '3': 9, '4': 1, '5': 3, '10': 'started'},
    {
      '1': 'message',
      '3': 10,
      '4': 1,
      '5': 11,
      '6': '.webitel.chat.Message',
      '10': 'message'
    },
    {
      '1': 'context',
      '3': 11,
      '4': 3,
      '5': 11,
      '6': '.webitel.chat.Dialog.ContextEntry',
      '10': 'context'
    },
    {
      '1': 'members',
      '3': 12,
      '4': 3,
      '5': 11,
      '6': '.webitel.chat.Chat',
      '10': 'members'
    },
  ],
  '3': [Dialog_ContextEntry$json],
};

@$core.Deprecated('Use dialogDescriptor instead')
const Dialog_ContextEntry$json = {
  '1': 'ContextEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `Dialog`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List dialogDescriptor = $convert.base64Decode(
    'CgZEaWFsb2cSDgoCZGMYASABKANSAmRjEg4KAmlkGAIgASgJUgJpZBIkCgN2aWEYAyABKAsyEi'
    '53ZWJpdGVsLmNoYXQuUGVlclIDdmlhEiYKBGZyb20YBCABKAsyEi53ZWJpdGVsLmNoYXQuUGVl'
    'clIEZnJvbRISCgRkYXRlGAYgASgDUgRkYXRlEhQKBXRpdGxlGAcgASgJUgV0aXRsZRIWCgZjbG'
    '9zZWQYCCABKANSBmNsb3NlZBIYCgdzdGFydGVkGAkgASgDUgdzdGFydGVkEi8KB21lc3NhZ2UY'
    'CiABKAsyFS53ZWJpdGVsLmNoYXQuTWVzc2FnZVIHbWVzc2FnZRI7Cgdjb250ZXh0GAsgAygLMi'
    'Eud2ViaXRlbC5jaGF0LkRpYWxvZy5Db250ZXh0RW50cnlSB2NvbnRleHQSLAoHbWVtYmVycxgM'
    'IAMoCzISLndlYml0ZWwuY2hhdC5DaGF0UgdtZW1iZXJzGjoKDENvbnRleHRFbnRyeRIQCgNrZX'
    'kYASABKAlSA2tleRIUCgV2YWx1ZRgCIAEoCVIFdmFsdWU6AjgB');

@$core.Deprecated('Use chatDialogsDescriptor instead')
const ChatDialogs$json = {
  '1': 'ChatDialogs',
  '2': [
    {
      '1': 'data',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.webitel.chat.Dialog',
      '10': 'data'
    },
    {'1': 'page', '3': 2, '4': 1, '5': 5, '10': 'page'},
    {'1': 'next', '3': 3, '4': 1, '5': 8, '10': 'next'},
  ],
};

/// Descriptor for `ChatDialogs`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List chatDialogsDescriptor = $convert.base64Decode(
    'CgtDaGF0RGlhbG9ncxIoCgRkYXRhGAEgAygLMhQud2ViaXRlbC5jaGF0LkRpYWxvZ1IEZGF0YR'
    'ISCgRwYWdlGAIgASgFUgRwYWdlEhIKBG5leHQYAyABKAhSBG5leHQ=');

@$core.Deprecated('Use chatDialogsRequestDescriptor instead')
const ChatDialogsRequest$json = {
  '1': 'ChatDialogsRequest',
  '2': [
    {'1': 'page', '3': 1, '4': 1, '5': 5, '10': 'page'},
    {'1': 'size', '3': 2, '4': 1, '5': 5, '10': 'size'},
    {'1': 'q', '3': 5, '4': 1, '5': 9, '10': 'q'},
    {'1': 'sort', '3': 3, '4': 3, '5': 9, '10': 'sort'},
    {'1': 'fields', '3': 4, '4': 3, '5': 9, '10': 'fields'},
    {'1': 'id', '3': 6, '4': 3, '5': 9, '10': 'id'},
    {
      '1': 'via',
      '3': 7,
      '4': 1,
      '5': 11,
      '6': '.webitel.chat.Peer',
      '10': 'via'
    },
    {
      '1': 'peer',
      '3': 8,
      '4': 1,
      '5': 11,
      '6': '.webitel.chat.Peer',
      '10': 'peer'
    },
    {
      '1': 'date',
      '3': 9,
      '4': 1,
      '5': 11,
      '6': '.webitel.chat.Timerange',
      '10': 'date'
    },
    {
      '1': 'online',
      '3': 10,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.BoolValue',
      '10': 'online'
    },
  ],
};

/// Descriptor for `ChatDialogsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List chatDialogsRequestDescriptor = $convert.base64Decode(
    'ChJDaGF0RGlhbG9nc1JlcXVlc3QSEgoEcGFnZRgBIAEoBVIEcGFnZRISCgRzaXplGAIgASgFUg'
    'RzaXplEgwKAXEYBSABKAlSAXESEgoEc29ydBgDIAMoCVIEc29ydBIWCgZmaWVsZHMYBCADKAlS'
    'BmZpZWxkcxIOCgJpZBgGIAMoCVICaWQSJAoDdmlhGAcgASgLMhIud2ViaXRlbC5jaGF0LlBlZX'
    'JSA3ZpYRImCgRwZWVyGAggASgLMhIud2ViaXRlbC5jaGF0LlBlZXJSBHBlZXISKwoEZGF0ZRgJ'
    'IAEoCzIXLndlYml0ZWwuY2hhdC5UaW1lcmFuZ2VSBGRhdGUSMgoGb25saW5lGAogASgLMhouZ2'
    '9vZ2xlLnByb3RvYnVmLkJvb2xWYWx1ZVIGb25saW5l');
