//
//  Copyright © Juan Francisco Dorado Torres. All rights reserved.
//

import Foundation

public final class RemoteCountryLoader {
  private let url: URL
  private let client: HTTPClient

  public init(url: URL, client: HTTPClient) {
    self.url = url
    self.client = client
  }

  public func load() {
    client.get(from: url)
  }
}
