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
