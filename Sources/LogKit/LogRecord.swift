public struct LogRecord: Sendable {
  public let identity: LogIdentity
  public let message: LogMessage
  public let channel: LogChannel
  public let location: LogLocation
  public let metadata: [String: String]
  public let fields: [LogField]
  public let timestamp: ContinuousClock.Instant

  internal init(
    identity: LogIdentity,
    message: LogMessage,
    channel: LogChannel,
    location: LogLocation,
    metadata: [String: String] = [:],
    fields: [LogField] = [],
    timestamp: ContinuousClock.Instant
  ) {
    self.identity = identity
    self.message = message
    self.channel = channel
    self.location = location
    self.metadata = metadata
    self.fields = fields
    self.timestamp = timestamp
  }
}
