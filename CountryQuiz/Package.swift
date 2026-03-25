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
      name: "CountryQuiz"
    ),
    .testTarget(name: "CountryQuizTests", dependencies: ["CountryQuiz"])
  ]
)
