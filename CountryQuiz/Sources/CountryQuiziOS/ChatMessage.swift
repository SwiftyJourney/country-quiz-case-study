//
//  Copyright © Juan Francisco Dorado Torres. All rights reserved.
//

import Foundation

public struct ChatMessage: Identifiable, Equatable {
  public let id: UUID
  public let text: String
  public let role: Role
  public let retryQuestion: String?

  public enum Role: Equatable {
    case user
    case app
    case error
  }

  init(id: UUID = UUID(), text: String, role: Role, retryQuestion: String? = nil) {
    self.id = id
    self.text = text
    self.role = role
    self.retryQuestion = retryQuestion
  }
}
