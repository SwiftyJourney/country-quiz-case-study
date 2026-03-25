//
//  Copyright © Juan Francisco Dorado Torres. All rights reserved.
//

import Foundation

public final class RemoteCountryLoader {
  private let url: URL
  private let client: any HTTPClient

  public enum Error: Swift.Error {
    case invalidData
  }

  public init(url: URL, client: any HTTPClient) {
    self.url = url
    self.client = client
  }

  public func load() async throws {
    let (_, response) = try await client.get(from: url)
    guard response.statusCode == 200 else {
      throw Error.invalidData
    }
  }
}
