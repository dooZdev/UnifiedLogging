// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "UnifiedConsole",
    platforms: [.macOS(.v10_15)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "UnifiedConsole",
            targets: ["UnifiedConsole"]),
    ],
    dependencies: [
            // Used for android and the rest
            .package(url: "https://github.com/apple/swift-log.git", from: "1.0.0"),
            // Swift logging API with colored output, only used on windows, macOS and linux
            .package(url: "https://github.com/vapor/console-kit.git", .upToNextMajor(from: "4.2.4"))
        ],
    targets: [
        .target(
            name: "UnifiedConsole",
            dependencies:[
                .product(name: "ConsoleKit", package: "console-kit", condition: .when(platforms: [.macOS, .linux, .windows])),
                .product(name: "Logging", package: "swift-log", condition: .when(platforms: [.iOS, .android]))
            ]
        ),
        .testTarget(
            name: "UnifiedConsoleTests",
            dependencies: ["UnifiedConsole"]),
    ]
)
