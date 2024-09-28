//
//  MKMapViewRepresentable.swift
//  TrekMate
//
//  Created by Andrew Hartpence on 10/1/24.
//


import SwiftUI
import MapKit

struct MapViewRepresentable: UIViewRepresentable {
    
    let mapView = MKMapView()
    let locationManager = LocationManager()
    
    func makeUIView(context: Context) -> MKMapView {
        mapView.delegate = context.coordinator
        mapView.isRotateEnabled = false
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .none
        
        return mapView
    }
    
    //send from SwiftUI back to UIKit
    func updateUIView(_ uiView: MKMapView, context: Context) {
        
    }
    
    //send from UIKit to SwiftUI
    func makeCoordinator() -> MapCoordinator {
        return MapCoordinator(parent: self)
    }
    
    class MapCoordinator: NSObject, MKMapViewDelegate {
        let parent: MapViewRepresentable
        
        init(parent: MapViewRepresentable) {
            self.parent = parent
            super.init()
        }
        
        //Tells the delegate when the region the map view is displaying is about to change.
        func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
            
            parent.mapView.setRegion(region, animated: true)
        }
    }
    
    
}
