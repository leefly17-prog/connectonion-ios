import Foundation

struct SignedEnvelope: Sendable {
    var payload: [String: JSONValue]
    var from: String
    var signature: String
    var timestamp: Int

    var jsonObject: [String: JSONValue] {
        [
            "payload": .object(payload),
            "from": .string(from),
            "signature": .string(signature),
            "timestamp": .number(Double(timestamp))
        ]
    }
}
