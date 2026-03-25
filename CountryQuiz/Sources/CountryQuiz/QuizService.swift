//
//  Copyright © Juan Francisco Dorado Torres. All rights reserved.
//

import Foundation

public struct QuizService {
  private let interpreter: any QuestionInterpreter
  private let loader: any CountryLoader
  private let answerer = CountryQuizAnswerer()

  public init(interpreter: any QuestionInterpreter, loader: any CountryLoader) {
    self.interpreter = interpreter
    self.loader = loader
  }

  public func answer(_ text: String) async throws -> String {
    let question = try await interpreter.interpret(text)
    let countries = try await loader.load()

    switch question {
    case .capital(let name):
      guard let capital = answerer.capital(for: name, in: countries) else {
        return "Sorry, I couldn't find a country named \(name)."
      }
      return "The capital of \(name) is \(capital)."

    case .countriesStartingWith(let prefix):
      let matches = answerer.countries(startingWith: prefix, in: countries)
      if matches.isEmpty {
        return "No countries found starting with \(prefix)."
      }
      return matches.joined(separator: ", ")

    case .code(let name):
      guard let code = answerer.code(for: name, countries: countries) else {
        return "Sorry, I couldn't find a country named \(name)."
      }
      return "The ISO alpha-2 code for \(name) is \(code)."

    case .flag(let name):
      guard let flag = answerer.flag(for: name, countries: countries) else {
        return "Sorry, I couldn't find a country named \(name)."
      }
      return "The flag of \(name) is \(flag)"

    case .unrecognized:
      return "I can answer questions about: capitals, country codes, flags, and countries starting with specific letters."
    }
  }
}
