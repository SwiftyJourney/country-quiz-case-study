//
//  Copyright © Juan Francisco Dorado Torres. All rights reserved.
//

import Foundation
import Testing
@testable import CountryQuiz

struct RemoteCountryLoaderTests {
  @Test func init_doesNotRequestDataFromURL() {
    let (_, client) = makeSUT()

    #expect(client.requestedURLs.isEmpty)
  }

  // MARK: - Helpers

  private func makeSUT() -> (sut: RemoteCountryLoader, client: HTTPClientSpy) {
    let client = HTTPClientSpy()
    let sut = RemoteCountryLoader(url: anyURL(), client: client)
    return (sut, client)
  }

  private func anyURL() -> URL {
    URL(string: "https://any-url.com")!
  }

  private final class HTTPClientSpy: HTTPClient {
    private(set) var requestedURLs: [URL] = []

    func get(from url: URL) {
      requestedURLs.append(url)
    }
  }
}
