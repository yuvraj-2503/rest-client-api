// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "rest-client-api",
    platforms: [
        .macOS(.v12), .iOS(.v14)
    ],
    products: [
        .library(
            name: "rest-client-api",
            targets: ["rest-client-api"]
        ),
    ],
    dependencies: [
        // ✅ Your GitHub Swift Package Dependency
        .package(url: "https://github.com/yuvraj-2503/util-swift-sdk", exact: "1.0.2"),
    ],
    targets: [
        .target(
            name: "rest-client-api",
            dependencies: [
                // ✅ Declare dependency on the package product/module
                .product(name: "util", package: "util-swift-sdk")
            ]
        ),
        .testTarget(
            name: "rest_client_apiTests",
            dependencies: ["rest-client-api",
                           .product(name: "util", package: "util-swift-sdk")]
        ),
    ]
)
