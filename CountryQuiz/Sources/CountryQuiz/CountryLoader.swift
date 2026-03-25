//
//  Copyright © Juan Francisco Dorado Torres. All rights reserved.
//

import Foundation

public protocol CountryLoader: Sendable {
  func load() async throws -> [Country]
}
