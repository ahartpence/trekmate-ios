import SwiftUI


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
                                if tripVM.trips.count >= 1 {
                                    rewrite(trip: trip)
                                    .padding(.bottom, 25)
                                    .padding(.horizontal, 10)
                                } else {
                                    rewrite(trip: trip)
                                    .padding(.bottom, 25)
                                    .padding(.horizontal, 10)
                                    Rectangle()
                                        .frame(width: UIScreen.main.bounds.width - 250, height: 0.5)
                                        .foregroundStyle(.separator)
                                }
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
