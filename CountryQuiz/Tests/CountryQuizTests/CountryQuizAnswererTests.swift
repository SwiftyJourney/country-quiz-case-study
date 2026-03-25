//
//  Copyright © Juan Francisco Dorado Torres. All rights reserved.
//

import CountryQuiz
import Testing

struct CountryQuizAnswerer: Sendable {
  func capital(for countryName: String, in countries: [Country]) -> String? {
    countries.first { $0.name == countryName }?.capital
  }
}

struct CountryQuizAnswererTests {
  @Test func capital_deliversCapitalForMatchingCountry() {
    let countries = [
      Country(name: "Belgium", capital: "Brussels", code: "BE", flag: "🇧🇪")
    ]
    let sut = CountryQuizAnswerer()

    let result = sut.capital(for: "Belgium", in: countries)

    #expect(result == "Brussels")
  }
}
