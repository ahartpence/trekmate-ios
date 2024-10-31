//
//  TimeInterval.swift
//  TrekMate
//
//  Created by Andrew Hartpence on 10/30/24.
//
import Foundation
import MapKit

extension TimeInterval {
    /// Formats the TimeInterval into a human-readable string (e.g., "1 hr 30 min")
    func formattedTravelTime() -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute]
        formatter.unitsStyle = .abbreviated
        formatter.maximumUnitCount = 2
        return formatter.string(from: self) ?? "N/A"
    }
}

// Extension for CLLocationDistance (Optional: To display formatted distance)
extension CLLocationDistance {
    /// Formats the CLLocationDistance into a human-readable string (e.g., "5.2 mi")
    func formattedDistance() -> String {
        let formatter = LengthFormatter()
        formatter.unitStyle = .short
        return formatter.string(fromMeters: self)
    }
}
