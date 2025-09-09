// swift-tools-version: 6.0

import PackageDescription

let package = Package(
  name: "BlindLogWeb",
  platforms: [
    .macOS(.v15)
  ],
  products: [
    .executable(
      name: "Server",
      targets: ["Server"]
    )
  ],
  dependencies: [
    .package(url: "https://github.com/apple/swift-argument-parser.git", from: "1.0.0"),
    .package(url: "https://github.com/hummingbird-project/hummingbird.git", from: "2.0.0"),
  ],
  targets: [
    .executableTarget(
      name: "Server",
      dependencies: [
        .product(name: "ArgumentParser", package: "swift-argument-parser"),
        .product(name: "Hummingbird", package: "hummingbird"),
      ]
    ),
  ]
)
