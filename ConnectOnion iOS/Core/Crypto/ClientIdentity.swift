import Foundation

struct ClientIdentity: Codable, Equatable, Sendable {
    var address: String
    var publicKeyHex: String

    var shortAddress: String {
        AgentAddress(rawValue: address)?.shortDisplay ?? address
    }
}
