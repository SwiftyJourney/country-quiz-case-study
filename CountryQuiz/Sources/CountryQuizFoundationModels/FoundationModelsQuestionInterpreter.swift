//
//  Copyright © Juan Francisco Dorado Torres. All rights reserved.
//

import CountryQuiz
import FoundationModels

public struct FoundationModelsQuestionInterpreter: QuestionInterpreter {
  public init() {}

  public func interpret(_ text: String) async throws -> CountryQuiz.QuestionType {
    let session = LanguageModelSession(instructions: """
      You are a question classifier for a country quiz app.
      Classify the user's question into one of these categories:
      - capital: asking about a country's capital city
      - countriesStartingWith: asking which countries start with certain letters
      - code: asking about a country's ISO alpha-2 code
      - flag: asking about a country's flag
      - unrecognized: the question doesn't fit any category
      
      Extract the country name or letter prefix as the parameter.
      Handle typos and varied phrasings. Correct misspelled country names.
      """)

    let result = try await session.respond(to: text, generating: ClassifiedQuestion.self)

    switch result.content.category {
    case .capital:
      return .capital(countryName: result.content.parameter)
    case .countriesStartingWith:
      return .countriesStartingWith(prefix: result.content.parameter)
    case .code:
      return .code(countryName: result.content.parameter)
    case .flag:
      return .flag(countryName: result.content.parameter)
    case .unrecognized:
      return .unrecognized
    }
  }
}

@Generable(description: "A classified country quiz question")
struct ClassifiedQuestion {
  @Guide(description: "Brief reasoning about what the question is asking")
  var reasoning: String

  @Guide(description: "The question category")
  var category: QuestionCategory

  @Guide(description: "The country name of letter prefix extracted from the question")
  var parameter: String
}

@Generable(description: "Category of a country quiz question")
enum QuestionCategory: String, CaseIterable {
  case capital
  case countriesStartingWith
  case code
  case flag
  case unrecognized
}
