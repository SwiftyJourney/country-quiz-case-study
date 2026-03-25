//
//  Copyright © Juan Francisco Dorado Torres. All rights reserved.
//

import Foundation

public protocol QuestionInterpreter: Sendable {
  func interpret(_ text: String) async throws -> QuestionType
}
