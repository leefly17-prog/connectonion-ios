import SwiftUI

struct WelcomeView: View {
    var onAddAgent: () -> Void

    @State private var feedbackTrigger = 0

    var body: some View {
        VStack(spacing: 18) {
            Image(systemName: "point.3.connected.trianglepath.dotted")
                .font(.system(size: 44))
                .foregroundStyle(.primary)
                .frame(width: 76, height: 76)
                .glassSurface(cornerRadius: 24)

            Text("ConnectOnion")
                .font(.title.bold())

            Button("Add Agent", systemImage: "plus", action: addAgent)
                .buttonStyle(.glassProminent)
                .accessibilityIdentifier(AccessibilityID.addAgentButton)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
        .sensoryFeedback(.selection, trigger: feedbackTrigger)
    }

    private func addAgent() {
        feedbackTrigger += 1
        onAddAgent()
    }
}

#Preview("Welcome") {
    WelcomeView(onAddAgent: {})
}
