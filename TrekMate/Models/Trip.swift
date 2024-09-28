//
//  Trip.swift
//  TrekMate
//
//  Created by Andrew Hartpence on 10/9/24.
//
import Foundation
import SwiftRecGovApi
import MapKit

extension CLLocationCoordinate2D: Hashable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(latitude)
        hasher.combine(longitude)
    }
}

struct Trip: Identifiable, Hashable {
    
    static func == (lhs: Trip, rhs: Trip) -> Bool {
        return lhs.id == rhs.id
    }
    
    var id = UUID()
    var name: String
    var startDate: Date = Date.now
    var endDate: Date = Date().addingTimeInterval((60 * 60 * 24) * 3) // 3 days from today
    let location: Location?
    var status: TripStatus = .planning
}

struct Location: Hashable{
    var id: UUID = UUID()
    var recArea: String?
    var campArea: String?
    var campSite: String?
    var coordinates: CLLocationCoordinate2D?
}

enum TripStatus: String {
    case archived = "Archived"
    case inProgress = "Active"
    case planning = "Planning"
}
