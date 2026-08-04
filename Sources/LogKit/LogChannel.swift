public import os

public enum LogLevel: Sendable {
  case debug
  case info
  case `default`
  case error
  case fault

  internal var osLogType: os.OSLogType {
    switch self {
    case .debug: return .debug
    case .info: return .info
    case .default: return .default
    case .error: return .error
    case .fault: return .fault
    }
  }
}

public enum LogChannel: Sendable {
  public typealias OSLogWriter = @Sendable (_ logger: os.Logger, _ message: LogMessage) -> Void

  case level(LogLevel)
  case writer(OSLogWriter)
}
