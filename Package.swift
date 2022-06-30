// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RxPropertyWrapper",
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "RxPropertyWrapper",
            targets: ["RxPropertyWrapper"]),
    ],
    dependencies: [
        .package(url: "https://github.com/ReactiveX/RxSwift.git", .upToNextMajor(from: "6.5.0")),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "RxPropertyWrapper",
//            dependencies: ["RxSwift"]
            dependencies: [.product(name: "RxSwift", package: "RxSwift"),
                           .product(name: "RxCocoa", package: "RxSwift"),
                           .product(name: "RxRelay", package: "RxSwift")]
        ),
        .testTarget(
            name: "RxPropertyWrapperTests",
            dependencies: ["RxPropertyWrapper",
                           .product(name: "RxSwift", package: "RxSwift"),
                           .product(name: "RxCocoa", package: "RxSwift"),
                           .product(name: "RxRelay", package: "RxSwift")]),
    ])
