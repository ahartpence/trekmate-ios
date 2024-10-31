//
//  TripViewModel.swift
//  TrekMate
//
//  Created by Andrew Hartpence on 10/26/24.
//
import SwiftUI
import SwiftRecGovApi

class TripViewModel: ObservableObject {
    @Published var trips: [Trip] = [
//        Trip(name: "Summer 2025 Campathon", description: "We're going to sleeping bear dunes", location: nil),
//        Trip(name: "Summer 2026 Campathon", description: "We're going to red bridge campground", location: nil)
    ]
    
    @Published var tripName: String = ""
    @Published var selectedFacility: Facility? = nil
    
    @Published var tripRouteDetails: [Trip: RouteDetails] = [:]

    func createTrip(name: String, description: String?, location: Location?, startDate: Date, endDate: Date, attendees: [User]?, status: TripStatus) {
        let newTrip = Trip(name: name, description: description, startDate: startDate, endDate: endDate, location: location, attendees: attendees ?? [], status: status)
        trips.append(newTrip)
        
        // Calculate the route and store it in tripRouteDetails
        if let campArea = location?.campArea {
            let routeManager = RouteManager()
            routeManager.calculateRoute(to: campArea) { [weak self] routeDetails in
                DispatchQueue.main.async {
                    if let routeDetails = routeDetails {
                        self?.tripRouteDetails[newTrip] = routeDetails
                    }
                }
            }
        }
    }
    
    func removeTrip(_ trip: Trip) {
        if let index = trips.firstIndex(of: trip) {
            trips.remove(at: index)
        }
    }
}
