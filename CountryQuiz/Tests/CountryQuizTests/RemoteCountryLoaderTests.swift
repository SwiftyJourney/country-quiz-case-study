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

  @Test func load_requestsDataFromURL() async throws {
    let url = URL(string: "https://a-given-url.com")!
    let (sut, client) = makeSUT(url: url)
    client.stub(data: emptyListJSON(), response: HTTPURLResponse())

    _ = try await sut.load()

    #expect(client.requestedURLs == [url])
  }

  @Test func loadTwice_requestsDataFromURLTwice() async throws {
    let url = URL(string: "https://a-given-url.com")!
    let (sut, client) = makeSUT(url: url)
    client.stub(data: emptyListJSON(), response: HTTPURLResponse())

    _ = try await sut.load()
    _ = try await sut.load()

    #expect(client.requestedURLs == [url, url])
  }

  @Test func load_deliversErrorOnClientError() async {
    let (sut, client) = makeSUT()
    client.stub(error: anyNSError())

    await #expect(throws: Error.self) {
      try await sut.load()
    }
  }

  @Test(arguments: [199, 201, 300, 500, 500])
  func load_deliversErrorOnNon200HTTPResponse(statusCode: Int) async {
    let (sut, client) = makeSUT()
    client.stub(data: Data(), response: httpURLResponse(statusCode: statusCode))

    await #expect(throws: RemoteCountryLoader.Error.self) {
      try await sut.load()
    }
  }

  @Test func load__deliversErrorOn200HTTPResponseWithInvalidJSON() async {
    let (sut, client) = makeSUT()
    let invalidJSON = Data("invalid json".utf8)
    client.stub(data: invalidJSON, response: httpURLResponse(statusCode: 200))

    await #expect(throws: RemoteCountryLoader.Error.self) {
      try await sut.load()
    }
  }

  @Test func load_deliversEmptyOn200HTTPResponseWithEmptyJSONList() async throws {
    let (sut, client) = makeSUT()
    client.stub(data: emptyListJSON(), response: httpURLResponse(statusCode: 200))

    let countries = try await sut.load()

    #expect(countries.isEmpty)
  }

  @Test func load_deliversCountriesOn200HTTPResponseWithJSONItems() async throws {
    let country1 = Country(name: "Belgium", capital: "Brussels", code: "BE", flag: "🇧🇪")
    let country2 = Country(name: "Greece", capital: "Athens", code: "GR", flag: "🇬🇷")
    let json = [
      makeCountryJSON(name: "Belgium", capital: "Brussels", code: "BE", flag: "🇧🇪"),
      makeCountryJSON(name: "Greece", capital: "Athens", code: "GR", flag: "🇬🇷")
    ]
    let data = try JSONSerialization.data(withJSONObject: json)

    let (sut, client) = makeSUT()
    client.stub(data: data, response: httpURLResponse(statusCode: 200))

    let countries = try await sut.load()

    #expect(countries == [country1, country2])
  }

  // MARK: - Helpers

  private func makeSUT(url: URL = URL(string: "https://any-url.com")!) -> (sut: RemoteCountryLoader, client: HTTPClientSpy) {
    let client = HTTPClientSpy()
    let sut = RemoteCountryLoader(url: url, client: client)
    return (sut, client)
  }

  private func anyNSError() -> NSError {
    NSError(domain: "test", code: 0, userInfo: nil)
  }

  private func httpURLResponse(statusCode: Int) -> HTTPURLResponse {
    HTTPURLResponse(
      url: URL(string: "https://any-url.com")!,
      statusCode: statusCode,
      httpVersion: nil,
      headerFields: nil
    )!
  }

  private func emptyListJSON() -> Data {
    Data("[]".utf8)
  }

  private func makeCountryJSON(name: String, capital: String, code: String, flag: String) -> [String: Any] {
    [
      "name": ["common": name],
      "capital": [capital],
      "cca2": code,
      "flag": flag
    ]
  }

  private final class HTTPClientSpy: HTTPClient, @unchecked Sendable {
    private(set) var requestedURLs: [URL] = []
    private var result: Result<(Data, HTTPURLResponse), Error> = .failure(NSError())

    func stub(error: Error) {
      result = .failure(error)
    }

    func stub(data: Data, response: HTTPURLResponse) {
      result = .success((data, response))
    }

    func get(from url: URL) async throws -> (Data, HTTPURLResponse) {
      requestedURLs.append(url)
      return try result.get()
    }
  }
}
