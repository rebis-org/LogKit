public struct LogIdentity: Sendable, Hashable {
  public let subsystem: String
  public let category: String

  public init(subsystem: String, category: String) {
    self.subsystem = subsystem.normalizedLogComponent(label: "subsystem")
    self.category = category.normalizedLogComponent(label: "category")
  }
}

extension String {
  // Trims via Unicode.Scalar.Properties.isWhitespace (Unicode binary property
  // White_Space). This matches CharacterSet.whitespacesAndNewlines on every
  // White_Space scalar (U+0009..U+000D, U+0020, U+0085, U+00A0, U+1680,
  // U+2000..U+200A, U+2028, U+2029, U+202F, U+205F, U+3000), but diverges on
  // U+200B (ZERO WIDTH SPACE): Foundation strips it, isWhitespace does not.
  // ZWSP is a default-ignorable format control, not White_Space, so the walk
  // keeps it as content. The scalar walk is also stdlib-only (no Foundation
  // dependency) and short-circuits to `self` when nothing needs trimming.
  internal func normalizedLogComponent(label: StaticString) -> String {
    let scalars = self.unicodeScalars
    var start = scalars.startIndex
    var end = scalars.endIndex

    while start < end, scalars[start].properties.isWhitespace {
      start = scalars.index(after: start)
    }

    while start < end {
      let beforeEnd = scalars.index(before: end)
      if scalars[beforeEnd].properties.isWhitespace {
        end = beforeEnd
      } else {
        break
      }
    }

    if start == scalars.startIndex, end == scalars.endIndex {
      precondition(!self.isEmpty, "LogKit: \(label) cannot be empty or whitespace-only.")
      return self
    }

    let trimmed = String(scalars[start..<end])
    precondition(!trimmed.isEmpty, "LogKit: \(label) cannot be empty or whitespace-only.")
    return trimmed
  }
}
