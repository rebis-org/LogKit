public import os

public struct LogMessage: Sendable {
  public typealias OSLogEmitter = @Sendable (_ logger: os.Logger, _ type: os.OSLogType) -> Void

  internal let emit: OSLogEmitter

  internal init(emit: @escaping OSLogEmitter) {
    self.emit = emit
  }

  public static func osLog(using body: @escaping OSLogEmitter) -> Self {
    Self(emit: body)
  }
}
