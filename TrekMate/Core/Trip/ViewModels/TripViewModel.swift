//
//  TripViewModel.swift
//  TrekMate
//
//  Created by Andrew Hartpence on 10/26/24.
//
import SwiftUI

class TripViewModel: ObservableObject {
    @Published var trips: [Trip] = [
        Trip(name: "Summer 2025 Campathon", location: nil),
        Trip(name: "Summer 2026 Campathon", location: nil)
    ]
    
    func createTrip(_ trip: Trip) {
        trips.append(trip)
    }
    
    func removeTrip(_ trip: Trip) {
        if let index = trips.firstIndex(of: trip) {
            trips.remove(at: index)
        }
    }
}
