import 'dart:async';

import 'package:webitel_portal_sdk/src/domain/entities/channel_status.dart';
import 'package:webitel_portal_sdk/src/domain/entities/connect.dart';
import 'package:webitel_portal_sdk/src/domain/entities/error.dart';

abstract interface class Channel {
  Stream<ChannelStatus> get onChannelStatusChange;

  Stream<ConnectEntity> get onConnectStreamStatusChange;

  Stream<ErrorEntity> get onError;
}
