public struct LogSource: Sendable {
  public typealias Entries = @Sendable (LogQuery) async throws -> [LogEntry]

  private let entriesImpl: Entries

  public init(entries: @escaping Entries) {
    self.entriesImpl = entries
  }

  public func entries(matching query: LogQuery) async throws -> [LogEntry] {
    try await entriesImpl(query)
  }
}

public struct LogQuery: Sendable {
  public var identity: LogIdentity?
  public var startEpochSeconds: Double?
  public var endEpochSeconds: Double?
  public var maximumEntries: Int

  public init(
    identity: LogIdentity? = nil,
    startEpochSeconds: Double? = nil,
    endEpochSeconds: Double? = nil,
    maximumEntries: Int = 1_000
  ) {
    self.identity = identity
    self.startEpochSeconds = startEpochSeconds
    self.endEpochSeconds = endEpochSeconds
    self.maximumEntries = maximumEntries
  }
}

public struct LogEntry: Sendable {
  public var epochSeconds: Double
  public var identity: LogIdentity
  public var message: String
  public var process: String?
  public var pid: Int?
  public var threadID: UInt64?
  public var activityID: UInt64?

  public init(
    epochSeconds: Double,
    identity: LogIdentity,
    message: String,
    process: String? = nil,
    pid: Int? = nil,
    threadID: UInt64? = nil,
    activityID: UInt64? = nil
  ) {
    self.epochSeconds = epochSeconds
    self.identity = identity
    self.message = message
    self.process = process
    self.pid = pid
    self.threadID = threadID
    self.activityID = activityID
  }
}
