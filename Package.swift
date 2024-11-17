// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ValidationSDK",
    products: [
        .library(
            name: "ValidationSDK",
            targets: ["ValidationSDK"]
        )
    ],
    targets: [
        .target(
            name: "ValidationSDK"
        ),
        .testTarget(
            name: "ValidationSDKTests",
            dependencies: ["ValidationSDK"]
        ),
    ]
)
