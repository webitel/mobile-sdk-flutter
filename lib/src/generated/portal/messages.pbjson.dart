// This is a generated file - do not edit.
//
// Generated from portal/messages.proto.

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

@$core.Deprecated('Use dispositionDescriptor instead')
const Disposition$json = {
  '1': 'Disposition',
  '2': [
    {'1': 'Outgoing', '2': 0},
    {'1': 'Incoming', '2': 1},
  ],
};

/// Descriptor for `Disposition`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List dispositionDescriptor = $convert
    .base64Decode('CgtEaXNwb3NpdGlvbhIMCghPdXRnb2luZxAAEgwKCEluY29taW5nEAE=');

@$core.Deprecated('Use chatAccountDescriptor instead')
const ChatAccount$json = {
  '1': 'ChatAccount',
  '2': [
    {
      '1': 'user',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.webitel.chat.Peer',
      '10': 'user'
    },
  ],
};

/// Descriptor for `ChatAccount`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List chatAccountDescriptor = $convert.base64Decode(
    'CgtDaGF0QWNjb3VudBImCgR1c2VyGAEgASgLMhIud2ViaXRlbC5jaGF0LlBlZXJSBHVzZXI=');

@$core.Deprecated('Use chatDescriptor instead')
const Chat$json = {
  '1': 'Chat',
  '2': [
    {'1': 'id', '3': 2, '4': 1, '5': 9, '10': 'id'},
    {'1': 'date', '3': 6, '4': 1, '5': 3, '10': 'date'},
    {'1': 'left', '3': 8, '4': 1, '5': 3, '10': 'left'},
    {'1': 'join', '3': 9, '4': 1, '5': 3, '10': 'join'},
    {
      '1': 'peer',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.webitel.chat.Peer',
      '10': 'peer'
    },
    {'1': 'title', '3': 7, '4': 1, '5': 9, '10': 'title'},
    {'1': 'inbox', '3': 1, '4': 1, '5': 5, '10': 'inbox'},
    {
      '1': 'message',
      '3': 10,
      '4': 1,
      '5': 11,
      '6': '.webitel.chat.Message',
      '10': 'message'
    },
  ],
};

/// Descriptor for `Chat`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List chatDescriptor = $convert.base64Decode(
    'CgRDaGF0Eg4KAmlkGAIgASgJUgJpZBISCgRkYXRlGAYgASgDUgRkYXRlEhIKBGxlZnQYCCABKA'
    'NSBGxlZnQSEgoEam9pbhgJIAEoA1IEam9pbhImCgRwZWVyGAQgASgLMhIud2ViaXRlbC5jaGF0'
    'LlBlZXJSBHBlZXISFAoFdGl0bGUYByABKAlSBXRpdGxlEhQKBWluYm94GAEgASgFUgVpbmJveB'
    'IvCgdtZXNzYWdlGAogASgLMhUud2ViaXRlbC5jaGF0Lk1lc3NhZ2VSB21lc3NhZ2U=');

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
  '9': [
    {'1': 7, '2': 8},
  ],
};

/// Descriptor for `ChatDialogsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List chatDialogsRequestDescriptor = $convert.base64Decode(
    'ChJDaGF0RGlhbG9nc1JlcXVlc3QSEgoEcGFnZRgBIAEoBVIEcGFnZRISCgRzaXplGAIgASgFUg'
    'RzaXplEgwKAXEYBSABKAlSAXESEgoEc29ydBgDIAMoCVIEc29ydBIWCgZmaWVsZHMYBCADKAlS'
    'BmZpZWxkcxIOCgJpZBgGIAMoCVICaWQSJgoEcGVlchgIIAEoCzISLndlYml0ZWwuY2hhdC5QZW'
    'VyUgRwZWVyEisKBGRhdGUYCSABKAsyFy53ZWJpdGVsLmNoYXQuVGltZXJhbmdlUgRkYXRlEjIK'
    'Bm9ubGluZRgKIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5Cb29sVmFsdWVSBm9ubGluZUoECAcQCA'
    '==');

@$core.Deprecated('Use chatListDescriptor instead')
const ChatList$json = {
  '1': 'ChatList',
  '2': [
    {
      '1': 'data',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.webitel.portal.Chat',
      '10': 'data'
    },
    {'1': 'page', '3': 2, '4': 1, '5': 5, '10': 'page'},
    {'1': 'next', '3': 3, '4': 1, '5': 8, '10': 'next'},
  ],
};

/// Descriptor for `ChatList`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List chatListDescriptor = $convert.base64Decode(
    'CghDaGF0TGlzdBIoCgRkYXRhGAEgAygLMhQud2ViaXRlbC5wb3J0YWwuQ2hhdFIEZGF0YRISCg'
    'RwYWdlGAIgASgFUgRwYWdlEhIKBG5leHQYAyABKAhSBG5leHQ=');

@$core.Deprecated('Use sendMessageRequestDescriptor instead')
const SendMessageRequest$json = {
  '1': 'SendMessageRequest',
  '2': [
    {'1': 'id', '3': 4, '4': 1, '5': 9, '10': 'id'},
    {
      '1': 'peer',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.webitel.chat.Peer',
      '10': 'peer'
    },
    {
      '1': 'file',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.webitel.chat.File',
      '10': 'file'
    },
    {'1': 'text', '3': 3, '4': 1, '5': 9, '10': 'text'},
    {
      '1': 'postback',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.webitel.chat.Postback',
      '10': 'postback'
    },
  ],
};

/// Descriptor for `SendMessageRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sendMessageRequestDescriptor = $convert.base64Decode(
    'ChJTZW5kTWVzc2FnZVJlcXVlc3QSDgoCaWQYBCABKAlSAmlkEiYKBHBlZXIYASABKAsyEi53ZW'
    'JpdGVsLmNoYXQuUGVlclIEcGVlchImCgRmaWxlGAIgASgLMhIud2ViaXRlbC5jaGF0LkZpbGVS'
    'BGZpbGUSEgoEdGV4dBgDIAEoCVIEdGV4dBIyCghwb3N0YmFjaxgFIAEoCzIWLndlYml0ZWwuY2'
    'hhdC5Qb3N0YmFja1IIcG9zdGJhY2s=');

@$core.Deprecated('Use readHistoryRequestDescriptor instead')
const ReadHistoryRequest$json = {
  '1': 'ReadHistoryRequest',
  '2': [
    {
      '1': 'peer',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.webitel.chat.Peer',
      '10': 'peer'
    },
    {'1': 'max_id', '3': 2, '4': 1, '5': 3, '10': 'maxId'},
  ],
};

/// Descriptor for `ReadHistoryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List readHistoryRequestDescriptor = $convert.base64Decode(
    'ChJSZWFkSGlzdG9yeVJlcXVlc3QSJgoEcGVlchgBIAEoCzISLndlYml0ZWwuY2hhdC5QZWVyUg'
    'RwZWVyEhUKBm1heF9pZBgCIAEoA1IFbWF4SWQ=');

@$core.Deprecated('Use updateNewMessageDescriptor instead')
const UpdateNewMessage$json = {
  '1': 'UpdateNewMessage',
  '2': [
    {'1': 'id', '3': 3, '4': 1, '5': 9, '10': 'id'},
    {
      '1': 'dispo',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.webitel.portal.Disposition',
      '10': 'dispo'
    },
    {
      '1': 'message',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.webitel.chat.Message',
      '10': 'message'
    },
  ],
};

/// Descriptor for `UpdateNewMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateNewMessageDescriptor = $convert.base64Decode(
    'ChBVcGRhdGVOZXdNZXNzYWdlEg4KAmlkGAMgASgJUgJpZBIxCgVkaXNwbxgBIAEoDjIbLndlYm'
    'l0ZWwucG9ydGFsLkRpc3Bvc2l0aW9uUgVkaXNwbxIvCgdtZXNzYWdlGAIgASgLMhUud2ViaXRl'
    'bC5jaGF0Lk1lc3NhZ2VSB21lc3NhZ2U=');

@$core.Deprecated('Use updateChatMemberDescriptor instead')
const UpdateChatMember$json = {
  '1': 'UpdateChatMember',
  '2': [
    {
      '1': 'chat',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.webitel.chat.Chat',
      '10': 'chat'
    },
    {
      '1': 'join',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.webitel.chat.Peer',
      '10': 'join'
    },
  ],
};

/// Descriptor for `UpdateChatMember`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateChatMemberDescriptor = $convert.base64Decode(
    'ChBVcGRhdGVDaGF0TWVtYmVyEiYKBGNoYXQYASABKAsyEi53ZWJpdGVsLmNoYXQuQ2hhdFIEY2'
    'hhdBImCgRqb2luGAIgAygLMhIud2ViaXRlbC5jaGF0LlBlZXJSBGpvaW4=');

@$core.Deprecated('Use updateLeftMemberDescriptor instead')
const UpdateLeftMember$json = {
  '1': 'UpdateLeftMember',
  '2': [
    {
      '1': 'chat',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.webitel.chat.Chat',
      '10': 'chat'
    },
    {
      '1': 'left',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.webitel.chat.Peer',
      '10': 'left'
    },
  ],
};

/// Descriptor for `UpdateLeftMember`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateLeftMemberDescriptor = $convert.base64Decode(
    'ChBVcGRhdGVMZWZ0TWVtYmVyEiYKBGNoYXQYASABKAsyEi53ZWJpdGVsLmNoYXQuQ2hhdFIEY2'
    'hhdBImCgRsZWZ0GAIgASgLMhIud2ViaXRlbC5jaGF0LlBlZXJSBGxlZnQ=');

@$core.Deprecated('Use updateChatCompleteDescriptor instead')
const UpdateChatComplete$json = {
  '1': 'UpdateChatComplete',
  '2': [
    {
      '1': 'chat',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.webitel.chat.Chat',
      '10': 'chat'
    },
    {
      '1': 'from',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.webitel.chat.Peer',
      '10': 'from'
    },
  ],
};

/// Descriptor for `UpdateChatComplete`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateChatCompleteDescriptor = $convert.base64Decode(
    'ChJVcGRhdGVDaGF0Q29tcGxldGUSJgoEY2hhdBgBIAEoCzISLndlYml0ZWwuY2hhdC5DaGF0Ug'
    'RjaGF0EiYKBGZyb20YAiABKAsyEi53ZWJpdGVsLmNoYXQuUGVlclIEZnJvbQ==');

@$core.Deprecated('Use updateReadHistoryInboxDescriptor instead')
const UpdateReadHistoryInbox$json = {
  '1': 'UpdateReadHistoryInbox',
  '2': [
    {
      '1': 'peer',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.webitel.chat.Peer',
      '10': 'peer'
    },
    {'1': 'max_id', '3': 2, '4': 1, '5': 3, '10': 'maxId'},
    {'1': 'inbox', '3': 3, '4': 1, '5': 5, '10': 'inbox'},
  ],
};

/// Descriptor for `UpdateReadHistoryInbox`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateReadHistoryInboxDescriptor = $convert.base64Decode(
    'ChZVcGRhdGVSZWFkSGlzdG9yeUluYm94EiYKBHBlZXIYASABKAsyEi53ZWJpdGVsLmNoYXQuUG'
    'VlclIEcGVlchIVCgZtYXhfaWQYAiABKANSBW1heElkEhQKBWluYm94GAMgASgFUgVpbmJveA==');

@$core.Deprecated('Use updateReadHistoryOutboxDescriptor instead')
const UpdateReadHistoryOutbox$json = {
  '1': 'UpdateReadHistoryOutbox',
  '2': [
    {
      '1': 'peer',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.webitel.chat.Peer',
      '10': 'peer'
    },
    {'1': 'max_id', '3': 2, '4': 1, '5': 3, '10': 'maxId'},
  ],
};

/// Descriptor for `UpdateReadHistoryOutbox`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateReadHistoryOutboxDescriptor =
    $convert.base64Decode(
        'ChdVcGRhdGVSZWFkSGlzdG9yeU91dGJveBImCgRwZWVyGAEgASgLMhIud2ViaXRlbC5jaGF0Ll'
        'BlZXJSBHBlZXISFQoGbWF4X2lkGAIgASgDUgVtYXhJZA==');
