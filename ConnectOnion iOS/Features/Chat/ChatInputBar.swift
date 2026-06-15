import SwiftUI

struct ChatInputBar: View {
    var placeholder: String
    var isRunning: Bool
    var onSend: (String) -> Void
    var onStop: () -> Void

    @State private var text = ""
    @State private var feedbackTrigger = 0
    @FocusState private var isFocused: Bool

    init(
        placeholder: String,
        isRunning: Bool,
        onSend: @escaping (String) -> Void,
        onStop: @escaping () -> Void
    ) {
        self.placeholder = placeholder
        self.isRunning = isRunning
        self.onSend = onSend
        self.onStop = onStop
    }

    var body: some View {
        HStack(alignment: .bottom, spacing: 10) {
            TextField(placeholder, text: $text, axis: .vertical)
                .lineLimit(1...6)
                .textFieldStyle(.plain)
                .focused($isFocused)
                .submitLabel(.send)
                .onSubmit(send)
                .padding(.vertical, 12)
                .padding(.leading, 14)
                .accessibilityIdentifier(AccessibilityID.chatInput)

            if isRunning {
                Button("Stop", systemImage: "stop.fill", action: stop)
                    .labelStyle(.iconOnly)
                    .frame(width: 44, height: 44)
                    .buttonStyle(.glass)
                    .accessibilityIdentifier(AccessibilityID.chatStopButton)
                    .transition(.opacity.combined(with: .scale(scale: 0.9)))
            } else {
                Button("Send", systemImage: "arrow.up", action: send)
                    .labelStyle(.iconOnly)
                    .frame(width: 44, height: 44)
                    .buttonStyle(.glassProminent)
                    .disabled(text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                    .accessibilityIdentifier(AccessibilityID.chatSendButton)
                    .transition(.opacity.combined(with: .scale(scale: 0.9)))
            }
        }
        .padding(8)
        .frame(maxWidth: AppTheme.composerMaxWidth)
        .glassSurface(cornerRadius: 28, isInteractive: true)
        .frame(maxWidth: .infinity)
        .animation(AppMotion.quick, value: isRunning)
        .sensoryFeedback(.selection, trigger: feedbackTrigger)
    }

    private func send() {
        let trimmed = text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        tick()
        text = ""
        onSend(trimmed)
    }

    private func stop() {
        tick()
        onStop()
    }

    private func tick() {
        feedbackTrigger += 1
    }
}

#Preview("Chat Input Ready") {
    ChatInputBar(
        placeholder: "Message OpenOnion",
        isRunning: false,
        onSend: { _ in },
        onStop: {}
    )
    .padding()
}

#Preview("Chat Input Running") {
    ChatInputBar(
        placeholder: "Message OpenOnion",
        isRunning: true,
        onSend: { _ in },
        onStop: {}
    )
    .padding()
}
