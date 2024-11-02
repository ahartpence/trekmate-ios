//
//  TripViewModel.swift
//  TrekMate
//
//  Created by Andrew Hartpence on 10/26/24.
//
import SwiftUI
import SwiftRecGovApi
import MapKit

struct AnnotationItem: Identifiable {
    let id: String
    let coordinate: CLLocationCoordinate2D
    let stateCode: String
    let name: String
}

struct PolylineItem: Identifiable {
    let id: String
    let coordinates: [CLLocationCoordinate2D]
}

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
    
    var annotations: [AnnotationItem] {
        var items = [AnnotationItem]()

        // Add Detroit annotation
        items.append(AnnotationItem(
            id: "Detroit",
            coordinate: .detroit,
            stateCode: "MI",
            name: "Detroit"
        ))

        // Create annotations for each trip
        for trip in trips {
            if let tripCoordinate = trip.location?.coordinates {
                items.append(AnnotationItem(
                    id: trip.id.uuidString,
                    coordinate: tripCoordinate,
                    stateCode: trip.location?.campArea?.address?.last?.stateCode ?? "ERR",
                    name: trip.location?.campArea?.name.capitalized ?? "ERR"
                ))
            }
        }
        return items
    }

    var polylines: [PolylineItem] {
        var items = [PolylineItem]()

        // Create polylines connecting Detroit to each trip location
        for trip in trips {
            if let tripCoordinate = trip.location?.coordinates {
                let coordinates = [.detroit, tripCoordinate]
                items.append(PolylineItem(
                    id: trip.id.uuidString,
                    coordinates: coordinates
                ))
            }
        }
        return items
    }
    
    
    // Compute the center coordinate of all annotations
    var centerCoordinate: CLLocationCoordinate2D {
        let coordinates = annotations.map { $0.coordinate }
        guard !coordinates.isEmpty else {
            // Default to center Michigan if no coordinates are available
            return CLLocationCoordinate2D(latitude: 43.599186363179705, longitude: -84.7332733350746)
        }
        let avgLatitude = coordinates.map { $0.latitude }.reduce(0, +) / Double(coordinates.count)
        let avgLongitude = coordinates.map { $0.longitude }.reduce(0, +) / Double(coordinates.count)
        return CLLocationCoordinate2D(latitude: avgLatitude, longitude: avgLongitude)
    }
    
    // Compute a camera distance that fits all annotations
    var cameraDistance: CLLocationDistance {
        let coordinates = annotations.map { $0.coordinate }
        guard coordinates.count > 1 else {
            print("1.5mil")
            return 1_500_000
        }
        
        // Calculate the maximum distance from the center to any coordinate
        let center = centerCoordinate
        let centerLocation = CLLocation(latitude: center.latitude, longitude: center.longitude)
        let maxDistance = coordinates.map { coordinate in
            CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude).distance(from: centerLocation)
        }.max() ??  500
        
        
        // Adjust the camera distance to encompass all points, adding some padding
        return maxDistance * 8 // Adjust multiplier as needed for padding
    }
}
