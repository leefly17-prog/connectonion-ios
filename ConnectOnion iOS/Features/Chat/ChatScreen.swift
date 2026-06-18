import SwiftUI
import SwiftData

struct ChatScreen: View {
    let conversation: ConversationRecord
    let agent: AgentConfigRecord
    let info: AgentInfo?
    let initialPrompt: String?
    let onInitialPromptConsumed: () -> Void

    @State private var viewModel: ChatViewModel

    init(
        conversation: ConversationRecord,
        agent: AgentConfigRecord,
        info: AgentInfo?,
        initialPrompt: String?,
        onInitialPromptConsumed: @escaping () -> Void
    ) {
        self.conversation = conversation
        self.agent = agent
        self.info = info
        self.initialPrompt = initialPrompt
        self.onInitialPromptConsumed = onInitialPromptConsumed
        _viewModel = State(initialValue: ChatViewModel(conversation: conversation, agent: agent.config))
    }

    var body: some View {
        VStack(spacing: 0) {
            ChatHeaderView(
                agent: agent,
                info: info,
                state: viewModel.sessionState,
                elapsedTime: viewModel.elapsedTime
            )

            ChatMessageList(
                items: viewModel.items,
                pendingAskUser: viewModel.pendingAskUser,
                pendingApproval: viewModel.pendingApproval,
                pendingOnboard: viewModel.pendingOnboard,
                pendingPlanReview: viewModel.pendingPlanReview,
                onAskUserResponse: viewModel.respondToAskUser,
                onApprovalResponse: viewModel.respondToApproval,
                onOnboardSubmit: viewModel.submitOnboard,
                onPlanReviewResponse: viewModel.respondToPlanReview
            )

            if let errorMessage = viewModel.errorMessage {
                ChatErrorBanner(message: errorMessage, onReconnect: viewModel.reconnect)
                    .padding(.horizontal, 16)
                    .padding(.bottom, 8)
                    .transition(AppMotion.panelTransition)
            }

            if viewModel.shouldShowFirstPromptSuggestions {
                PromptSuggestionStrip(
                    suggestions: AgentPromptSuggestions.defaults,
                    onSelect: { viewModel.send($0) }
                )
                .accessibilityIdentifier(AccessibilityID.suggestionStrip)
                .padding(.bottom, 8)
                .transition(AppMotion.panelTransition)
            }

            ChatInputBar(
                placeholder: "Message \(displayName)",
                isRunning: viewModel.shouldShowStopButton,
                onSend: { viewModel.send($0) },
                onStop: viewModel.stop
            )
            .padding(.horizontal, 16)
            .padding(.bottom, 14)
        }
        .navigationTitle(conversation.title)
        .navigationBarTitleDisplayMode(.inline)
        .animation(AppMotion.standard, value: viewModel.errorMessage != nil)
        .animation(AppMotion.standard, value: viewModel.shouldShowFirstPromptSuggestions)
        .task(id: conversation.id) {
            guard let initialPrompt else { return }
            viewModel.send(initialPrompt)
            onInitialPromptConsumed()
        }
    }

    private var displayName: String {
        info?.name ?? agent.displayName
    }
}

#Preview("Chat Screen") {
    let _ = PreviewFixtures.installMockDependencies()
    let container = PreviewFixtures.seededContainer()
    let context = container.mainContext
    let agent = try? context.fetch(FetchDescriptor<AgentConfigRecord>()).first
    let conversation = try? context.fetch(FetchDescriptor<ConversationRecord>()).first
    if let agent, let conversation {
        ChatScreen(
            conversation: conversation,
            agent: agent,
            info: agent.cachedInfo,
            initialPrompt: nil,
            onInitialPromptConsumed: {}
        )
            .modelContainer(container)
    } else {
        Text("Preview unavailable")
    }
}
