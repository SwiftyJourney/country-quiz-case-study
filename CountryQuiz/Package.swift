// swift-tools-version: 6.2

import PackageDescription

let defaultSwiftSettings: [SwiftSetting] = [
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
    ),
    .library(
      name: "CountryQuizAPI",
      targets: ["CountryQuizAPI"]
    )
  ],
  targets: [
    .target(
      name: "CountryQuiz",
      swiftSettings: defaultSwiftSettings
    ),
    .target(
      name: "CountryQuizFoundationModels",
      dependencies: ["CountryQuiz"],
      swiftSettings: defaultSwiftSettings
    ),
    .target(
      name: "CountryQuizAPI",
      dependencies: ["CountryQuiz"],
      swiftSettings: defaultSwiftSettings
    ),
    .executableTarget(
      name: "CountryQuizCLI",
      dependencies: [
        "CountryQuiz",
        "CountryQuizAPI",
        "CountryQuizFoundationModels"
      ],
      swiftSettings: defaultSwiftSettings
    ),
    .testTarget(
      name: "CountryQuizTests",
      dependencies: ["CountryQuiz"]
    ),
    .testTarget(
      name: "CountryQuizAPITests",
      dependencies: ["CountryQuizAPI"]
    )
  ],
  swiftLanguageModes: [.v6]
)
