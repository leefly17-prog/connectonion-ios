import Foundation

enum IdentityStoreError: LocalizedError {
    case invalidStoredPrivateKey
    case signingFailed

    var errorDescription: String? {
        switch self {
        case .invalidStoredPrivateKey:
            "The stored ConnectOnion identity is invalid."
        case .signingFailed:
            "Unable to sign the ConnectOnion request."
        }
    }
}
