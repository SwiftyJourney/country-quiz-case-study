//
//  Copyright © Juan Francisco Dorado Torres. All rights reserved.
//

import Foundation
import Observation

@Observable
@MainActor
public final class ChatViewModel {
  public private(set) var messages: [ChatMessage] = []
  public private(set) var isLoading = false
  public var inputText = ""

  private let answerQuestion: @Sendable (String) async throws -> String

  public init(answerQuestion: @escaping @Sendable (String) async throws -> String) {
    self.answerQuestion = answerQuestion
  }

  public func send() {
    let trimmed = inputText.trimmingCharacters(in: .whitespacesAndNewlines)
    guard !trimmed.isEmpty else { return }

    let question = trimmed
    inputText = ""
    messages.append(ChatMessage(id: UUID(), text: question, role: .user, retryQuestion: nil))

    isLoading = true
    Task {
      do {
        let answer = try await answerQuestion(question)
        messages.append(ChatMessage(id: UUID(), text: answer, role: .app, retryQuestion: nil))
      } catch {
        messages.append(ChatMessage(id: UUID(), text: "Something went wrong. Please try again.", role: .error, retryQuestion: question))
      }
      isLoading = false
    }
  }

  public func retry(_ question: String) {
    messages.removeAll { $0.retryQuestion == question && $0.role == .error }
    inputText = question
    send()
  }
}
