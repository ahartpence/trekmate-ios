////
////  SearchViewModel.swift
////  TrekMate
////
////  Created by Andrew Hartpence on 10/28/24.
////
import SwiftUI
import SwiftRecGovApi
import Combine

enum SearchResultItem: Identifiable {
    case recArea(RecArea)
    case facility(Facility)
    
    var id: String {
        switch self {
        case .recArea(let recArea):
            return recArea.id
        case .facility(let facility):
            return facility.id
        }
    }
}

class SearchViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var searchResults: [SearchResultItem] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        $searchText
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] _ in
                Task {
                    await self?.search()
                }
            }
            .store(in: &cancellables)
    }
    
    func search() async {
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
            
            let recAreaItems = recAreas.map { SearchResultItem.recArea($0) }
            let facilityItems = facilities.map { SearchResultItem.facility($0) }
            
            let combinedResults = recAreaItems + facilityItems
            
            DispatchQueue.main.async {
                self.searchResults = combinedResults
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
