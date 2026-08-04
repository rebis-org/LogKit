public struct Logger: Sendable, ~Copyable {
  public let identity: LogIdentity

  private let sink: any LogSink
  private let clock: ContinuousClock
  private let cachedSignposter: Signposter

  public init(
    identity: LogIdentity,
    sink: any LogSink,
    clock: ContinuousClock = ContinuousClock()
  ) {
    self.identity = identity
    self.sink = sink
    self.clock = clock
    self.cachedSignposter = OSLogSignposter.make(identity: identity)
  }

  public func log(
    _ message: LogMessage,
    via channel: LogChannel,
    location: LogLocation = LogLocation(fileID: #fileID, function: #function, line: #line),
    metadata: [String: String] = [:],
    fields: [LogField] = []
  ) {
    sink.submit(
      LogRecord(
        identity: identity,
        message: message,
        channel: channel,
        location: location,
        metadata: metadata,
        fields: fields,
        timestamp: clock.now
      )
    )
  }

  public func flush() {
    sink.flush()
  }

  public func signposter() -> Signposter {
    cachedSignposter
  }

  public static func osLog(
    identity: LogIdentity,
    clock: ContinuousClock = ContinuousClock()
  ) -> Self {
    Self(identity: identity, sink: OSLogSink(), clock: clock)
  }
}
