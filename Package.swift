// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "ContributionChart",
    platforms: [
        .iOS(.v15), .macOS(.v12), .tvOS(.v15), .watchOS(.v8)
    ],
    products: [
        .library(
            name: "ContributionChart",
            targets: ["ContributionChart"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "ContributionChart",
            dependencies: [],
            resources: [
                .copy("PrivacyInfo.xcprivacy")
            ]
        )
    ]
)
