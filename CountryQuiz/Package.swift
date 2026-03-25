// swift-tools-version: 6.2

import PackageDescription

let package = Package(
  name: "CountryQuiz",
  products: [
    .library(
      name: "CountryQuiz",
      targets: ["CountryQuiz"]
    ),
  ],
  targets: [
    .target(
      name: "CountryQuiz",
      swiftSettings: [
        .enableUpcomingFeature("ApproachableConcurrency"),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("NonisolatedNonsendigByDefault"),
        .enableUpcomingFeature("InferIsolatedConformances")
      ]
    ),
    .testTarget(name: "CountryQuizTests", dependencies: ["CountryQuiz"])
  ],
  swiftLanguageModes: [.v6]
)
