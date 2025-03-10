# Webitel Portal SDK

## Features

List the key features and functionalities:

- Feature 1: Send messages

- Feature 2: Listen to incoming/upcoming messages

- Feature 3: Fetch messages/updates

- Feature 4: Send/Receive files

## Usage

### Client

Configure client:
`final client = await WebitelPortalSdk.instance.initClient();`

### Auth

Login user:
`await client.login();`

Logout user and disable push notifications:
`await client.logout();`

Register device for push notifications:
`await client.registerDevice();`

Unregister device from push notifications:
`await client.unregisterDevice();`

Get user:
`await client.getUser();`

### Channel & Connect Status listeners

Get Channel:
`final channel = await client.getChannel();`

Listen to changes in channel status:
`channel.onChannelStatusChange.listen...`

Listen to changes in connect status:
`channel.onConnectStreamStatusChange.listen...`

Reconnect to stream:
`channel.reconnectToStream()...`

### Dialogs

Fetch dialog:
`final dialog = await client.fetchServiceDialog();`

Send message or message with media to dialog:
`await dialog.sendMessage(content: message, requestId: id);`

Send Postback:
`await dialog.sendPostback(mid: mid, code: code, text: text, requestId: requestId);`

_Description: Postbacks are used to send predefined replies or actions in response to a user's
interaction with a quick
reply button.
When a message contains a keyboard with buttons, each button may have an associated postback.
By invoking
the sendPostback method with the appropriate parameters (mid for message ID, code for the button's
action code, text for
the button's display text, and requestId for the unique request identifier), the SDK sends this
postback data to the
server, allowing the system to process the user's action seamlessly._

### Fetching and listening to new messages

Fetch messages | set limit/offset for dialog:
`await dialog.fetchMessages(limit: limit, offset: offset);`

Fetch updates | set limit/offset (reversed to **fetchMessages**) for dialog:
`await dialog.fetchUpdates(limit: limit, offset: offset);`

Listen to upcoming/incoming messages in dialog:
`await dialog.listenToMessages();`

### Downloading files

Retrieve download object:
`final download = dialog.downloadFile(fileId: fileId);`

Listen to file data:
`download.onData.listen;`

Pause downloading file:
`await download.pause();`

Resume downloading file:
`await download.resume();`

### Uploading files

Retrieve upload object:
`final upload = dialog.uploadFile(file: file, mediaType: type, mediaName: name);`

Listen to file data (data bytes, progress, id, name, size):
`upload.onProgress.listen;`

Cancel uploading file:
`await upload.cancel();`

### Members actions

Listen to newMemberAdded to the chat:
`await dialog.onMemberAdded();`

Listen to MemberLeft the chat:
`await dialog.onMemberLeft();`

