//
//  Copyright © Juan Francisco Dorado Torres. All rights reserved.
//

public struct CountryQuizAnswerer: Sendable {
  public init() {}

  public func capital(for countryName: String, in countries: [Country]) -> String? {
    countries.first { $0.name == countryName }?.capital
  }
}
