import SwiftUI
import SwiftRecGovApi

@MainActor // Ensures that all access to this class is on the main actor, solving race conditions.
class CampsitesViewModel: ObservableObject, Sendable {
    @Published var campsites: [Campsite] = []
    
    func searchCampsites(query: String) async {
        guard !query.isEmpty else {
            DispatchQueue.main.async {
                self.campsites = []
            }
            return
        }
        
        do {
            let client = RecreationGovApiClient(apiKey: ProcessInfo.processInfo.environment["API_KEY"] ?? "")
            let fetchedCampsites = try await client.getAllCampsites(query: query)
            
            // Update campsites on the main thread
            DispatchQueue.main.async {
                self.campsites = fetchedCampsites
            }
        } catch {
            print("Error fetching campsites: \(error)")
        }
    }
}
