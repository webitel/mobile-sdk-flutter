## 1.3.0

- Added WebSocket transport: `initClient(..., transport: PortalTransport.websocket)`.
  Realtime chat goes over `wss://<host>/portal/ws`, auth and push over REST
  `/api/portal/*`, files over HTTP `/portal/files` — the same protocol as the
  Android SDK. The public API is unchanged; gRPC stays the default.
- Fixed `Upload.cancel()`: it now stops the upload (or drops a queued one) and
  the queue moves on.
- Fixed `Download.resume()` and downloads with `offset`: the received bytes are
  appended instead of overwritten.
- Fixed downloads: the file is flushed to disk before `onData` completes.
- Fixed downloads: a transfer interrupted by the network continues from the
  received offset (up to 3 attempts) instead of hanging.
- Rewrote the README.

## 1.0.0

- Initial version.
