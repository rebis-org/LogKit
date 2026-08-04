public struct LogLocation: Sendable {
  public let fileID: String
  public let function: String
  public let line: UInt32

  public init(fileID: String, function: String, line: UInt32) {
    self.fileID = fileID
    self.function = function
    self.line = line
  }
}
