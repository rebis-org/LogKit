import SwiftCompilerPlugin
public import SwiftSyntax
import SwiftSyntaxBuilder
public import SwiftSyntaxMacros

public struct LogMessageMacro: ExpressionMacro {
  public static func expansion(
    of node: some FreestandingMacroExpansionSyntax,
    in _: some MacroExpansionContext
  ) throws -> ExprSyntax {
    guard let first = node.arguments.first?.expression else {
      throw MacroError.requiresSingleArgument
    }

    return ExprSyntax(
      """
      LogMessage.osLog(using: { logger, type in
        logger.log(level: type, \(first))
      })
      """
    )
  }
}

@main
struct LogKitMacrosPlugin: CompilerPlugin {
  let providingMacros: [any Macro.Type] = [
    LogMessageMacro.self
  ]
}

enum MacroError: Error {
  case requiresSingleArgument
}
