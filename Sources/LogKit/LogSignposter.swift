public struct Signposter: Sendable {
  public typealias BeginInterval =
    @Sendable (_ name: StaticString, _ id: SignpostID?) -> SignpostInterval
  public typealias EmitEvent =
    @Sendable (_ name: StaticString, _ id: SignpostID?) -> Void

  private let beginIntervalImpl: BeginInterval
  private let emitEventImpl: EmitEvent

  public init(
    beginInterval: @escaping BeginInterval,
    emitEvent: @escaping EmitEvent
  ) {
    self.beginIntervalImpl = beginInterval
    self.emitEventImpl = emitEvent
  }

  public func beginInterval(named name: StaticString, id: SignpostID? = nil) -> SignpostInterval {
    beginIntervalImpl(name, id)
  }

  public func emitEvent(named name: StaticString, id: SignpostID? = nil) {
    emitEventImpl(name, id)
  }

  public static let disabled: Self = .init(
    beginInterval: { _, _ in SignpostInterval {} },
    emitEvent: { _, _ in }
  )
}

public struct SignpostID: Sendable, Hashable {
  public let rawValue: UInt64

  public init(rawValue: UInt64) {
    self.rawValue = rawValue
  }
}

public struct SignpostInterval: Sendable, ~Copyable {
  private let endImpl: @Sendable () -> Void

  internal init(end: @escaping @Sendable () -> Void) {
    self.endImpl = end
  }

  public consuming func end() {
    endImpl()
  }
}
