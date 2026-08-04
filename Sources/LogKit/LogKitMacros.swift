@freestanding(expression)
public macro logMessage(_ message: Any) -> LogMessage =
  #externalMacro(module: "LogKitMacros", type: "LogMessageMacro")
