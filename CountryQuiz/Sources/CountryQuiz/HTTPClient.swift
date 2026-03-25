//
//  Copyright © Juan Francisco Dorado Torres. All rights reserved.
//

import Foundation

public protocol HTTPClient {
  func get(from url: URL) async throws -> (Data, HTTPURLResponse)
}
