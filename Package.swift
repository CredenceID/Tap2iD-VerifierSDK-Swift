// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Tap2iD-VerifyerSDK-Swift",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Tap2iD-VerifyerSDK-Swift",
            targets: ["Tap2iD-VerifierSDK", "Identity-Utils"]),
    ],
    dependencies: [
        .package(url: "https://github.com/krzyzanowskim/OpenSSL.git", from: "3.1.5004")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.

        .binaryTarget(
            name: "Tap2iD-VerifierSDK",
            path: "./Sources/Tap2iD-VerifierSDK.xcframework"
        ),
        .target(
            name: "Identity-Utils",
            dependencies: ["OpenSSL"])
    ]
)
