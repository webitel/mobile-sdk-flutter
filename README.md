# Webitel Portal SDK for Flutter

Flutter SDK for the Webitel customer portal: end-user authentication, a realtime
chat with the contact center, message history, buttons (postbacks), file
transfer and push notifications.

The SDK talks to the portal over one of two transports. **The API is identical for
both** — only one argument of `initClient` changes:

| Transport | Realtime chat | Auth & push | Files |
|---|---|---|---|
| `PortalTransport.grpc` (default) | gRPC `Customer/Connect` stream | unary gRPC | gRPC `MediaStorage` streams |
| `PortalTransport.websocket` | `wss://<host>/portal/ws` | REST `/api/portal/*` | HTTP `/portal/files` |

Use WebSocket when gRPC (HTTP/2) is blocked between the app and the portal, e.g. by
a proxy or a load balancer without HTTP/2 support.

## Contents

- [Installation](#installation)
- [Quick start](#quick-start)
- [1. Initialize the client](#1-initialize-the-client)
- [2. Authenticate](#2-authenticate)
- [3. Get the dialog](#3-get-the-dialog)
- [4. Receive messages](#4-receive-messages)
- [5. Send messages](#5-send-messages)
- [6. History](#6-history)
- [7. Buttons and postbacks](#7-buttons-and-postbacks)
- [8. Files](#8-files)
- [9. Connection state and errors](#9-connection-state-and-errors)
- [10. Push notifications](#10-push-notifications)
- [Error handling](#error-handling)
- [API reference](#api-reference)
- [FAQ](#faq)

## Installation

Add the package to `pubspec.yaml`:

```yaml
dependencies:
  webitel_portal_sdk:
    git:
      url: https://github.com/webitel/mobile-sdk-flutter.git
      ref: main # or a tag / commit
```

```dart
import 'package:webitel_portal_sdk/webitel_portal_sdk.dart';
```

Requirements: Dart `>=3.3.3`, Android or iOS (the SDK reads device info for the
`User-Agent` and keeps its state in `shared_preferences`).

## Quick start

```dart
final client = await WebitelPortalSdk.instance.initClient(
  url: 'grpcs://portal.example.com',
  appToken: '<PORTAL_APP_TOKEN>',
  loggerLevel: LoggerLevel.error,
  transport: PortalTransport.websocket, // omit for gRPC
);
if (client.error != null) {
  // The client could not be initialized.
}

final login = await client.login(
  name: 'Jane Doe',
  sub: 'user-123',              // stable user id in your system
  issuer: 'https://example.com', // who issued the identity
);
if (login.status != PortalResponseStatus.success) {
  // login.message explains why.
}

final dialog = await client.chat.fetchServiceDialog();

dialog.onNewMessage.listen((message) {
  print('${message.peer.name}: ${message.dialogMessageContent}');
});

final sent = await dialog.sendMessage(
  content: 'Hello!',
  requestId: const Uuid().v4(), // unique per message, see below
);
```

Examples use the [`uuid`](https://pub.dev/packages/uuid) package for request ids;
any unique string works.

## 1. Initialize the client

```dart
final client = await WebitelPortalSdk.instance.initClient(
  url: 'grpcs://portal.example.com',
  appToken: '<PORTAL_APP_TOKEN>',
  loggerLevel: LoggerLevel.debug,
  transport: PortalTransport.grpc,
  cert: null,
);
```

| Parameter | Description |
|---|---|
| `url` | Portal address. The scheme selects TLS: `grpcs://`, `https://`, `wss://` are secure; `grpc://`, `http://`, `ws://` are plain. Default port is `443`; give an explicit port for plain-text connections, e.g. `ws://10.0.0.5:8080`. |
| `appToken` | Portal application token (sent as `x-portal-client`). |
| `loggerLevel` | `off`, `debug`, `warning`, `error`. Use `debug` while integrating. |
| `transport` | `PortalTransport.grpc` (default) or `PortalTransport.websocket`. Optional — existing code keeps working without it. |
| `cert` | Optional PEM certificate bytes to trust **instead of** the system roots (self-signed or private CA). |

Call `initClient` once per app start and keep the returned `PortalClient`.
`client.error` is non-null if initialization failed.

The same URL works for both transports: for WebSocket the host and port are taken
from it and the scheme only decides between `wss`/`https` and `ws`/`http`.

## 2. Authenticate

### Login with an identity

```dart
final response = await client.login(
  name: 'Jane Doe',
  sub: 'user-123',
  issuer: 'https://example.com',
  // optional:
  email: 'jane@example.com',
  emailVerified: true,
  phoneNumber: '+380000000000',
  phoneNumberVerified: false,
  locale: 'en',
);
```

`sub` + `issuer` identify the end user: the same pair always maps to the same
portal user and chat history. The access token is stored by the SDK and attached to
every following request automatically.

### Use an existing access token

If your backend already issued a portal access token:

```dart
await client.setAccessToken(token: '<ACCESS_TOKEN>');
```

It validates the token (throws on an invalid one) and uses it from now on.

### Current user and logout

```dart
final user = await client.getUser();
if (user.error == null) {
  print('${user.name} (${user.id}), token expires in ${user.tokenExpiration}');
}

await client.logout();
```

## 3. Get the dialog

A portal user has one dialog with the contact center:

```dart
final dialog = await client.chat.fetchServiceDialog();

if (dialog.error != null) {
  // e.g. UNAUTHENTICATED — login first.
}
print(dialog.id);         // chat id
print(dialog.topMessage); // last message text
print(dialog.isClosed);   // the conversation has ended
```

The realtime connection is opened automatically by the first request (fetching the
dialog, sending a message, …). You do not need to open it yourself.

## 4. Receive messages

```dart
final subscription = dialog.onNewMessage.listen((message) {
  switch (message.type) {
    case MessageType.text:
      print(message.dialogMessageContent);
    case MessageType.media:
      print('file ${message.file.name} (${message.file.size} bytes), id ${message.file.id}');
    case MessageType.button:
      // message.keyboard?.buttons — see "Buttons and postbacks"
    case null:
      break;
  }
});

dialog.onMemberAdded.listen((member) => print('${member.memberName} joined'));
dialog.onMemberLeft.listen((member) => print('${member.memberName} left'));
```

`DialogMessageResponse` fields you will use most:

| Field | Meaning |
|---|---|
| `messageId` | Server id of the message. |
| `dialogMessageContent` | Text. |
| `type` | `text`, `media` or `button`. |
| `file` | Attached file (`id`, `name`, `type`, `size`) for media messages. |
| `keyboard` / `input` | Buttons and whether free text input is disabled. |
| `peer`, `sender` | Who sent it. |
| `timestamp` | Unix time in milliseconds. |
| `error` | Non-null if the operation failed (see [Error handling](#error-handling)). |

Duplicate deliveries of the same message are filtered by the SDK, so each message
reaches `onNewMessage` once.

## 5. Send messages

```dart
final requestId = const Uuid().v4();

final response = await dialog.sendMessage(
  content: 'Hello!',
  requestId: requestId,
  timeout: 30, // seconds, optional (default 30)
);

if (response.error != null) {
  // Not delivered: show "retry" and resend with THE SAME requestId.
} else {
  print('delivered as message ${response.messageId}');
}
```

**`requestId` is the idempotency key of the message.** Generate a new one for every
new message and reuse it when retrying the same message. Calling `sendMessage`
again with a `requestId` that is still in flight does not send a duplicate — it
returns the pending result.

## 6. History

```dart
// History page (offset is a message id to continue from):
final page = await dialog.fetchMessages(limit: 20);
final olderPage = await dialog.fetchMessages(
  limit: 20,
  offset: page.last.messageId, // continue from the oldest loaded message
);

// Newer messages after a known one (e.g. after reconnect):
final updates = await dialog.fetchUpdates(limit: 50, offset: lastSeenMessageId);
```

On failure the list contains a single item whose `error` is set.

## 7. Buttons and postbacks

Bot messages may carry a keyboard:

```dart
dialog.onNewMessage.listen((message) {
  for (final row in message.keyboard?.buttons ?? const []) {
    for (final button in row) {
      if (button.url?.isNotEmpty ?? false) {
        // open button.url in a browser
      } else {
        // render a button that sends a postback
      }
    }
  }
  final textInputDisabled = message.input;
});
```

Send the user's choice back:

```dart
await dialog.sendPostback(
  postback: Postback(
    mid: message.messageId, // message that contains the button
    code: button.code!,     // button payload
    text: button.text,      // shown in the chat as the user's answer
  ),
  requestId: const Uuid().v4(),
);
```

## 8. Files

### Upload and send

```dart
final upload = dialog.uploadFile(
  file: File(path),
  mediaName: 'photo.jpg',
  mediaType: 'image/jpeg',
);

upload.onProgress.stream.listen(
  (event) {
    if (event.id == null || event.id!.isEmpty) {
      // Progress: event.progress!.progressSize bytes stored so far.
      // event.progress!.progressId — upload id, keep it to resume.
    } else {
      // Done: the file is stored on the server.
      dialog.sendMessage(
        content: '',
        requestId: const Uuid().v4(),
        uploadFile: UploadFile(id: event.id!, name: event.name!, type: event.type!),
      );
    }
  },
  onError: (Object error) => print('upload failed: $error'),
);
```

Resume an interrupted upload by passing the last `progressId` and `progressSize`:

```dart
dialog.uploadFile(file: file, mediaName: name, mediaType: type,
    pid: lastProgressId, offset: lastProgressSize);
```

Uploads are processed one at a time in the order they were started.

### Download

```dart
final download = dialog.downloadFile(
  fileId: message.file.id!,
  savePath: '${(await getTemporaryDirectory()).path}/${message.file.name}',
);

download.onData.stream.listen(
  (chunk) => print('${download.offset} / ${chunk.size} bytes'),
  onDone: () => print('saved'),
  onError: (Object error) => print('download failed: $error'),
);

await download.pause();
await download.resume(); // continues from download.offset
```

The file is written to `savePath`; `onData` reports progress.

## 9. Connection state and errors

```dart
final channel = await client.getChannel();

channel.onConnectStreamStatusChange.listen((connect) {
  // ConnectStatus.opened / closed; connect.errorMessage explains a close.
});

channel.onChannelStatusChange.listen((status) {
  // ChannelStatus.connecting / ready / transientFailure / idle / shutdown
});

channel.onError.listen((error) {
  print('${error.statusCode}: ${error.errorMessage}');
});

// Force a fresh connection, e.g. when the app returns to foreground:
await channel.reconnectToStream();
```

The SDK does not reconnect in a loop by itself: the next request re-opens a closed
connection, and `reconnectToStream()` re-opens it on demand. A typical app calls
`reconnectToStream()` on `AppLifecycleState.resumed` and on network changes, then
`fetchUpdates` to catch up.

Both transports report the same events. With WebSocket, `ready` means the socket is
open, `transientFailure` that it was lost, `idle` that it was closed normally.

## 10. Push notifications

```dart
await client.registerDevice(pushToken: fcmOrApnsToken); // APNs on iOS, FCM on Android
await client.unregisterDevice();
```

## Error handling

The SDK does not throw for operational failures — it returns them:

| Call | Failure is reported as |
|---|---|
| `initClient` | `client.error` |
| `login`, `logout`, `registerDevice`, `unregisterDevice` | `PortalResponse.status == PortalResponseStatus.error`, details in `message` |
| `getUser` | `PortalUser.error` |
| `fetchServiceDialog` | `Dialog.error` |
| `sendMessage`, `sendPostback` | `DialogMessageResponse.error` (including timeouts) |
| `fetchMessages`, `fetchUpdates` | one item with `error` set |
| uploads / downloads | `onError` of the progress stream |
| `setAccessToken` | throws if the token is rejected |

`CallError.statusCode` uses gRPC status codes for both transports (`16` —
unauthenticated, `14` — unavailable, `4` — deadline exceeded, …). WebSocket/HTTP
failures are mapped to the same codes (e.g. HTTP `401` → `16`), so error handling
does not depend on the transport.

## API reference

| Object | Members |
|---|---|
| `WebitelPortalSdk.instance` | `initClient({url, appToken, loggerLevel, cert, transport})` |
| `PortalClient` | `login`, `logout`, `setAccessToken`, `getUser`, `registerDevice`, `unregisterDevice`, `getChannel`, `ping`, `chat`, `error` |
| `client.chat` | `fetchServiceDialog()` |
| `Dialog` | `id`, `topMessage`, `isClosed`, `error`, `onNewMessage`, `onMemberAdded`, `onMemberLeft`, `sendMessage`, `sendPostback`, `fetchMessages`, `fetchUpdates`, `uploadFile`, `downloadFile` |
| `Channel` | `onConnectStreamStatusChange`, `onChannelStatusChange`, `onError`, `reconnectToStream()` |
| `Upload` | `onProgress`, `cancel()` |
| `Download` | `onData`, `offset`, `pause()`, `resume()` |

## FAQ

**Which transport should I use?**
gRPC by default. Switch to `PortalTransport.websocket` if the network between the app
and the portal does not pass HTTP/2 (corporate proxies, some load balancers). Nothing
else in your code changes.

**Does switching the transport change message history or user identity?**
No. Both transports work with the same portal user, chat and history.

**What does `client.ping()` do?**
Checks the round-trip to the portal and returns the echoed text, or an error string.
Over WebSocket it needs an open connection (any previous request opens it).

**Is the WebSocket connection kept alive?**
Yes: the SDK sends WebSocket ping frames every 10 seconds; a lost connection is
reported through `onConnectStreamStatusChange` / `onChannelStatusChange`.
