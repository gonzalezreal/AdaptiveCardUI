// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "AdaptiveCardUI",
    platforms: [
        .macOS(.v10_12),
        .iOS(.v11),
        .tvOS(.v11),
        .watchOS(.v3),
    ],
    products: [
        .library(
            name: "AdaptiveCardUI",
            targets: ["AdaptiveCardUI"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/gonzalezreal/SwiftAdaptiveCards", .branch("main")),
        .package(
            name: "SnapshotTesting",
            url: "https://github.com/pointfreeco/swift-snapshot-testing",
            from: "1.8.2"
        ),
    ],
    targets: [
        .target(
            name: "AdaptiveCardUI",
            dependencies: [
                .product(name: "AdaptiveCards", package: "SwiftAdaptiveCards"),
            ]
        ),
        .testTarget(
            name: "AdaptiveCardUITests",
            dependencies: ["AdaptiveCardUI", "SnapshotTesting"],
            exclude: ["__Snapshots__"]
        ),
    ]
)
