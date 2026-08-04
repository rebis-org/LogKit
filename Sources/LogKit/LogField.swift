public enum LogPrivacy: Sendable, Equatable {
  case `public`
  case `private`
  case sensitive
}

public struct LogField: Sendable, Equatable {
  public var key: String
  public var value: String
  public var privacy: LogPrivacy

  public init(key: String, value: String, privacy: LogPrivacy = .public) {
    self.key = key
    self.value = value
    self.privacy = privacy
  }
}
