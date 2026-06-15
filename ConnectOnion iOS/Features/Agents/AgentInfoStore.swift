import Factory
import Foundation
import Observation

@MainActor
@Observable
final class AgentInfoStore {
    var infoByAddress: [String: AgentInfo] = [:]
    var isRefreshing = false

    @ObservationIgnored
    @Injected(\.agentDirectoryService) private var directory: AgentDirectoryServicing

    func refresh(addresses: [String]) {
        guard !addresses.isEmpty else { return }
        isRefreshing = true

        Task {
            for address in addresses {
                let info = await directory.fetchAgentInfo(address: address)
                infoByAddress[address] = info
            }
            isRefreshing = false
        }
    }
}
