// swift-tools-version: 5.5

import PackageDescription

let package = Package(
    name: "imgbase-kit",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "ImgBaseUI",
            targets: ["ImgBaseUI"]
        ),
        .library(
            name: "IMProgressHUD",
            targets: ["IMProgressHUD"]
        )
    ],
    dependencies: [],
    targets: [
        .target(
            name: "ImgBaseUI",
            dependencies: [],
            path: "Sources/ImgBaseUI"
        ),
        .testTarget(
            name: "ImgBaseUITests",
            dependencies: [],
            path: "Tests"
        ),
        .target(
            name: "IMProgressHUD",
            dependencies: [],
            path: "Sources/IMProgressHUD"
        )
    ]
)
