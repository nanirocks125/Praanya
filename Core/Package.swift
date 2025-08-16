// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Core",
    platforms: [.macOS(.v15), .iOS(.v18)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(name: "Networking", targets: ["Networking"]),
        .library(name: "Authentication", targets: ["Authentication"]),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
                .target(
                    name: "Networking"),
                .target(
                    name: "Authentication",
                    dependencies: ["Networking"]), // Authentication depends on Networking
                .testTarget(
                    name: "CoreTests",
                    dependencies: ["Networking", "Authentication"]),
    ]
)
