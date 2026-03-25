//
//  Copyright © Juan Francisco Dorado Torres. All rights reserved.
//

import CountryQuiz
import FoundationModels

public struct FoundationModelsQuestionInterpreter: QuestionInterpreter {
  public init() {}

  public func interpret(_ text: String) async throws -> CountryQuiz.QuestionType {
    fatalError("TODO")
  }
}
