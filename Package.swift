// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "MakaraAPI",
    platforms: [
        .macOS(.v10_15),
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "MakaraAPI",
            targets: ["MakaraAPI"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "MakaraAPI",
            dependencies: []),
        .testTarget(
            name: "MakaraAPITests",
            dependencies: ["MakaraAPI"]),
    ]
)
