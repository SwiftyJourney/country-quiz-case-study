//
//  Copyright © Juan Francisco Dorado Torres. All rights reserved.
//

import Foundation

public protocol HTTPClient: Sendable {
  func get(from url: URL) async throws -> (Data, HTTPURLResponse)
}
