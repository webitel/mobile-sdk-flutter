import 'package:webitel_portal_sdk/src/domain/entities/call_error.dart';
import 'package:webitel_portal_sdk/src/domain/entities/channel.dart';
import 'package:webitel_portal_sdk/src/domain/entities/portal_response.dart';
import 'package:webitel_portal_sdk/src/domain/entities/portal_user.dart';
import 'package:webitel_portal_sdk/src/managers/call.dart';
import 'package:webitel_portal_sdk/src/managers/chat.dart';

abstract interface class PortalClient {
  Future<PortalResponse> logout();

  Future<Channel> getChannel();

  Future<PortalResponse> registerDevice({required String pushToken});

  Future<PortalResponse> login({
    required String name,
    required String sub,
    required String issuer,
    String locale,
    String email,
    bool emailVerified,
    String phoneNumber,
    bool phoneNumberVerified,
  });

  Future<PortalUser> getUser();

  CallError? get error;

  ChatManager get chat;

  CallManager get call;
}
