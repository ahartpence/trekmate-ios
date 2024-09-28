import SwiftUI
import ScalingHeaderScrollView
import MapKit


struct TripDetailView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject var uiModel: UIModel = UIModel()


    @State private var collapseProgress: CGFloat = 0
    @State var snapTo: SnapHeaderState?
    
    @State var showingSheet: Bool = true

    var body: some View {
            ZStack {
                ScalingHeaderScrollView {
                    TabView {
                        ForEach(0..<5) { image in
                            Image("platte_river")
                                .resizable()
                                .scaledToFill()
                                .scaleEffect(1.5 - 0.5 * collapseProgress)
                                .frame(height: 300)
                                
                        }
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                } content: {
                    LazyVStack(alignment: .leading, spacing: 7) {
                        TripDetailsHeader()
                        AlertSection()
                            .padding(.bottom, 15)
                        DetailedDepartureSection()
                        GoodToKnowSection()
                        EquipmentSection()
                        ArrivalForecastSection()
                        WeatherSection()
                        
                        // Sample List Items
                        ForEach(0..<25) { item in
                            Text("item")
                                .padding(.horizontal, 15)
                                .padding(.vertical, 5)
                        }
                    }
                    .background(Color(.systemBackground)) // Ensure background color for readability
                }
                .snapHeaderToState($snapTo)
                .collapseProgress($collapseProgress) // Bind progress to collapse
                .allowsHeaderGrowth(true) // Enables zooming out as you scroll down
                .allowsHeaderCollapse(true) // Allows collapsing while scrolling up
                .height(min: 250, max: 400) // Specify min and max heights for header
                .ignoresSafeArea(edges: .top) // Allow content to extend under the toolbar
            }
    }
}

#Preview {
    TripDetailView()
}
