//
//  HomeView.swift
//  TrekMate
//
//  Created by Andrew Hartpence on 10/24/24.
//

import SwiftUI
import ScalingHeaderScrollView
import MapKit

//struct HomeView: View {
//    @EnvironmentObject var uiVM: UIModel
//    @EnvironmentObject var tripVM: TripViewModel
//    
//    @State private var sheetPresented: Bool = true
//    
//    @State private var camera: MapCameraPosition = .camera(MapCamera(centerCoordinate: CLLocationCoordinate2D(latitude: 43.599186363179705, longitude: -84.7332733350746), distance: 1_500_000)) // center michigan
//    
//    let tripRoute: [CLLocationCoordinate2D] = [.detroit, .platteRiverCampground]
//    
//    let locations: [FacilityAnnotation] = [
//        FacilityAnnotation(code: "SBR", name: "Platte River Campground", coordinate: .platteRiverCampground),
//        FacilityAnnotation(code: "DTW", name: "Detroit", coordinate: .detroit)
//    ]
//    
//   //HomeSheetView(uiVM: uiVM, tripVM: tripVM)
//    
//    var body: some View {
//        NavigationStack {
//            ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top)) {
//                Map(position: $camera) {
//                    ForEach(locations) { location in
//                        Annotation("\(location.name)", coordinate: location.coordinate, anchor: .leading) {
//                            HStack {
//                                Circle()
//                                    .fill(.blue)
//                                    .stroke(.white, lineWidth: 2)
//                                    .frame(height: 12)
//                                HStack (spacing: 0) {
//                                    Text(location.code)
//                                        .font(.system(size: 10).weight(.semibold))
//                                        .foregroundStyle(.white)
//                                        .padding(.leading, 4)
//                                        .padding(.trailing, 3)
//                                        .frame(maxHeight: .infinity, alignment: .center)
//                                        .background(.tmBlue)
//                                    Text(location.name)
//                                        .font(.system(size: 12))
//                                        .foregroundStyle(.white)
//                                        .padding(.vertical, 3)
//                                        .padding(.leading, 3)
//                                        .padding(.trailing, 4)
//                                        .background(.tmLightBlue)
//                                }
//                                .clipShape(RoundedRectangle(cornerRadius: 5.0))
//                                .fixedSize()
//                            }
//                            .offset(x: -5)
//                        }
//                        
//                        MapPolyline(coordinates: tripRoute)
//                            .stroke(.tmBlue, lineWidth: 5)
//                        MapPolyline(coordinates: tripRoute)
//                            .stroke(.tmLightBlue, lineWidth: 2)
//                    }
//                }
//                .ignoresSafeArea()
//                .frame(maxWidth: .infinity, maxHeight: .infinity)
//                
//                VStack(spacing: 10) {
//                    Image(systemName: "map.fill")
//                    Divider()
//                        .frame(maxWidth: 30)
//                    Image(systemName: "cloud.fill")
//                }
//                .padding(.horizontal, 6)
//                .padding(.vertical, 12)
//                .background(
//                    Capsule()
//                        .fill(.thickMaterial)
//                )
//                .padding(.top, 70)
//                .padding(.trailing, 20)
//                .ignoresSafeArea()
//            }
//            .toolbar(.hidden, for: .navigationBar)
//            .sheet(isPresented: $sheetPresented) {
//                HomeSheetView(uiVM: uiVM, tripVM: tripVM)
//                    .presentationDetents([.height(200), .medium, .fraction(0.95)], selection: $uiVM.selectedDetent)
//                    .presentationBackgroundInteraction(
//                        .enabled(upThrough: .medium)
//                    )
//                    .presentationDragIndicator(.hidden)
//                    .presentationCornerRadius(21)
//                    .interactiveDismissDisabled()
//            }
//        }
//    }
//}


struct HomeView: View {
    @EnvironmentObject var uiVM: UIModel
    @EnvironmentObject var tripVM: TripViewModel

    @State private var sheetPresented: Bool = true

    @State private var camera: MapCameraPosition = .automatic
    
    let latitudeOffset: Double = -0.5

    var body: some View {
        NavigationStack {
            ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top)) {
                Map(position: $camera) {
                    ForEach(tripVM.annotations) { annotation in
                        Annotation("", coordinate: annotation.coordinate, anchor: .leading) {
                            HStack {
                                Circle()
                                    .fill(.blue)
                                    .stroke(.white, lineWidth: 2)
                                    .frame(height: 12)
                                HStack (spacing: 0) {
                                    Text("\(annotation.name)")
                                        .font(.system(size: 12))
                                        .foregroundStyle(.white)
                                        .padding(.vertical, 3)
                                        .padding(.leading, 3)
                                        .padding(.trailing, 4)
                                        .background(.tmLightBlue)
                                    Text("\(annotation.stateCode)")
                                        .font(.system(size: 10).weight(.semibold))
                                        .foregroundStyle(.white)
                                        .padding(.leading, 4)
                                        .padding(.trailing, 3)
                                        .frame(maxHeight: .infinity, alignment: .center)
                                        .frame(maxWidth: .infinity, alignment: .trailing)
                                        .background(.tmBlue)
                                }
                                .clipShape(RoundedRectangle(cornerRadius: 5.0))
                                .fixedSize()
                            }
                            .offset(x: -5)
                        }
                    }
                    
                    
                    ForEach(tripVM.polylines) { polyline in
                        MapPolyline(coordinates: polyline.coordinates)
                            .stroke(.tmBlue, lineWidth: 5)
                        MapPolyline(coordinates: polyline.coordinates)
                            .stroke(.tmLightBlue, lineWidth: 2)
                    }
                }
                .ignoresSafeArea()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .onAppear {
                       updateCamera()
                   }
               .onChange(of: tripVM.trips) {
                   updateCamera()
               }

                VStack(spacing: 10) {
                    Image(systemName: "map.fill")
                    Divider()
                        .frame(maxWidth: 30)
                    Image(systemName: "cloud.fill")
                }
                .padding(.horizontal, 6)
                .padding(.vertical, 12)
                .background(
                    Capsule()
                        .fill(.thickMaterial)
                )
                .padding(.top, 70)
                .padding(.trailing, 20)
                .ignoresSafeArea()
            }
            .toolbar(.hidden, for: .navigationBar)
            .sheet(isPresented: $sheetPresented) {
                HomeSheetView(uiVM: uiVM, tripVM: tripVM)
                    .presentationDetents([.height(200), .medium, .fraction(0.95)], selection: $uiVM.selectedDetent)
                    .presentationBackgroundInteraction(
                        .enabled(upThrough: .medium)
                    )
                    .presentationDragIndicator(.hidden)
                    .presentationCornerRadius(21)
                    .interactiveDismissDisabled()
            }
        }
    }
    
    private func updateCamera() {
        let center = tripVM.centerCoordinate

        // Apply manual latitude offset
        let adjustedCenter = CLLocationCoordinate2D(
            latitude: center.latitude + latitudeOffset,
            longitude: center.longitude
        )

        camera = .camera(MapCamera(centerCoordinate: adjustedCenter, distance: tripVM.cameraDistance))
    }
}

extension CLLocationCoordinate2D {
    static let detroit = CLLocationCoordinate2D(latitude: 42.6001, longitude: -82.9321)
    // Keep other coordinates if needed
    static let platteRiverCampground = CLLocationCoordinate2D(latitude: 44.7127778, longitude: -86.1177778)
}

#Preview {
    @Previewable @StateObject var uiVM: UIModel = UIModel()
    @Previewable @StateObject var tripVM: TripViewModel = TripViewModel()
    HomeView()
        .environmentObject(uiVM)
        .environmentObject(tripVM)
}
