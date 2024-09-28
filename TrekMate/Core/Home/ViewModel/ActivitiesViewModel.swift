//
//  ActivitiesViewModel.swift
//  TrekMate
//
//  Created by Andrew Hartpence on 9/29/24.
//


import Foundation
import SwiftRecGovApi

@MainActor
class ActivitiesViewModel: ObservableObject {
    @Published var activities: [Activity] = []
    @Published var errorMessage: String?
    @Published var showingError = false
    
    private let apiClient: RecreationGovApiClient
    
    init() {
        self.apiClient = RecreationGovApiClient(apiKey: ProcessInfo.processInfo.environment["API_KEY"] ?? "")
    }
    
    func loadActivities(limit: Int = 50, offset: Int = 0) async {
            do {
                print("Fetching activities...")
                let fetchedActivities = try await apiClient.getAllActivities(limit: limit, offset: offset)
                activities = fetchedActivities
            } catch {
                errorMessage = "Failed to load activities: \(error.localizedDescription)"
            }
        }

}
