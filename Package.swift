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
    dependencies: {
        var dependencies: [Package.Dependency] = [
            .package(url: "https://github.com/apple/swift-log.git", from: "1.0.0"),
        ]
        
        #if os(macOS) || os(Linux) || os(Windows)
        dependencies.append(
            // Swift logging API with colored output
            .package(url: "https://github.com/vapor/console-kit.git", .upToNextMajor(from: "4.2.4"))
        )
        #endif
        return dependencies
    }(),
    targets: [
        .target(
            name: "UnifiedConsole",
            dependencies: {
                var dependencies = [Target.Dependency]()
                
                #if os(macOS) || os(Linux) || os(Windows)
                dependencies.append(
                    // Swift logging API with colored output
                    .package(url: "https://github.com/vapor/console-kit.git", .upToNextMajor(from: "4.2.4"))
                )
                #else
                
                #endif
            }()
                
        ),
        .testTarget(
            name: "UnifiedConsoleTests",
            dependencies: ["UnifiedConsole"]),
    ]
)
