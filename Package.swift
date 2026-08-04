// swift-tools-version: 6.4

import CompilerPluginSupport
import PackageDescription

private enum Constants {
  static let swiftSettings: [SwiftSetting] = [
    .treatAllWarnings(as: .error),
    .strictMemorySafety(),
  ]
}

let package = Package(
  name: "LogKit",
  platforms: [
    .iOS(.v16),
    .macOS(.v13),
    .tvOS(.v16),
    .watchOS(.v9),
    .visionOS(.v1),
    .macCatalyst(.v16),
  ],
  products: [
    .library(
      name: "LogKit",
      targets: ["LogKit"]
    )
  ],
  dependencies: [
    .package(
      url: "https://github.com/swiftlang/swift-syntax.git", exact: "604.0.0-prerelease-2026-06-05")
  ],
  targets: [
    .target(
      name: "LogKit",
      dependencies: [
        "LogKitMacros"
      ],
      swiftSettings: Constants.swiftSettings
    ),
    .macro(
      name: "LogKitMacros",
      dependencies: [
        .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
        .product(name: "SwiftCompilerPlugin", package: "swift-syntax"),
        .product(name: "SwiftSyntax", package: "swift-syntax"),
        .product(name: "SwiftSyntaxBuilder", package: "swift-syntax"),
      ],
      swiftSettings: Constants.swiftSettings
    ),
  ],
  swiftLanguageModes: [.v6]
)
