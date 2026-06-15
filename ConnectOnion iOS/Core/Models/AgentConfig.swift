import Foundation

struct AgentConfig: Codable, Equatable, Identifiable, Sendable {
    var id: String { address }
    var address: String
    var alias: String
    var preferredEndpoint: URL?
    var createdAt: Date
    var lastConnectedAt: Date?

    var displayName: String {
        if !alias.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            alias
        } else {
            AgentAddress(rawValue: address)?.shortDisplay ?? address
        }
    }
}
