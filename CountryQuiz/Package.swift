// swift-tools-version: 6.2

import PackageDescription

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
      swiftSettings: [
        .enableUpcomingFeature("ApproachableConcurrency"),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableUpcomingFeature("InferIsolatedConformances")
      ]
    ),
    .target(
      name: "CountryQuizFoundationModels",
      dependencies: ["CountryQuiz"],
      swiftSettings: [
        .enableUpcomingFeature("ApproachableConcurrency"),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableUpcomingFeature("InferIsolatedConformances")
      ]
    ),
    .testTarget(name: "CountryQuizTests", dependencies: ["CountryQuiz"])
  ],
  swiftLanguageModes: [.v6]
)
