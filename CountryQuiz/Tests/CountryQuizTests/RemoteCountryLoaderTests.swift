//
//  Copyright © Juan Francisco Dorado Torres. All rights reserved.
//

import CountryQuiz
import Foundation
import Testing

struct RemoteCountryLoaderTests {
  @Test func init_doesNotRequestDataFromURL() {
    let (_, client) = makeSUT()

    #expect(client.requestedURLs.isEmpty)
  }

  @Test func load_requestsDataFromURL() {
    let url = URL(string: "https://a-given-url.com")!
    let (sut, client) = makeSUT(url: url)

    sut.load()

    #expect(client.requestedURLs == [url])
  }

  // MARK: - Helpers

  private func makeSUT(url: URL = URL(string: "https://any-url.com")!) -> (sut: RemoteCountryLoader, client: HTTPClientSpy) {
    let client = HTTPClientSpy()
    let sut = RemoteCountryLoader(url: url, client: client)
    return (sut, client)
  }

  private final class HTTPClientSpy: HTTPClient {
    private(set) var requestedURLs: [URL] = []

    func get(from url: URL) {
      requestedURLs.append(url)
    }
  }
}
