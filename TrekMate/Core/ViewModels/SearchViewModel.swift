////
////  SearchViewModel.swift
////  TrekMate
////
////  Created by Andrew Hartpence on 10/28/24.
////
import SwiftUI
import SwiftRecGovApi
import Combine
import MapKit

enum SearchResultItem: Identifiable {
   // case recArea(RecArea)
    case facility(Facility)
    
    var id: String {
        switch self {
//        case .recArea(let recArea):
//            return recArea.id
        case .facility(let facility):
            return facility.id
        }
    }
}

class SearchViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var searchResults: [SearchResultItem] = []
    @Published var city: String = "Honor, MI"
    @Published var resolvedLocations: [String: String] = [:]
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        $searchText
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] _ in
                Task {
                    await self?.searchFacilities()
                }
            }
            .store(in: &cancellables)
    }
    
    func searchAll() async {
        guard searchText.count > 3 else {
            DispatchQueue.main.async {
                self.searchResults = []
            }
            return
        }
        
        do {
            let client = RecreationGovApiClient(apiKey: Secrets.apiKey)
            async let recAreasTask = client.getAllRecAreas(query: searchText)
            async let facilitiesTask = client.getAllFacilities(query: searchText)
            
            let recAreas = try await recAreasTask
            let facilities = try await facilitiesTask
            
            let filteredRecAreas = recAreas.filter { recAreas in
                guard let address = recAreas.address?.last else { return false }
                return address.city != "" && address.countryCode != ""
            }
            
            let filteredFacilities = facilities.filter { facility in
                guard let address = facility.address?.last else { return false }
                return address.city != "" && address.countryCode != ""
            }
            
//            let recAreaItems = filteredRecAreas.map { SearchResultItem.recArea($0) }
            let facilityItems = filteredFacilities.map { SearchResultItem.facility($0) }
            
            //let combinedResults = recAreaItems + facilityItems
            let results = facilityItems
            
            //print(combinedResults)
            print(facilityItems)
            
            DispatchQueue.main.async {
                self.searchResults = results
            }
            
        } catch {
            print("Error fetching search results: \(error)")
        }
    }
    
    func searchFacilities() async {
        guard searchText.count > 3 else {
            DispatchQueue.main.async {
                self.searchResults = []
            }
            return
        }
        
        do {
            let client = RecreationGovApiClient(apiKey: Secrets.apiKey)
            async let facilitiesTask = client.getAllFacilities(query: searchText)
            
            let facilities = try await facilitiesTask
            
            let filteredFacilities = facilities.filter { facility in
                // Check if the facility has an address array that is not empty
                guard let addressArray = facility.address, !addressArray.isEmpty else {
                    print("Remove Cannot find address for: \(facility.name)")
                    return false
                }
                return true
            }.sorted { facility1, facility2 in
                // Calculate relevance score
                let score1 = facility1.name.lowercased() == searchText.lowercased() ? 2 :
                             facility1.name.lowercased().contains(searchText.lowercased()) ? 1 : 0
                let score2 = facility2.name.lowercased() == searchText.lowercased() ? 2 :
                             facility2.name.lowercased().contains(searchText.lowercased()) ? 1 : 0
                // Sort by score in descending order
                return score1 > score2
            }


            
            
            let facilityItems = filteredFacilities.map { SearchResultItem.facility($0) }

            
            //print(combinedResults)
            print(facilityItems)
            
            DispatchQueue.main.async {
                self.searchResults = facilityItems
            }
            
        } catch {
            print("Error fetching search results: \(error)")
        }
    }
}


//class SearchViewModel: ObservableObject {
//    @Published var searchText: String = ""
//    @Published var returnedCampsites: [Campsite] = []
//
//    func searchCampsites() async {
//        guard searchText.count > 3 else {
//            DispatchQueue.main.async {
//                self.returnedCampsites = []
//            }
//            return
//        }
//
//        guard !searchText.isEmpty else {
//            DispatchQueue.main.async {
//                self.returnedCampsites = []
//            }
//            return
//        }
//
//        do {
//            let client = RecreationGovApiClient(apiKey: ProcessInfo.processInfo.environment["API_KEY"] ?? "")
//            let fetchedCampsites = try await client.getAllCampsites(query: searchText)
//
//            // Update campsites on the main thread
//            DispatchQueue.main.async {
//                self.returnedCampsites = fetchedCampsites
//            }
//        } catch {
//            print("Error fetching campsites: \(error)")
//        }
//    }
//
//
//}
