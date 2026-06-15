import Factory
import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) private var dismiss
    @Injected(\.identityStore) private var identityStore: IdentityProviding

    var onAddAgent: (() -> Void)? = nil

    @State private var identity: ClientIdentity?
    @State private var errorMessage: String?
    @State private var confirmingRegenerate = false
    @State private var feedbackTrigger = 0

    var body: some View {
        NavigationStack {
            Form {
                if let onAddAgent {
                    Section("Agents") {
                        Button("Add Agent", systemImage: "plus") {
                            feedbackTrigger += 1
                            onAddAgent()
                        }
                        .accessibilityIdentifier(AccessibilityID.addAgentButton)
                    }
                }

                Section("Identity") {
                    if let identity {
                        LabeledContent("Address") {
                            Text(identity.shortAddress)
                                .font(.body.monospaced())
                                .textSelection(.enabled)
                        }
                    }

                    Button("Regenerate Identity", systemImage: "key", role: .destructive) {
                        confirmingRegenerate = true
                    }
                }

                Section("Network") {
                    LabeledContent("Relay", value: "oo.openonion.ai")
                    LabeledContent("Protocol", value: "Signed WebSocket")
                }

                if let errorMessage {
                    Section {
                        Text(errorMessage)
                            .foregroundStyle(.red)
                    }
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
            .confirmationDialog("Regenerate Identity", isPresented: $confirmingRegenerate) {
                Button("Regenerate", role: .destructive, action: regenerate)
                Button("Cancel", role: .cancel) {}
            }
            .task {
                loadIdentity()
            }
            .sensoryFeedback(.selection, trigger: feedbackTrigger)
        }
    }

    private func loadIdentity() {
        do {
            identity = try identityStore.currentIdentity
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    private func regenerate() {
        do {
            identity = try identityStore.regenerateIdentity()
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}

#Preview {
    let _ = PreviewFixtures.installMockDependencies()
    SettingsView()
}
