import SwiftUI

struct LandingComposer: View {
    var suggestions: [String]
    var onSend: (String) -> Void

    var body: some View {
        VStack(spacing: 12) {
            PromptSuggestionStrip(suggestions: suggestions, onSelect: onSend)

            ChatInputBar(
                placeholder: "Message this agent",
                isRunning: false,
                onSend: { text in onSend(text) },
                onStop: {}
            )
            .padding(.horizontal, 16)
        }
        .padding(.top, 10)
        .padding(.bottom, 14)
        .background(.background)
    }
}

#Preview("Landing Composer") {
    LandingComposer(
        suggestions: ["What can you do?", "Show system info", "List files"],
        onSend: { _ in }
    )
}
