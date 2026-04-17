// This is a generated file - do not edit.
//
// Generated from chat/messages/chat.proto.

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

@$core.Deprecated('Use chatDescriptor instead')
const Chat$json = {
  '1': 'Chat',
  '2': [
    {'1': 'dc', '3': 1, '4': 1, '5': 3, '10': 'dc'},
    {'1': 'id', '3': 2, '4': 1, '5': 9, '10': 'id'},
    {
      '1': 'via',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.webitel.chat.Peer',
      '10': 'via'
    },
    {
      '1': 'peer',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.webitel.chat.Peer',
      '10': 'peer'
    },
    {'1': 'title', '3': 8, '4': 1, '5': 9, '10': 'title'},
    {'1': 'left', '3': 10, '4': 1, '5': 3, '10': 'left'},
    {'1': 'join', '3': 11, '4': 1, '5': 3, '10': 'join'},
    {
      '1': 'invite',
      '3': 13,
      '4': 1,
      '5': 11,
      '6': '.webitel.chat.Chat.Invite',
      '10': 'invite'
    },
    {
      '1': 'context',
      '3': 15,
      '4': 3,
      '5': 11,
      '6': '.webitel.chat.Chat.ContextEntry',
      '10': 'context'
    },
  ],
  '3': [Chat_Invite$json, Chat_ContextEntry$json],
};

@$core.Deprecated('Use chatDescriptor instead')
const Chat_Invite$json = {
  '1': 'Invite',
  '2': [
    {'1': 'date', '3': 1, '4': 1, '5': 3, '10': 'date'},
    {'1': 'from', '3': 2, '4': 1, '5': 9, '10': 'from'},
  ],
};

@$core.Deprecated('Use chatDescriptor instead')
const Chat_ContextEntry$json = {
  '1': 'ContextEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `Chat`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List chatDescriptor = $convert.base64Decode(
    'CgRDaGF0Eg4KAmRjGAEgASgDUgJkYxIOCgJpZBgCIAEoCVICaWQSJAoDdmlhGAUgASgLMhIud2'
    'ViaXRlbC5jaGF0LlBlZXJSA3ZpYRImCgRwZWVyGAYgASgLMhIud2ViaXRlbC5jaGF0LlBlZXJS'
    'BHBlZXISFAoFdGl0bGUYCCABKAlSBXRpdGxlEhIKBGxlZnQYCiABKANSBGxlZnQSEgoEam9pbh'
    'gLIAEoA1IEam9pbhIxCgZpbnZpdGUYDSABKAsyGS53ZWJpdGVsLmNoYXQuQ2hhdC5JbnZpdGVS'
    'Bmludml0ZRI5Cgdjb250ZXh0GA8gAygLMh8ud2ViaXRlbC5jaGF0LkNoYXQuQ29udGV4dEVudH'
    'J5Ugdjb250ZXh0GjAKBkludml0ZRISCgRkYXRlGAEgASgDUgRkYXRlEhIKBGZyb20YAiABKAlS'
    'BGZyb20aOgoMQ29udGV4dEVudHJ5EhAKA2tleRgBIAEoCVIDa2V5EhQKBXZhbHVlGAIgASgJUg'
    'V2YWx1ZToCOAE=');

@$core.Deprecated('Use timerangeDescriptor instead')
const Timerange$json = {
  '1': 'Timerange',
  '2': [
    {'1': 'since', '3': 1, '4': 1, '5': 3, '10': 'since'},
    {'1': 'until', '3': 2, '4': 1, '5': 3, '10': 'until'},
  ],
};

/// Descriptor for `Timerange`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List timerangeDescriptor = $convert.base64Decode(
    'CglUaW1lcmFuZ2USFAoFc2luY2UYASABKANSBXNpbmNlEhQKBXVudGlsGAIgASgDUgV1bnRpbA'
    '==');

@$core.Deprecated('Use chatMembersRequestDescriptor instead')
const ChatMembersRequest$json = {
  '1': 'ChatMembersRequest',
  '2': [
    {'1': 'page', '3': 1, '4': 1, '5': 5, '10': 'page'},
    {'1': 'size', '3': 2, '4': 1, '5': 5, '10': 'size'},
    {'1': 'q', '3': 6, '4': 1, '5': 9, '10': 'q'},
    {'1': 'sort', '3': 3, '4': 3, '5': 9, '10': 'sort'},
    {'1': 'fields', '3': 4, '4': 3, '5': 9, '10': 'fields'},
    {'1': 'chat_id', '3': 5, '4': 1, '5': 9, '10': 'chatId'},
    {'1': 'id', '3': 7, '4': 3, '5': 9, '10': 'id'},
    {
      '1': 'via',
      '3': 8,
      '4': 1,
      '5': 11,
      '6': '.webitel.chat.Peer',
      '10': 'via'
    },
    {
      '1': 'peer',
      '3': 9,
      '4': 1,
      '5': 11,
      '6': '.webitel.chat.Peer',
      '10': 'peer'
    },
    {
      '1': 'date',
      '3': 10,
      '4': 1,
      '5': 11,
      '6': '.webitel.chat.Timerange',
      '10': 'date'
    },
    {
      '1': 'online',
      '3': 11,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.BoolValue',
      '10': 'online'
    },
    {
      '1': 'joined',
      '3': 12,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.BoolValue',
      '10': 'joined'
    },
  ],
};

/// Descriptor for `ChatMembersRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List chatMembersRequestDescriptor = $convert.base64Decode(
    'ChJDaGF0TWVtYmVyc1JlcXVlc3QSEgoEcGFnZRgBIAEoBVIEcGFnZRISCgRzaXplGAIgASgFUg'
    'RzaXplEgwKAXEYBiABKAlSAXESEgoEc29ydBgDIAMoCVIEc29ydBIWCgZmaWVsZHMYBCADKAlS'
    'BmZpZWxkcxIXCgdjaGF0X2lkGAUgASgJUgZjaGF0SWQSDgoCaWQYByADKAlSAmlkEiQKA3ZpYR'
    'gIIAEoCzISLndlYml0ZWwuY2hhdC5QZWVyUgN2aWESJgoEcGVlchgJIAEoCzISLndlYml0ZWwu'
    'Y2hhdC5QZWVyUgRwZWVyEisKBGRhdGUYCiABKAsyFy53ZWJpdGVsLmNoYXQuVGltZXJhbmdlUg'
    'RkYXRlEjIKBm9ubGluZRgLIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5Cb29sVmFsdWVSBm9ubGlu'
    'ZRIyCgZqb2luZWQYDCABKAsyGi5nb29nbGUucHJvdG9idWYuQm9vbFZhbHVlUgZqb2luZWQ=');

@$core.Deprecated('Use chatMembersDescriptor instead')
const ChatMembers$json = {
  '1': 'ChatMembers',
  '2': [
    {
      '1': 'data',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.webitel.chat.Chat',
      '10': 'data'
    },
    {'1': 'page', '3': 5, '4': 1, '5': 5, '10': 'page'},
    {'1': 'next', '3': 6, '4': 1, '5': 8, '10': 'next'},
  ],
};

/// Descriptor for `ChatMembers`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List chatMembersDescriptor = $convert.base64Decode(
    'CgtDaGF0TWVtYmVycxImCgRkYXRhGAEgAygLMhIud2ViaXRlbC5jaGF0LkNoYXRSBGRhdGESEg'
    'oEcGFnZRgFIAEoBVIEcGFnZRISCgRuZXh0GAYgASgIUgRuZXh0');
