// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "OrganizationManagement",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "OrganizationManagement",
            targets: ["OrganizationManagement"]),
    ],
    dependencies: [
        // Add a dependency on the local NetworkManagement package
        .package(path: "../NetworkManagement"),
        .package(path: "../SessionManagement")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "OrganizationManagement",
            dependencies: [
                // Specify that this target uses the NetworkManagement library
                .product(name: "NetworkManagement",
                         package: "NetworkManagement"),
                .product(name: "SessionManagement",
                         package: "SessionManagement")
            ]
        ),
        .testTarget(
            name: "OrganizationManagementTests",
            dependencies: ["OrganizationManagement"]
        ),
    ]
)
