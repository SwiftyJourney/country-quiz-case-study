//
//  Copyright © Juan Francisco Dorado Torres. All rights reserved.
//

import CountryQuiz
import CountryQuizAPI
import CountryQuizFoundationModels
import CountryQuiziOS
import SwiftUI

@main
struct CountryQuizAppApp: App {
  private let viewModel: ChatViewModel

  init() {
    let url = URL(string: "https://restcountries.com/v3.1/all?fields=name,capital,cca2,flag")!
    let client = URLSessionHTTPClient()
    let loader = RemoteCountryLoader(url: url, client: client)
    let interpreter = FoundationModelsQuestionInterpreter()
    let service = QuizService(interpreter: interpreter, loader: loader)

    self.viewModel = ChatViewModel(answerQuestion: service.answer)
  }

  var body: some Scene {
    WindowGroup {
      NavigationStack {
        ChatView(viewModel: viewModel)
      }
    }
  }
}
