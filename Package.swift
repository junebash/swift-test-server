// swift-tools-version:5.8
import PackageDescription

let package = Package(
  name: "TestServer",
  platforms: [
    .macOS(.v12)
  ],
  dependencies: [
    .package(
      url: "https://github.com/vapor/vapor.git",
      .upToNextMajor(from: Version(4, 76, 0))
    ),
    .package(
      url: "https://github.com/pointfreeco/swift-url-routing",
      .upToNextMajor(from: Version(0, 5, 0))
    ),
    .package(
      url: "https://github.com/pointfreeco/vapor-routing",
      .upToNextMajor(from: Version(0, 1, 3))
    )
  ],
  targets: [
    .executableTarget(
      name: "App",
      dependencies: [
        .product(name: "Vapor", package: "vapor"),
        .product(name: "URLRouting", package: "swift-url-routing"),
        .product(name: "VaporRouting", package: "vapor-routing"),
      ],
      swiftSettings: [
        // Enable better optimizations when building in Release configuration. Despite the use of
        // the `.unsafeFlags` construct required by SwiftPM, this flag is recommended for Release
        // builds. See <https://www.swift.org/server/guides/building.html#building-for-production>.
        .unsafeFlags(
          ["-cross-module-optimization"],
          .when(configuration: .release)
        )
      ]
    ),
    .testTarget(name: "AppTests", dependencies: [
      .target(name: "App"),
      .product(name: "XCTVapor", package: "vapor"),
    ])
  ]
)
