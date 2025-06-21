// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "rest-client-api",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "rest-client-api",
            targets: ["rest-client-api"]),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "rest-client-api"),
        .testTarget(
            name: "rest-client-apiTests",
            dependencies: ["rest-client-api"]
        ),
    ]
)
