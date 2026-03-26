//
//  Copyright © Juan Francisco Dorado Torres. All rights reserved.
//

import CountryQuiz
import CountryQuizAPI
import CountryQuizFoundationModels
import Foundation

let url = URL(string: "https://restcountries.com/v3.1/all?fields=name,capital,cca2,flag")!
let client = URLSessionHTTPClient()
let loader = RemoteCountryLoader(url: url, client: client)
let interpreter = FoundationModelsQuestionInterpreter()
let service = QuizService(interpreter: interpreter, loader: loader)

print("Country Quiz 🌎")
print("Ask med about capitals, country codes, flags, or countries by prefix.")
print("Type 'quit' to exit.\n")

while true {
  print("> ", terminator: "")
  guard let input = readLine(), !input.isEmpty else { continue }
  if input.lowercased() == "quit" { break }

  do {
    let answer = try await service.answer(input)
    print(answer)
  } catch {
    print("Something went wrong. Try again? (y/n)")
    if let retry = readLine(), retry.lowercased() == "y" {
      do {
        let answer = try await service.answer(input)
        print(answer)
      } catch {
        print("Still failing: \(error.localizedDescription)")
      }
    }
  }
  print()
}
