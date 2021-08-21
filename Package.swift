// swift-tools-version:5.3

import PackageDescription

let package = Package(
  name: "InFa",
  platforms: [
    .iOS(.v10)
  ],
  products: [
    .library(name: "InFa", targets: ["InFa"]),
  ],
  targets: [
    .target(name: "InFa", path: "Sources"),
  ],
  swiftLanguageVersions: [
    .v5
  ]
)
