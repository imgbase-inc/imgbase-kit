// swift-tools-version: 5.5

import PackageDescription

let package = Package(
    name: "imgbase-kit",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "ImgBaseUI",
            targets: ["ImgBaseUI"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "ImgBaseUI",
            dependencies: [],
            path: "ImgBaseUI"
        ),
    ]
)
