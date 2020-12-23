// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "UnifiedConsoleBuildTools",
    platforms: [.macOS("10.15")],
    products: [.executable(name: "UnifiedConsole-spm-pipes", targets: ["UnifiedConsoleSPMPipes"]),],
    dependencies: [
        .package(url: "https://github.com/dooZdev/SPMPipes.git", from: "0.0.1-alpha")
    ],
    targets: [
        // 🛠 You can alter the executable if you like to run more/less scripts
        .target(
            name: "UnifiedConsoleSPMPipes",
            dependencies: [.product(name: "SPMPipes", package: "SPMPipes")]),
    ]
)

