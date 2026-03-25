//
//  Copyright © Juan Francisco Dorado Torres. All rights reserved.
//

import Foundation

final class RemoteCountryLoader {
  private let url: URL
  private let client: HTTPClient

  init(url: URL, client: HTTPClient) {
    self.url = url
    self.client = client
  }

  func load() {
    client.get(from: url)
  }
}
