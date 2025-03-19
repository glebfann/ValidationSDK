// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "ValidationSDK",
  platforms: [
    .iOS(.v14),
    .macOS(.v11)
  ],
  products: [
    .library(
      name: "ValidationSDK",
      targets: ["ValidationSDK", "ValidationUI"]
    )
  ],
  dependencies: [
    .package(url: "https://github.com/glebfann/FunctionalPrimitives.git", from: "1.1.0"),
  ],
  targets: [
    .target(
      name: "ValidationSDK",
      path: "ValidationSDK"
    ),
    .target(
      name: "ValidationUI",
      dependencies: ["ValidationSDK", "FunctionalPrimitives"],
      path: "ValidationUI"
    ),
    .testTarget(
      name: "ValidationSDKTests",
      dependencies: ["ValidationSDK"],
      path: "Tests"
    ),
  ]
)
