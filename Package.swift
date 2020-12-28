// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "UnifiedLogging",
    platforms: [.macOS(.v10_15)],
    products: [
        .library(name: "UnifiedLogging", targets: ["UnifiedLogging"]),
    ],
    dependencies: [
            // Used for android and the rest
            .package(url: "https://github.com/apple/swift-log.git", from: "1.0.0")
        ],
    targets: [
        .target(name: "UnifiedLogging", dependencies: [.product(name: "Logging", package: "swift-log")]),
        .testTarget(
            name: "UnifiedLoggingTests",
            dependencies: ["UnifiedLogging"]),
    ]
)
