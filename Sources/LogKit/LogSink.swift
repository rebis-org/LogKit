public protocol LogSink: Sendable {
  func submit(_ record: borrowing LogRecord)
  func flush()
}

extension LogSink {
  public func flush() {}
}
