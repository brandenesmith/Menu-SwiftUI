// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Menu-SwiftUI",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "Menu-SwiftUI",
            targets: ["Menu-SwiftUI"])
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(
            url: "https://github.com/brandenesmith/Swixtensions.git",
            .branch("feature/AnimationCompletionModifier")
        )
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "Menu-SwiftUI",
            dependencies: ["Swixtensions"]),
        .testTarget(
            name: "Menu-SwiftUITests",
            dependencies: ["Menu-SwiftUI"])
    ]
)
