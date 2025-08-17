// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Authentication",
    platforms: [.macOS(.v15), .iOS(.v18)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Authentication",
            targets: ["Authentication"]),
    ],
    dependencies: [
        // Add a dependency on the local NetworkManagement package
        .package(path: "../NetworkManagement"),
        .package(path: "../SessionManagement"),
        .package(path: "../UserManagement")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Authentication",
            dependencies: [
                // Specify that this target uses the NetworkManagement library
                .product(name: "NetworkManagement", package: "NetworkManagement"),
                .product(name: "SessionManagement", package: "SessionManagement"),
                .product(name: "UserManagement", package: "UserManagement")
            ]
        ),
        .testTarget(
            name: "AuthenticationTests",
            dependencies: ["Authentication"]
        ),
    ]
)
