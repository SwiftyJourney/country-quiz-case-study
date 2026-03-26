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

  @Test func countriesStartingWith_matchesCaseInsensitive() {
    let countries = [
      Country(name: "Chile", capital: "Santiago", code: "CL", flag: "🇨🇱"),
    ]
    let sut = CountryQuizAnswerer()

    let result = sut.countries(startingWith: "ch", in: countries)

    #expect(result == ["Chile"])
  }

  @Test func code_deliversCodeForMatchingCountry() {
    let countries = [
      Country(name: "Greece", capital: "Athens", code: "GR", flag: "🇬🇷")
    ]
    let sut = CountryQuizAnswerer()

    let result = sut.code(for: "Greece", countries: countries)

    #expect(result == "GR")
  }

  @Test func code_deliversNilForUnknownCountry() {
    let countries = [
      Country(name: "Greece", capital: "Athens", code: "GR", flag: "🇬🇷")
    ]
    let sut = CountryQuizAnswerer()

    let result = sut.code(for: "Atlantis", countries: countries)

    #expect(result == nil)
  }

  @Test func flag_deliversFlagForMatchingCountry() {
    let countries = [
      Country(name: "Brazil", capital: "Brasília", code: "BR", flag: "🇧🇷"),
    ]
    let sut = CountryQuizAnswerer()

    let result = sut.flag(for: "Brazil", countries: countries)

    #expect(result == "🇧🇷")
  }

  @Test func flag_deliversNilForUnknownCountry() {
    let countries = [
      Country(name: "Brazil", capital: "Brasília", code: "BR", flag: "🇧🇷"),
    ]
    let sut = CountryQuizAnswerer()

    let result = sut.flag(for: "Atlantis", countries: countries)

    #expect(result == nil)
  }

  @Test func capital_matchesCaseInsensitive() {
    let countries = [
      Country(name: "Greece", capital: "Athens", code: "GR", flag: "🇬🇷"),
    ]
    let sut = CountryQuizAnswerer()

    let result = sut.capital(for: "greece", in: countries)

    #expect(result == "Athens")
  }

  @Test func code_matchesCaseInsensitive() {
    let countries = [
      Country(name: "Greece", capital: "Athens", code: "GR", flag: "🇬🇷"),
    ]
    let sut = CountryQuizAnswerer()

    let result = sut.code(for: "greece", countries: countries)

    #expect(result == "GR")
  }
}
