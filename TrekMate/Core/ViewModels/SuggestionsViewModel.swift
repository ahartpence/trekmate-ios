//
//  SuggestionsViewModel.swift
//  TrekMate
//
//  Created by Andrew Hartpence on 10/19/24.
//


import SwiftUI
import SwiftRecGovApi

// ViewModel to handle fetching suggestions from the API
@MainActor
class SuggestionsViewModel: ObservableObject {
    @Published var recreationAreas: [RecArea] = []
    @Published var campgrounds: [Facility] = []
    @Published var campsiteNumbers: [Campsite] = []
    
    @Published var campsites: [Campsite] = []
    
    private let client = RecreationGovApiClient(apiKey: ProcessInfo.processInfo.environment["API_KEY"] ?? "")
    
    func searchRecreationAreas(query: String) async {
        guard !query.isEmpty else {
            self.recreationAreas = []
            return
        }
        
        do {
            let areas = try await client.getAllRecAreas(query: query)
            
            DispatchQueue.main.async {
                self.recreationAreas = areas
            }
            
        } catch {
            print("Error fetching recreation areas: \(error)")
            self.recreationAreas = []
        }
    }
    
    //"Campgrounds" are facilities in the API. I.e.: Platte River Campground
    func searchCampgroundsByRecAreaID(query: String, recreationArea: String) async {
        guard !query.isEmpty, !recreationArea.isEmpty else {
            self.campgrounds = []
            return
        }
        
        do {
            let grounds = try await client.getFacilitiesByID(recAreaID: recreationArea, query: query)
            self.campgrounds = grounds
        } catch {
            print("Error fetching campgrounds: \(error)")
            self.campgrounds = []
        }
    }
    
    func searchCampsiteNumbers(query: String, facility: String) async {
        guard !query.isEmpty, !facility.isEmpty else {
            self.campsiteNumbers = []
            return
        }
        
        do {
            let sites = try await client.getCampsitesByID(facilityID: facility, query: query)
            self.campsiteNumbers = sites
        } catch {
            print("Error fetching campsite numbers: \(error)")
            self.campsiteNumbers = []
        }
    }
    
    
    func searchCampsites(query: String, facilityID: String) async {
        guard !query.isEmpty else {
            DispatchQueue.main.async {
                self.campsites = []
            }
            return
        }
        
        do {
            let fetchedCampsites = try await client.getCampsitesByID(facilityID: facilityID, query: query)
            
            // Print the fetched Campsite objects
            for campsite in fetchedCampsites {
                print("Fetched campsite: \(campsite) \n")
            }
            
            // Update campsites on the main thread
            DispatchQueue.main.async {
                self.campsites = fetchedCampsites
            }
            
            
        } catch {
            print("Error fetching campsites: \(error)")
        }
    }
}
