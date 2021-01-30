// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "AdaptiveCardUI",
    defaultLocalization: "en",
    platforms: [
        .macOS(.v10_12),
        .iOS(.v11),
        .tvOS(.v11),
        .watchOS(.v3),
    ],
    products: [
        .library(
            name: "AdaptiveCard",
            targets: ["AdaptiveCard"]
        ),
        .library(
            name: "AdaptiveCardUI",
            targets: ["AdaptiveCardUI"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/gonzalezreal/DefaultCodable", from: "1.2.0"),
        .package(url: "https://github.com/gonzalezreal/AnyValue", from: "1.0.0"),
        .package(url: "https://github.com/gonzalezreal/NetworkImage", from: "1.1.1"),
        .package(url: "https://github.com/pointfreeco/combine-schedulers", from: "0.1.2"),
        .package(name: "SnapshotTesting", url: "https://github.com/pointfreeco/swift-snapshot-testing", from: "1.8.1"),
    ],
    targets: [
        .target(
            name: "AdaptiveCard",
            dependencies: [
                "DefaultCodable",
                "AnyValue",
            ]
        ),
        .testTarget(
            name: "AdaptiveCardTests",
            dependencies: [
                "AdaptiveCard",
            ]
        ),
        .target(
            name: "AdaptiveCardUI",
            dependencies: [
                "AdaptiveCard",
                "NetworkImage",
                .product(name: "CombineSchedulers", package: "combine-schedulers"),
            ]
        ),
        .testTarget(
            name: "AdaptiveCardUITests",
            dependencies: [
                "AdaptiveCardUI",
                "SnapshotTesting",
            ],
            exclude: ["UI/__Fixtures__", "UI/__Snapshots__"]
        ),
    ]
)
