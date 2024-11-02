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

struct rewrite: View {
    @EnvironmentObject var tripVM: TripViewModel
    @Environment(\.colorScheme) var colorScheme
    var trip: Trip?
    
    func formattedTimeInterval(from startDate: Date, to endDate: Date) -> (days: Int, hours: Int, minutes: Int) {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day, .hour, .minute], from: startDate, to: endDate)
        
        let days = components.day ?? 0
        let hours = components.hour ?? 0
        let minutes = components.minute ?? 0
        
        return (days, hours, minutes)
    }
    
    func formattedDateString(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, dd MMM"
        return dateFormatter.string(from: date)
    }
    
    func formattedTimeString(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        return dateFormatter.string(from: date)
    }
    
    var body: some View {
        let timeInterval = formattedTimeInterval(from: trip?.startDate ?? Date(), to: trip?.endDate ?? Date().addingTimeInterval(((30 * 60 * 24) * 48) - 50))
        HStack (spacing: 0) {
            VStack (spacing: 0) {
                Text("\(timeInterval.days)d")
                    .font(.title.weight(.bold))
                Text("\(timeInterval.minutes) minutes")
                    .font(.subheadline.weight(.thin))
            }
            .padding(.trailing, 5)
            
            VStack (spacing: 3) {
                HStack (spacing: 5) {
                     Image(systemName: "location")
                        .resizable()
                        .frame(width: 12, height: 12)
                        .padding(.horizontal, 3)
     
                    Text("\(trip?.location?.campArea?.name.capitalized ?? "Platte River Campground")")
                        .font(.caption.weight(.light))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Spacer()
                    Text("\(formattedDateString(from: trip?.startDate ?? Date()))")
                        .font(.caption.weight(.light))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                HStack {
                    VStack (alignment: .leading, spacing: 3){
                        Text("\(trip?.name ??  "Summer 2025 Campathon HC")")
                            .font(.headline.weight(.bold))
                        HStack {
                            Text("Detroit HC")
                                .font(.subheadline.weight(.bold))
                            Text("to")
                                .font(.subheadline.weight(.regular))
                            Text("\(trip?.location?.campArea?.address?.last?.city ?? "Honor HC")")
                                .font(.subheadline.weight(.bold))
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                HStack {
                    Circle()
                         .frame(width: 15, height: 15)
                         .foregroundColor(.green)
                         .overlay(
                             Image(systemName: "arrow.up.right")
                                .resizable()
                                .scaledToFill()
                                .foregroundColor(.black)
                                .frame(width: 5, height: 5)
                         )
                    Text("\(formattedTimeString(from: trip?.startDate ?? Date()))")
                        .font(.subheadline)
                    Circle()
                         .frame(width: 15, height: 15)
                         .foregroundColor(.red)
                         .overlay(
                             Image(systemName: "arrow.down.right")
                                .resizable()
                                .scaledToFill()
                                .foregroundColor(.black)
                                .frame(width: 5, height: 5)
                         )
                    Text("7:40 PM HC")
                        .font(.subheadline)
                    Circle()
                         .frame(width: 15, height: 15)
                         .foregroundColor(.gray)
                         .overlay(
                             Image(systemName: "car")
                                .resizable()
                                .scaledToFill()
                                .foregroundColor(.black)
                                .frame(width: 5, height: 5)
                         )
                    Text("431 mi HC")
                        .font(.subheadline)
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 10)
            }
        }
        .padding(.horizontal, 5)
    }
    
    
}
#Preview {
    rewrite()
}


//
//struct TripCardView_Previews: PreviewProvider {
//    
//    static var previews: some View {
//        TripCardView()
//    }
//}
