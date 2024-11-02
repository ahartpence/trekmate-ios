//
//  HomeView.swift
//  TrekMate
//
//  Created by Andrew Hartpence on 10/24/24.
//

import SwiftUI
import ScalingHeaderScrollView
import MapKit

struct HomeView: View {
    @EnvironmentObject var uiVM: UIModel
    @EnvironmentObject var tripVM: TripViewModel
    
    @State private var sheetPresented: Bool = true
    
    @State private var camera: MapCameraPosition = .camera(MapCamera(centerCoordinate: CLLocationCoordinate2D(latitude: 43.599186363179705, longitude: -84.7332733350746), distance: 1_500_000))
    
    let tripRoute: [CLLocationCoordinate2D] = [.detroit, .platteRiverCampground]
    
    let locations: [FacilityAnnotation] = [
        FacilityAnnotation(code: "SBR", name: "Platte River Campground", coordinate: .platteRiverCampground),
        FacilityAnnotation(code: "DTW", name: "Detroit", coordinate: .detroit)
    ]
    
   //HomeSheetView(uiVM: uiVM, tripVM: tripVM)
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top)) {
                Map(position: $camera) {
                    ForEach(locations) { location in
                        Annotation("\(location.name)", coordinate: location.coordinate, anchor: .leading) {
                            HStack {
                                Circle()
                                    .fill(.blue)
                                    .stroke(.white, lineWidth: 2)
                                    .frame(height: 12)
                                HStack (spacing: 0) {
                                    Text(location.code)
                                        .font(.system(size: 10).weight(.semibold))
                                        .foregroundStyle(.white)
                                        .padding(.leading, 4)
                                        .padding(.trailing, 3)
                                        .frame(maxHeight: .infinity, alignment: .center)
                                        .background(.tmBlue)
                                    Text(location.name)
                                        .font(.system(size: 12))
                                        .foregroundStyle(.white)
                                        .padding(.vertical, 3)
                                        .padding(.leading, 3)
                                        .padding(.trailing, 4)
                                        .background(.tmLightBlue)
                                }
                                .clipShape(RoundedRectangle(cornerRadius: 5.0))
                                .fixedSize()
                            }
                            .offset(x: -5)
                        }
                        
                        MapPolyline(coordinates: tripRoute)
                            .stroke(.tmBlue, lineWidth: 5)
                        MapPolyline(coordinates: tripRoute)
                            .stroke(.tmLightBlue, lineWidth: 2)
                    }
                }
                .ignoresSafeArea()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
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
}


struct FacilityAnnotation: Identifiable {
    let id = UUID()
    let code: String
    let name: String
    let coordinate: CLLocationCoordinate2D
    
}

extension CLLocationCoordinate2D {
    static let detroit = CLLocationCoordinate2D(latitude: 42.6001, longitude: -82.9321)
    static let platteRiverCampground = CLLocationCoordinate2D(latitude: 44.7127778, longitude: -86.1177778)
    static let bayBridgeCampground = CLLocationCoordinate2D(latitude: 44.534438, longitude: -110.436924)
    static let midPoint = CLLocationCoordinate2D(latitude: 39.06903755242377, longitude: -86.79896452319443)
    static let overLake = CLLocationCoordinate2D(latitude: 42.03559217412583, longitude: -86.82568547736001)
}

#Preview {
    @Previewable @StateObject var uiVM: UIModel = UIModel()
    @Previewable @StateObject var tripVM: TripViewModel = TripViewModel()
    HomeView()
        .environmentObject(uiVM)
        .environmentObject(tripVM)
}
