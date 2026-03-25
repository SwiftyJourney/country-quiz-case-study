//
//  Copyright © Juan Francisco Dorado Torres. All rights reserved.
//

import Foundation

public struct Country: Equatable {
  public let name: String
  public let capital: String
  public let code: String
  public let flag: String

  public init(name: String, capital: String, code: String, flag: String) {
    self.name = name
    self.capital = capital
    self.code = code
    self.flag = flag
  }
}
