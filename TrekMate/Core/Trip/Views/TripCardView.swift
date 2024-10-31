import SwiftUI
import MapKit


struct TripCardView: View {
    @EnvironmentObject var tripVM: TripViewModel
    var trip: Trip

    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d"
        return formatter
    }()
    
    var body: some View {
        if let routeDetails = tripVM.tripRouteDetails[trip] {
            VStack {
                ZStack {
                    // Background Layer
                    ZStack {
                        Image("campground")
                            .resizable()
                            .scaledToFill()
                            .frame(width: UIScreen.main.bounds.width - 40, height: 400)
                            .clipped()
                    }
                    // Map Layer
                    ZStack {
                        
                        MapView(routeDetails: routeDetails)
                            .frame(width: 120, height: 120)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                        
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                    .padding(.trailing, 20)
                    .padding(.bottom, 20)
                }
                .frame(height: 400)
                .frame(maxWidth: .infinity)
                .clipShape(RoundedRectangle(cornerRadius: 30))
                .padding(.horizontal, 20)
                
                VStack(alignment: .leading, spacing: 5) {
                    Text(trip.name)
                        .font(.title2.weight(.bold))
                        .foregroundColor(.primary)
                    
                    HStack (spacing: 20) {
                        VStack (alignment: .leading) {
                            Text("\((trip.tripDuration)) Nights") // Days -1 to get number of nights
                                .font(.callout.weight(.semibold))
                                .foregroundStyle(.primary)
                            Text("\(dateFormatter.string(from: trip.startDate)) - \(dateFormatter.string(from: trip.endDate))")
                                .font(.footnote.weight(.light))
                        }
                        
                        Rectangle()
                            .frame(width: 1, height: 40)
                            .foregroundStyle(.separator)
                        
                        
                        
                        VStack (alignment: .leading) {
                            //840 Miles
                            Text(routeDetails.route.distance.formattedDistance())
                                .font(.callout.weight(.semibold))
                                .foregroundStyle(.primary)
                            //12 Hours
                            Text(routeDetails.route.expectedTravelTime.formattedTravelTime())
                                .font(.footnote.weight(.light))
                        }
                        
                        Rectangle()
                            .frame(width: 1, height: 40)
                            .foregroundStyle(.separator)
                        
                        
                        
                        VStack (alignment: .leading) {
                            //7 days left
                            Text("\((trip.tripCountdownDaysLeft)) days left")
                                .font(.callout.weight(.semibold))
                                .foregroundStyle(.primary)
                            
                            Text("until camping")
                                .font(.footnote.weight(.light))
                        }
                    }
                    .padding(.vertical, 3)
                    
                    HStack (spacing: 4) {
                        Image(systemName: "mappin.and.ellipse")
                            .foregroundStyle(.secondary)
                        //Text("Sleeping Bear Dunes • Platte River Campground")
                        Text("\(trip.location?.campArea?.name.capitalized ?? "Error") • \(trip.location?.campArea?.recArea?.last?.name ?? "Error")")
                            .font(.subheadline.weight(.light))
                            .foregroundStyle(.foreground)
                    }
                    
                    HStack (spacing: 4) {
                        Image(systemName: "location")
                            .foregroundStyle(.secondary)
                        // Text("Honor, MI")
                        Text("\(trip.location?.campArea?.address?.last?.city.capitalized ?? "Error"), \(trip.location?.campArea?.address?.last?.stateCode ?? "Error")")
                            .font(.subheadline.weight(.light))
                            .foregroundStyle(.foreground)
                    }
                    
                    
                }
                
            }
            .background(.background)
        }
    }
}


//
//struct TripCardView_Previews: PreviewProvider {
//    
//    static var previews: some View {
//        TripCardView()
//    }
//}
