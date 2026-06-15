import SwiftUI

struct AgentHeroView: View {
    var agent: AgentConfigRecord
    var info: AgentInfo?

    var body: some View {
        VStack(spacing: 12) {
            AgentAvatar(title: info?.name ?? agent.displayName, online: info?.online)
                .scaleEffect(1.2)
                .padding(.bottom, 8)

            HStack(spacing: 8) {
                Text(info?.name ?? agent.displayName)
                    .font(.title2.bold())
                    .lineLimit(1)

                if let online = info?.online {
                    Image(systemName: online ? "checkmark.circle.fill" : "circle")
                        .foregroundStyle(online ? .green : .secondary)
                        .accessibilityLabel(online ? "Online" : "Offline")
                }
            }

            if !metaLine.isEmpty {
                Text(metaLine)
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
            }

            Text(AgentAddress(rawValue: agent.address)?.shortDisplay ?? agent.address)
                .font(.footnote.monospaced())
                .foregroundStyle(.tertiary)
                .textSelection(.enabled)
        }
    }

    private var metaLine: String {
        [
            info?.model,
            info?.trust,
            info?.version.map { "v\($0)" }
        ]
        .compactMap { $0 }
        .joined(separator: " · ")
    }
}

#Preview("Agent Hero") {
    AgentHeroView(agent: PreviewFixtures.sampleAgent, info: PreviewFixtures.sampleAgentInfo)
        .padding()
}

#Preview("Agent Hero Offline") {
    let agent = PreviewFixtures.sampleAgent
    let info = AgentInfo(address: PreviewFixtures.testAgentAddress, name: "OpenOnion", online: false)
    AgentHeroView(agent: agent, info: info)
        .padding()
}
