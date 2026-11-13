/// Client transport type.
///
/// The public SDK API is identical for every transport: only the wire
/// protocol used to talk to the portal changes.
enum PortalTransport {
  /// gRPC transport (default): a bi-directional `Customer/Connect` stream for
  /// realtime messaging, unary gRPC calls for auth and gRPC streams for files.
  grpc,

  /// WebSocket transport: realtime messaging over `wss://<host>/portal/ws`,
  /// auth and push registration over REST (`/api/portal/*`) and files over
  /// HTTP (`/portal/files`).
  websocket,
}
