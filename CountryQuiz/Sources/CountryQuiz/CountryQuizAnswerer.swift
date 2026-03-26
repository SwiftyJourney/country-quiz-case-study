//
//  Copyright © Juan Francisco Dorado Torres. All rights reserved.
//

public struct CountryQuizAnswerer {
  public init() {}

  public func capital(for countryName: String, in countries: [Country]) -> String? {
    countries.first { $0.name.lowercased() == countryName.lowercased() }?.capital
  }

  public func countries(startingWith prefix: String, in countries: [Country]) -> [String] {
    countries
      .filter { $0.name.lowercased().hasPrefix(prefix.lowercased()) }
      .map(\.name)
  }

  public func code(for countryName: String, countries: [Country]) -> String? {
    countries.first { $0.name.lowercased() == countryName.lowercased() }?.code
  }

  public func flag(for countryName: String, countries: [Country]) -> String? {
    countries.first { $0.name.lowercased() == countryName.lowercased() }?.flag
  }
}
