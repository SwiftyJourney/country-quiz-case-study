//
//  Copyright © Juan Francisco Dorado Torres. All rights reserved.
//

import Foundation

enum CountryMapper {
  private struct RemoteCountry: Decodable {
    let name: Name
    let capital: [String]?
    let cca2: String
    let flag: String

    struct Name: Decodable {
      let common: String
    }
  }

  static func map(_ data: Data) throws -> [Country] {
    let remote = try JSONDecoder().decode([RemoteCountry].self, from: data)
    return remote.map {
      Country(
        name: $0.name.common,
        capital: $0.capital?.first ?? "",
        code: $0.cca2,
        flag: $0.flag
      )
    }
  }
}
