//
//  Trip.swift
//  TrekMate
//
//  Created by Andrew Hartpence on 10/9/24.
//
import Foundation
import SwiftRecGovApi
import MapKit
import CoreLocation


struct Trip: Identifiable, Hashable {
    
    static func == (lhs: Trip, rhs: Trip) -> Bool {
        return lhs.id == rhs.id
    }
    
    var id = UUID()
    var name: String
    var description: String?
    var startDate: Date = Date.now
    var endDate: Date = Date().addingTimeInterval((60 * 60 * 24) * 3) // 3 days from today
    let location: Location?
    var attendees: [User] = []
    var status: TripStatus = .planning
    
    var tripDuration: Int {
        let calendar = Calendar.current
        
        if startDate > endDate {
            return 0
        }
        let components = calendar.dateComponents([.day], from: startDate, to: endDate)
        return components.day ?? 0
    }
    
    var tripCountdownDaysLeft: Int {
        let calendar = Calendar.current
        
        let components = calendar.dateComponents([.day], from: Date(), to: startDate)
        return components.day ?? 0

    }
}



struct Location: Hashable {
    var id: UUID = UUID()
    var recArea: RecArea?
    var campArea: Facility?
    var campSite: Campsite?
    
    // Example initializer if needed
    // init(campArea: Facility) {
    //     // Lookup the other recArea and get list of campSite for Facility and RecArea
    // }
    
    var coordinates: CLLocationCoordinate2D? {
        if let geoJson = campArea?.geoJson,
           let geoCoordinates = geoJson.coordinates, geoCoordinates.count >= 2 {
                let longitude = geoCoordinates[0]
                let latitude  = geoCoordinates[1]
                
                return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        }
        return nil
    }
    
    var distanceFromHome: CLLocationDistance? {
        // Define the home location coordinates
        let homeLatitude = 42.3314
        let homeLongitude = -83.0458
        let homeLocation = CLLocation(latitude: homeLatitude, longitude: homeLongitude)
        
        // Ensure that the current location has valid coordinates
        guard let currentCoordinates = coordinates else {
            return nil // Return nil if coordinates are not available
        }
        
        let campgroundLocation = CLLocation(latitude: currentCoordinates.latitude, longitude: currentCoordinates.longitude)
        
        // Calculate the distance in meters
        let distanceInMeters = homeLocation.distance(from: campgroundLocation)
        
        // Convert meters to miles
        let metersPerMile = 1609.344
        let distanceInMiles = distanceInMeters / metersPerMile
        
        return distanceInMiles
    }
    
    
    
    // Optional: If you want to format the distance for display
    var distanceFromHomeFormatted: String? {
        guard let distance = distanceFromHome else { return nil }
        let formatter = LengthFormatter()
        formatter.unitStyle = .short
        formatter.numberFormatter.maximumFractionDigits = 2
        return formatter.string(fromMeters: distance)
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Location, rhs: Location) -> Bool {
        return lhs.id == rhs.id
    }
}


enum TripStatus: String {
    case archived = "Archived"
    case inProgress = "Active"
    case planning = "Planning"
}

extension Trip {
    static let summerCampathon = Trip(name: "Summer 2025 Campathon",
                                      description: "We're going to sleeping bear dunes!",
                                      location: Location(
                                        recArea: RecArea(id: "1", orgRecAreaId: "", parentOrgId: "", name: "", description: "", feeDescription: "", directions: "", phone: "", email: "", reservationURL: "", mapURL: "", geoJson: Geolocation(type: "", coordinates: []), longitude: 100.0, latitude: 100.0, stayLimit: "", keywords: "", reservable: true, enabled: true, lastUpdated: "", org: [], facility: [], address: [], activity: [], event: [], media: [], link: [])
                                      )
    )
}
