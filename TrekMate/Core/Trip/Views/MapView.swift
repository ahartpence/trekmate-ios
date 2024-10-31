import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    var routeDetails: RouteDetails

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        mapView.showsUserLocation = false
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        return mapView
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        // Remove existing overlays and annotations
        uiView.removeOverlays(uiView.overlays)
        uiView.removeAnnotations(uiView.annotations)

        // Add the route as an overlay
        uiView.addOverlay(routeDetails.route.polyline)

        // Add annotations for start and end points
        let sourceAnnotation = MKPointAnnotation()
        sourceAnnotation.title = routeDetails.source.name
        sourceAnnotation.coordinate = routeDetails.source.placemark.coordinate
        uiView.addAnnotation(sourceAnnotation)

        let destinationAnnotation = MKPointAnnotation()
        destinationAnnotation.title = routeDetails.destination.name
        destinationAnnotation.coordinate = routeDetails.destination.placemark.coordinate
        uiView.addAnnotation(destinationAnnotation)

        // Calculate the combined MKMapRect that includes the polyline and annotations
        var mapRect = routeDetails.route.polyline.boundingMapRect

        // Expand the mapRect to include annotations
        let sourcePoint = MKMapPoint(routeDetails.source.placemark.coordinate)
        let destinationPoint = MKMapPoint(routeDetails.destination.placemark.coordinate)

        let annotationRect = MKMapRect(
            x: min(sourcePoint.x, destinationPoint.x),
            y: min(sourcePoint.y, destinationPoint.y),
            width: abs(sourcePoint.x - destinationPoint.x),
            height: abs(sourcePoint.y - destinationPoint.y)
        )

        mapRect = mapRect.union(annotationRect)

        // Add some padding to the mapRect
        let edgePadding = UIEdgeInsets(top: 50, left: 20, bottom: 50, right: 20)

        // Set the visible map rect with animation
        uiView.setVisibleMapRect(mapRect, edgePadding: edgePadding, animated: true)
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    // Coordinator to handle MKMapViewDelegate methods
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView

        init(_ parent: MapView) {
            self.parent = parent
        }

        // Render the route polyline
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            if overlay is MKPolyline {
                let renderer = MKPolylineRenderer(overlay: overlay)
                renderer.strokeColor = UIColor.systemBlue
                renderer.lineWidth = 5
                return renderer
            }
            return MKOverlayRenderer(overlay: overlay)
        }

        // Customize annotation views
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            if annotation is MKPointAnnotation {
                let identifier = "Placemark"
                var view = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
                if view == nil {
                    view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                    view?.canShowCallout = true
                } else {
                    view?.annotation = annotation
                }
                return view
            }
            return nil
        }
    }
}
