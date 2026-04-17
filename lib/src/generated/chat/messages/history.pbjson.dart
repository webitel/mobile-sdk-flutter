// This is a generated file - do not edit.
//
// Generated from chat/messages/history.proto.

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

@$core.Deprecated('Use chatMessagesDescriptor instead')
const ChatMessages$json = {
  '1': 'ChatMessages',
  '2': [
    {
      '1': 'messages',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.webitel.chat.Message',
      '10': 'messages'
    },
    {
      '1': 'chats',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.webitel.chat.Chat',
      '10': 'chats'
    },
    {
      '1': 'peers',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.webitel.chat.Peer',
      '10': 'peers'
    },
    {'1': 'page', '3': 5, '4': 1, '5': 5, '10': 'page'},
    {'1': 'next', '3': 6, '4': 1, '5': 8, '10': 'next'},
  ],
};

/// Descriptor for `ChatMessages`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List chatMessagesDescriptor = $convert.base64Decode(
    'CgxDaGF0TWVzc2FnZXMSMQoIbWVzc2FnZXMYASADKAsyFS53ZWJpdGVsLmNoYXQuTWVzc2FnZV'
    'IIbWVzc2FnZXMSKAoFY2hhdHMYAiADKAsyEi53ZWJpdGVsLmNoYXQuQ2hhdFIFY2hhdHMSKAoF'
    'cGVlcnMYAyADKAsyEi53ZWJpdGVsLmNoYXQuUGVlclIFcGVlcnMSEgoEcGFnZRgFIAEoBVIEcG'
    'FnZRISCgRuZXh0GAYgASgIUgRuZXh0');

@$core.Deprecated('Use chatMessagesRequestDescriptor instead')
const ChatMessagesRequest$json = {
  '1': 'ChatMessagesRequest',
  '2': [
    {
      '1': 'offset',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.webitel.chat.ChatMessagesRequest.Offset',
      '10': 'offset'
    },
    {'1': 'limit', '3': 2, '4': 1, '5': 5, '10': 'limit'},
    {'1': 'q', '3': 5, '4': 1, '5': 9, '10': 'q'},
    {'1': 'fields', '3': 3, '4': 3, '5': 9, '10': 'fields'},
    {'1': 'chat_id', '3': 6, '4': 1, '5': 9, '9': 0, '10': 'chatId'},
    {
      '1': 'peer',
      '3': 7,
      '4': 1,
      '5': 11,
      '6': '.webitel.chat.Peer',
      '9': 0,
      '10': 'peer'
    },
  ],
  '3': [ChatMessagesRequest_Offset$json],
  '8': [
    {'1': 'chat'},
  ],
};

@$core.Deprecated('Use chatMessagesRequestDescriptor instead')
const ChatMessagesRequest_Offset$json = {
  '1': 'Offset',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 3, '10': 'id'},
    {'1': 'date', '3': 2, '4': 1, '5': 3, '10': 'date'},
  ],
};

/// Descriptor for `ChatMessagesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List chatMessagesRequestDescriptor = $convert.base64Decode(
    'ChNDaGF0TWVzc2FnZXNSZXF1ZXN0EkAKBm9mZnNldBgBIAEoCzIoLndlYml0ZWwuY2hhdC5DaG'
    'F0TWVzc2FnZXNSZXF1ZXN0Lk9mZnNldFIGb2Zmc2V0EhQKBWxpbWl0GAIgASgFUgVsaW1pdBIM'
    'CgFxGAUgASgJUgFxEhYKBmZpZWxkcxgDIAMoCVIGZmllbGRzEhkKB2NoYXRfaWQYBiABKAlIAF'
    'IGY2hhdElkEigKBHBlZXIYByABKAsyEi53ZWJpdGVsLmNoYXQuUGVlckgAUgRwZWVyGiwKBk9m'
    'ZnNldBIOCgJpZBgBIAEoA1ICaWQSEgoEZGF0ZRgCIAEoA1IEZGF0ZUIGCgRjaGF0');
