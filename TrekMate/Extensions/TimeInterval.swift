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
    /// Formats the CLLocationDistance into a rounded, human-readable string with commas if over 1,000 miles (e.g., "1,234 mi" or "6 mi")
    func formattedDistance() -> String {
        // Convert meters to miles
        let metersPerMile = 1609.344
        let distanceInMiles = self / metersPerMile
        
        // Use NumberFormatter for comma formatting if over 1,000 miles
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 1
        
        if distanceInMiles >= 1000 {
            return "\(numberFormatter.string(from: NSNumber(value: distanceInMiles)) ?? "\(distanceInMiles)") mi"
        } else {
            return "\(distanceInMiles) mi"
        }
    }
}
