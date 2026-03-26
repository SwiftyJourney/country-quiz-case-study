//
//  Copyright © Juan Francisco Dorado Torres. All rights reserved.
//

import CountryQuizAPI
import Foundation
import Testing

struct URLSessionHTTPClientTests {
  @Test func get_performsGETRequestWithURL() async throws {
    let url = URL(string: "https://restcountries.com/v3.1/all?fields=name,capital,cca2,flag")!
    let sut = URLSessionHTTPClient()

    let (data, response) = try await sut.get(from: url)

    #expect(response.statusCode == 200)
    #expect(!data.isEmpty)
  }
}
