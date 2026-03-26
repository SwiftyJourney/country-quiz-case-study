//
//  Copyright © Juan Francisco Dorado Torres. All rights reserved.
//

import SwiftUI

struct MessageBubbleView: View {
  let message: ChatMessage
  var onRetry: (() -> Void)?

  var body: some View {
    HStack {
      if message.role == .user { Spacer(minLength: 60) }

      VStack(alignment: message.role == .user ? .trailing : .leading, spacing: 8) {
        Text(message.text)
          .foregroundStyle(message.role == .error ? .white : .primary)
          .padding(.horizontal, 16)
          .padding(.vertical, 12)
          .glassEffect(
            glassStyle,
            in: .rect(cornerRadius: 20)
          )

        if let onRetry {
          Button("Retry", systemImage: "arrow.clockwise", action: onRetry)
            .font(.caption)
            .buttonStyle(.glass)
        }
      }

      if message.role != .user { Spacer(minLength: 60) }
    }
  }

  private var glassStyle: Glass {
    switch message.role {
    case .user:
        .regular.tint(.blue)
    case .app:
        .regular
    case .error:
        .regular.tint(.red)
    }
  }
}

#Preview("User") {
  MessageBubbleView(message: .init(text: "What is the capital of Greece", role: .user))
}

#Preview("App") {
  MessageBubbleView(message: .init(text: "The flag of Brazil is 🇧🇷", role: .app))
}

#Preview("Error") {
  MessageBubbleView(message: .init(text: "What is the capital of Greece", role: .error), onRetry: { print("Hi") })
}
