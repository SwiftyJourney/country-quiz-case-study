//
//  Copyright © Juan Francisco Dorado Torres. All rights reserved.
//

import SwiftUI

public struct ChatView: View {
  @Bindable var viewModel: ChatViewModel

  public init(viewModel: ChatViewModel) {
    self.viewModel = viewModel
  }

  public var body: some View {
    VStack(spacing: 0) {
      messageList
      inputBar
    }
    .navigationTitle("Country Quiz")
  }

  private var messageList: some View {
    ScrollViewReader { proxy in
      ScrollView {
        LazyVStack(spacing: 12) {
          ForEach(viewModel.messages) { message in
            MessageBubbleView(
              message: message,
              onRetry: message.role == .error ? { viewModel.retry(message.retryQuestion ?? "") } : nil
            )
          }

          if viewModel.isLoading {
            HStack {
              ProgressView()
                .padding()
              Spacer()
            }
          }
        }
        .padding()
      }
      .onChange(of: viewModel.messages.count) { _, _ in
        guard let last = viewModel.messages.last else { return }
        withAnimation(.smooth) {
          proxy.scrollTo(last.id, anchor: .bottom)
        }
      }
    }
  }

  private var inputBar: some View {
    HStack(spacing: 12) {
      TextField("Ask about a country...", text: $viewModel.inputText)
        .textFieldStyle(.plain)
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .glassEffect(in: .capsule)
        .onSubmit {
          viewModel.send()
        }

      Button(action: { viewModel.send() }) {
        Image(systemName: "arrow.up.circle.fill")
          .font(.title2)
      }
      .buttonStyle(.glassProminent)
      .disabled(viewModel.inputText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || viewModel.isLoading)
    }
    .padding()
  }
}

#Preview {
  NavigationStack {
    ChatView(viewModel: .init(answerQuestion: { question in
      try await Task.sleep(for: .seconds(1))
      return "The capital of Belgium is Brussels"
    }))
  }
}
