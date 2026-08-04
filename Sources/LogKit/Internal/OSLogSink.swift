import os

#if canImport(Synchronization)
  import struct Synchronization.Mutex
#endif

internal protocol LogCache: Sendable {
  func withLock<R: Sendable>(
    _ body: @Sendable (inout [LogIdentity: os.Logger]) throws -> sending R
  ) rethrows -> R
}

internal struct UnfairLockCache: LogCache {
  private let lock = OSAllocatedUnfairLock(initialState: [LogIdentity: os.Logger]())

  internal func withLock<R: Sendable>(
    _ body: @Sendable (inout [LogIdentity: os.Logger]) throws -> sending R
  ) rethrows -> R {
    try lock.withLock { cache in
      try body(&cache)
    }
  }
}

#if canImport(Synchronization)
  @available(
    macOS 15, iOS 18, tvOS 18, watchOS 11, macCatalyst 18, visionOS 2, *
  )
  internal final class MutexCache: LogCache {
    private let mutex = Mutex([LogIdentity: os.Logger]())

    internal func withLock<R: Sendable>(
      _ body: @Sendable (inout [LogIdentity: os.Logger]) throws -> sending R
    ) rethrows -> R {
      try mutex.withLock(body)
    }
  }
#endif

internal final class OSLogSink: LogSink {
  private let cache: any LogCache

  internal init() {
    #if canImport(Synchronization)
      if #available(macOS 15, iOS 18, tvOS 18, watchOS 11, macCatalyst 18, visionOS 2, *) {
        self.cache = MutexCache()
      } else {
        self.cache = UnfairLockCache()
      }
    #else
      self.cache = UnfairLockCache()
    #endif
  }

  internal func submit(_ record: borrowing LogRecord) {
    let identity = record.identity

    let logger = cache.withLock { cache -> os.Logger in
      if let existing = cache[identity] { return existing }
      let created = os.Logger(subsystem: identity.subsystem, category: identity.category)
      cache[identity] = created
      return created
    }

    switch record.channel {
    case .level(let level):
      record.message.emit(logger, level.osLogType)

    case .writer(let writer):
      writer(logger, record.message)
    }
  }
}
