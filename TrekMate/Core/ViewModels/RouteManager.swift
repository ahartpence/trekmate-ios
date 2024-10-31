import Foundation
import MapKit
import Combine
import SwiftRecGovApi

struct RouteDetails {
    let route: MKRoute
    let source: MKMapItem
    let destination: MKMapItem
}

class RouteManager: ObservableObject {
    @Published var routeDetails: RouteDetails?
    @Published var error: Error?
    
    // Define the hardcoded Detroit, MI coordinates
    private let detroitCoordinate = CLLocationCoordinate2D(latitude: 42.3314, longitude: -83.0458)
    
    // Function to calculate route to a Facility using its coordinates
    func calculateRoute(to facility: Facility, completion: @escaping (RouteDetails?) -> Void) {
        // Ensure the Facility has valid coordinates
        let destinationCoordinate = CLLocationCoordinate2D(latitude: facility.latitude, longitude: facility.longitude)
        
        let sourcePlacemark = MKPlacemark(coordinate: detroitCoordinate)
        let destinationPlacemark = MKPlacemark(coordinate: destinationCoordinate)
        
        let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
        let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
        
        let directionsRequest = MKDirections.Request()
        directionsRequest.source = sourceMapItem
        directionsRequest.destination = destinationMapItem
        directionsRequest.transportType = .automobile // Change as needed (.walking, .transit, etc.)
        directionsRequest.requestsAlternateRoutes = false
        
        let directions = MKDirections(request: directionsRequest)
        directions.calculate { response, calculationError in
            if let calculationError = calculationError {
                DispatchQueue.main.async {
                    self.error = calculationError
                    completion(nil)
                }
                return
            }

            guard let route = response?.routes.first,
                  let source = response?.source,
                  let destination = response?.destination else {
                DispatchQueue.main.async {
                    self.error = NSError(domain: "RouteManager", code: 0, userInfo: [NSLocalizedDescriptionKey: "No routes found"])
                    completion(nil)
                }
                return
            }

            let routeDetails = RouteDetails(route: route, source: source, destination: destination)

            DispatchQueue.main.async {
                self.routeDetails = routeDetails
                completion(routeDetails)
            }
        }
    }
    
    // Optional: Function to calculate route using address instead of coordinates
    func calculateRoute(to address: String) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) { [weak self] placemarks, geocodeError in
            if let geocodeError = geocodeError {
                DispatchQueue.main.async {
                    self?.error = geocodeError
                }
                return
            }
            
            guard let destinationPlacemark = placemarks?.first,
                  let destinationLocation = destinationPlacemark.location else {
                DispatchQueue.main.async {
                    self?.error = NSError(domain: "RouteManager", code: 0, userInfo: [NSLocalizedDescriptionKey: "Geocoding failed"])
                }
                return
            }
            
            let destinationCoordinate = destinationLocation.coordinate
            let sourcePlacemark = MKPlacemark(coordinate: self?.detroitCoordinate ?? CLLocationCoordinate2D())
            let destinationMKPlacemark = MKPlacemark(coordinate: destinationCoordinate)
            
            let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
            let destinationMapItem = MKMapItem(placemark: destinationMKPlacemark)
            
            let directionsRequest = MKDirections.Request()
            directionsRequest.source = sourceMapItem
            directionsRequest.destination = destinationMapItem
            directionsRequest.transportType = .automobile
            directionsRequest.requestsAlternateRoutes = false
            
            let directions = MKDirections(request: directionsRequest)
            directions.calculate { [weak self] response, calculationError in
                if let calculationError = calculationError {
                    DispatchQueue.main.async {
                        self?.error = calculationError
                    }
                    return
                }
                
                guard let route = response?.routes.first,
                      let source = response?.source,
                      let destination = response?.destination else {
                    DispatchQueue.main.async {
                        self?.error = NSError(domain: "RouteManager", code: 0, userInfo: [NSLocalizedDescriptionKey: "No routes found"])
                    }
                    return
                }
                
                let routeDetails = RouteDetails(route: route, source: source, destination: destination)
                
                DispatchQueue.main.async {
                    self?.routeDetails = routeDetails
                }
            }
        }
    }
}
