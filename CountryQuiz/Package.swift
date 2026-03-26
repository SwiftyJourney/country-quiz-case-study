// swift-tools-version: 6.2

import PackageDescription

let swiftSettings: [SwiftSetting] = [
  .enableUpcomingFeature("ApproachableConcurrency"),
  .enableUpcomingFeature("ExistentialAny"),
  .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
  .enableUpcomingFeature("InferIsolatedConformances")
]

let package = Package(
  name: "CountryQuiz",
  platforms: [
    .iOS(.v26),
    .macOS(.v26)
  ],
  products: [
    .library(
      name: "CountryQuiz",
      targets: ["CountryQuiz"]
    ),
    .library(
      name: "CountryQuizFoundationModels",
      targets: ["CountryQuizFoundationModels"]
    )
  ],
  targets: [
    .target(
      name: "CountryQuiz",
      swiftSettings: swiftSettings
    ),
    .target(
      name: "CountryQuizFoundationModels",
      dependencies: ["CountryQuiz"],
      swiftSettings: swiftSettings
    ),
    .testTarget(name: "CountryQuizTests", dependencies: ["CountryQuiz"])
  ],
  swiftLanguageModes: [.v6]
)
