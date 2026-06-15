import Foundation

@MainActor
protocol IdentityProviding: AnyObject {
    var currentIdentity: ClientIdentity { get throws }
    func regenerateIdentity() throws -> ClientIdentity
    func sign(payload: [String: JSONValue]) throws -> SignedEnvelope
}
