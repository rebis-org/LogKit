import os

internal enum OSLogSignposter {
  internal static func make(identity: LogIdentity) -> Signposter {
    let signposter = OSSignposter(subsystem: identity.subsystem, category: identity.category)

    return Signposter(
      beginInterval: { name, id in
        let state = signposter.beginInterval(name, id: makeID(id))
        return SignpostInterval { signposter.endInterval(name, state) }
      },
      emitEvent: { name, id in
        signposter.emitEvent(name, id: makeID(id))
      }
    )
  }

  private static func makeID(_ id: SignpostID?) -> OSSignpostID {
    id.map { OSSignpostID($0.rawValue) } ?? .exclusive
  }
}
