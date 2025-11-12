/// Enumeration representing different types of responses in a communication system.
enum ResponseType {
  /// Represents a standard response.
  response,

  /// Represents an update that includes a new message.
  updateNewMessage,

  /// Represents an error response.
  error,

  /// New member added
  memberAdded,

  ///Member left
  memberLeft,

  ///gRPC stream disconnected
  disconnect,

  ///chat completed
  chatComplete,
}
