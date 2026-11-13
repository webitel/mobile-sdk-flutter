import 'dart:convert';

import 'package:protobuf/protobuf.dart';
import 'package:webitel_portal_sdk/src/generated/chat/messages/dialog.pb.dart'
    as dialog;
import 'package:webitel_portal_sdk/src/generated/chat/messages/history.pb.dart';
import 'package:webitel_portal_sdk/src/generated/google/rpc/status.pb.dart';
import 'package:webitel_portal_sdk/src/generated/portal/auth.pb.dart';
import 'package:webitel_portal_sdk/src/generated/portal/connect.pb.dart'
    as portal;
import 'package:webitel_portal_sdk/src/generated/portal/customer.pb.dart';
import 'package:webitel_portal_sdk/src/generated/portal/messages.pb.dart';

/// Proto3 JSON codec for messages exchanged over WebSocket and REST (mirrors
/// `ProtoJson` of the Android SDK).
final class ProtoJson {
  ProtoJson._();

  /// Every message type that can be packed into a `google.protobuf.Any`.
  static final TypeRegistry registry = TypeRegistry([
    portal.Request(),
    portal.Response(),
    portal.Update(),
    portal.Echo(),
    portal.UpdateDisconnect(),
    ChatDialogsRequest(),
    ChatList(),
    SendMessageRequest(),
    ReadHistoryRequest(),
    UpdateNewMessage(),
    UpdateChatMember(),
    UpdateLeftMember(),
    UpdateChatComplete(),
    UpdateReadHistoryInbox(),
    UpdateReadHistoryOutbox(),
    dialog.ChatDialogsRequest(),
    dialog.ChatDialogs(),
    ChatMessagesRequest(),
    ChatMessages(),
    Status(),
    AccessToken(),
    TokenRequest(),
    InspectRequest(),
    LogoutRequest(),
    RegisterDeviceRequest(),
    RegisterDeviceResponse(),
  ]);

  static String encode(GeneratedMessage message) =>
      jsonEncode(message.toProto3Json(typeRegistry: registry));

  /// Merges [json] into [message]. Unknown fields are ignored and `Any`
  /// values of unregistered types are dropped instead of failing the whole
  /// message, so newer server payloads stay readable.
  ///
  /// Throws [FormatException] on malformed JSON.
  static T decode<T extends GeneratedMessage>(String json, T message) {
    message.mergeFromProto3Json(
      _dropUnknownAny(jsonDecode(json)),
      typeRegistry: registry,
      ignoreUnknownFields: true,
    );
    return message;
  }

  static Object? _dropUnknownAny(Object? value) {
    if (value is Map) {
      final type = value['@type'];
      if (type is String &&
          registry.lookup(type.substring(type.lastIndexOf('/') + 1)) == null) {
        return null;
      }
      return <String, dynamic>{
        for (final entry in value.entries)
          if (_dropUnknownAny(entry.value) case final Object v)
            '${entry.key}': v,
      };
    }
    if (value is List) {
      return [
        for (final item in value)
          if (_dropUnknownAny(item) case final Object v) v,
      ];
    }
    return value;
  }
}
