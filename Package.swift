// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CFG",
    platforms: [
        .macOS(.v10_13), .iOS(.v11)
    ],
    products: [
        .library(
            name: "CFG",
            targets: ["CFG"]),
        .executable(name: "demo1",
                    targets: ["Demo1"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "CFG",
            dependencies: []),
        .target(name: "Demo1",
                dependencies: ["CFG"]),
        .testTarget(
            name: "CFGTests",
            dependencies: ["CFG"]),
    ]
)
