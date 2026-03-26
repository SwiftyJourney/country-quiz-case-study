//
//  Copyright © Juan Francisco Dorado Torres. All rights reserved.
//

import CountryQuiz
import Testing

struct QuizServiceTests {
  @Test func answer_deliversCapitalForCapitalQuestion() async throws {
    let countries = [Country(name: "Belgium", capital: "Brussels", code: "BE", flag: "🇧🇪")]
    let sut = makeSUT(
      interpretResult: .capital(countryName: "Belgium"),
      loadResult: countries
    )

    let answer = try await sut.answer("What is the capital of Belgium?")

    #expect(answer == "The capital of Belgium is Brussels.")
  }

  @Test func answer_deliversNotFoundForUnknownCountry() async throws {
    let sut = makeSUT(
      interpretResult: .capital(countryName: "Atlantis"),
      loadResult: []
    )

    let answer = try await sut.answer("What is the capital of Atlantis?")

    #expect(answer == "Sorry, I couldn't find a country named Atlantis.")
  }

  @Test func answer_deliversCountriesForPrefixQuestion() async throws {
    let countries = [
      Country(name: "Chad", capital: "N'Djamena", code: "TD", flag: "🇹🇩"),
      Country(name: "Chile", capital: "Santiago", code: "CL", flag: "🇨🇱"),
      Country(name: "Belgium", capital: "Brussels", code: "BE", flag: "🇧🇪"),
    ]

    let sut = makeSUT(
      interpretResult: .countriesStartingWith(prefix: "Ch"),
      loadResult: countries
    )

    let answer = try await sut.answer("What countries start with CH?")

    #expect(answer == "Chad, Chile")
  }

  @Test func answer_deliversNoMatchesForPrefixQuestion() async throws {
    let sut = makeSUT(
      interpretResult: .countriesStartingWith(prefix: "ZZZ"),
      loadResult: []
    )

    let answer = try await sut.answer("What countries start with ZZZ?")

    #expect(answer == "No countries found starting with ZZZ.")
  }

  // MARK: - Helpers

  private func makeSUT(interpretResult: QuestionType, loadResult: [Country]) -> QuizService {
    let interpreter = QuestionInterpreterStub(result: interpretResult)
    let loader = CountryLoaderStub(result: loadResult)
    return QuizService(interpreter: interpreter, loader: loader)
  }

  private final class QuestionInterpreterStub: QuestionInterpreter, @unchecked Sendable {
    private let result: QuestionType

    init(result: QuestionType) {
      self.result = result
    }

    func interpret(_ text: String) async throws -> QuestionType {
      result
    }
  }

  private final class CountryLoaderStub: CountryLoader, @unchecked Sendable {
    private let result: [Country]

    init(result: [Country]) {
      self.result = result
    }

    func load() async throws -> [Country] {
      result
    }
  }
}
