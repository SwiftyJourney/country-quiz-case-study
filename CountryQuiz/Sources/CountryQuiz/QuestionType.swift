//
//  Copyright © Juan Francisco Dorado Torres. All rights reserved.
//

import Foundation

public enum QuestionType: Equatable {
  case capital(countryName: String)
  case countriesStartingWith(prefix: String)
  case code(countryName: String)
  case flag(countryName: String)
  case unrecognized
}
