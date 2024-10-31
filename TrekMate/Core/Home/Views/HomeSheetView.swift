import SwiftUI

//struct HomeSheetView: View {
//    var trips: [Trip]?
//    @StateObject var viewModel = TripViewModel()
//    @State var isPresented: Bool = true
//
//    var body: some View {
//        NavigationStack {
//            VStack {
//                HeaderView(trips: $tripVM.trips)
//                    .padding(.bottom, 10)
//                ScrollView {
//                    ForEach(tripVM.trips) { trip in
//                        NavigationLink(value: trip) {
//                            TripCardView(trip: trip, onRemove: {
//                                tripVM.removeTrip(trip)
//                            })
//                            .padding(.bottom, 25)
//                        }
//                    }
//                }
//                .transparentNavigationBar()
//                .buttonStyle(PlainButtonStyle())
//                .navigationDestination(for: Trip.self) { trip in
//                    TripDetailView(/*trip: trip*/)
//                }
//            }
//        }
//    }
//}
struct HomeSheetView: View {
    @ObservedObject var uiVM: UIModel
    @ObservedObject var tripVM: TripViewModel
  
    @State var isPresented: Bool = true

    var body: some View {
        NavigationStack {
            VStack {
                HeaderView(uiVM: uiVM, tripVM: tripVM, trips: $tripVM.trips)
                    .padding(.bottom, 10)
                ScrollView {
                    VStack {
                        ForEach(tripVM.trips) { trip in
                            NavigationLink(value: trip) {
                                TripCardView(trip: trip)
                                .padding(.bottom, 25)
                            }
                        }
                    }
                }
                
                .transparentNavigationBar()
                .buttonStyle(PlainButtonStyle())
                .navigationDestination(for: Trip.self) { trip in
                    TripDetailView(/*trip: trip*/)
                }
            }
        }
    }
}



#Preview {
    @Previewable @StateObject var uiVM: UIModel = UIModel()
    @Previewable @StateObject var tripVM: TripViewModel = TripViewModel()
    HomeSheetView(uiVM: uiVM, tripVM: tripVM)
}
