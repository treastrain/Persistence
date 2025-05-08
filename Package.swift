// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "Persistence",
    products: [
        .library(
            name: "Persistence",
            targets: ["Persistence"]
        )
    ],
    targets: [
        .target(
            name: "Persistence"
        ),
        .testTarget(
            name: "PersistenceTests",
            dependencies: ["Persistence"]
        ),
    ],
    swiftLanguageModes: [.v6]
)
