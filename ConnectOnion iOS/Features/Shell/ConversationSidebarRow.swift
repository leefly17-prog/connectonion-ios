import SwiftUI

struct ConversationSidebarRow: View {
    var conversation: ConversationRecord
    var agentName: String
    var isSelected: Bool
    var onSelect: () -> Void
    var onDelete: () -> Void

    var body: some View {
        Button(action: onSelect) {
            HStack(alignment: .top, spacing: 10) {
                Image(systemName: "text.bubble")
                    .font(.body)
                    .foregroundStyle(.secondary)
                    .frame(width: 28, height: 28)

                VStack(alignment: .leading, spacing: 4) {
                    Text(conversation.title)
                        .font(.body)
                        .lineLimit(2)
                    Text(agentName)
                        .font(.footnote)
                        .foregroundStyle(.tertiary)
                        .lineLimit(1)
                }

                Spacer(minLength: 0)

                Menu("Conversation Actions", systemImage: "ellipsis") {
                    Button("Delete", systemImage: "trash", role: .destructive, action: onDelete)
                }
                .labelStyle(.iconOnly)
            }
            .padding(10)
            .background(isSelected ? Color.primary.opacity(0.08) : Color.clear, in: .rect(cornerRadius: 16))
            .contentShape(.rect)
        }
        .buttonStyle(.plain)
        .accessibilityLabel(conversation.title)
    }
}

#Preview("Conversation Row") {
    ConversationSidebarRow(
        conversation: PreviewFixtures.sampleConversation,
        agentName: "OpenOnion",
        isSelected: true,
        onSelect: {},
        onDelete: {}
    )
    .padding()
}
