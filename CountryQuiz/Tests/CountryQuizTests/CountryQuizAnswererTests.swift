//
//  Copyright © Juan Francisco Dorado Torres. All rights reserved.
//

import CountryQuiz
import Testing

struct CountryQuizAnswererTests {
  @Test func capital_deliversCapitalForMatchingCountry() {
    let countries = [
      Country(name: "Belgium", capital: "Brussels", code: "BE", flag: "🇧🇪")
    ]
    let sut = CountryQuizAnswerer()

    let result = sut.capital(for: "Belgium", in: countries)

    #expect(result == "Brussels")
  }

  @Test func capital_deliversNilForUnknownCountry() {
    let countries = [
      Country(name: "Belgium", capital: "Brussels", code: "BE", flag: "🇧🇪")
    ]
    let sut = CountryQuizAnswerer()

    let result = sut.capital(for: "Atlantis", in: countries)

    #expect(result == nil)
  }

  @Test func countriesStartingWith_deliversMatchingCountries() {
    let countries = [
      Country(name: "Chad", capital: "N'Djamena", code: "TD", flag: "🇹🇩"),
      Country(name: "Chile", capital: "Santiago", code: "CL", flag: "🇨🇱"),
      Country(name: "Belgium", capital: "Brussels", code: "BE", flag: "🇧🇪"),
    ]
    let sut = CountryQuizAnswerer()

    let result = sut.countries(startingWith: "Ch", in: countries)

    #expect(result == ["Chad", "Chile"])
  }

  @Test func countriesStartingWith_deliversEmptyForNoMatches() {
    let countries = [
      Country(name: "Belgium", capital: "Brussels", code: "BE", flag: "🇧🇪"),
    ]
    let sut = CountryQuizAnswerer()

    let result = sut.countries(startingWith: "ZZZ", in: countries)

    #expect(result.isEmpty)
  }
}
