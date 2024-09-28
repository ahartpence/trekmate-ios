import SwiftUI

struct WeatherItem: Identifiable {
    let id = UUID()
    let date: String
    let highTemp: String
    let lowTemp: String
    let rainChance: Int
    let sunrise: String
    let sunset:  String
    let iconName: String
}

struct WeatherRow: View {
    let item: WeatherItem
    let showDivider: Bool
    
    var body: some View {
        HStack(spacing: 18) {
            Image(systemName: item.iconName)
                .font(.title)
                .foregroundStyle(.yellow)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(item.date)
                    .font(.headline)
                HStack (spacing: 2) {
                    Text("H: \(item.highTemp)°")
                    Text("L: \(item.lowTemp)°")
                }
                .font(.subheadline)
                .foregroundStyle(.secondary)
            }
            
            VStack  (alignment: .leading){
                HStack {
                    Image(systemName: "drop")
                        .frame(width: 20)
                    Text("\(item.rainChance)%")
                }
                HStack {
                    Image(systemName: "sunrise")
                        .frame(width: 20)
                    Text("\(item.sunrise)")
                }
                HStack {
                    Image(systemName: "sunset")
                        .frame(width: 20)
                    Text("\(item.sunset)")
                }
            }
            .font(.subheadline)
            .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.vertical, 10)
        .overlay(
            Group {
                if showDivider {
                    Rectangle()
                        .frame(height: 1)
                        .foregroundStyle(.border)
                        .padding(.leading, 40)
                }
            },
            alignment: .bottom
        )
    }
}

struct WeatherSection: View {
    let weatherItems: [WeatherItem] = [
        WeatherItem(date: "Oct 26, 2024", highTemp: "65", lowTemp: "45", rainChance: 5, sunrise: "8:07 AM", sunset: "6:23 PM", iconName: "moon.stars.fill"),
        WeatherItem(date: "Oct 27, 2024", highTemp: "65", lowTemp: "45", rainChance: 5, sunrise: "8:07 AM", sunset: "6:23 PM", iconName: "moon.stars.fill"),
        WeatherItem(date: "Oct 28, 2024", highTemp: "65", lowTemp: "45", rainChance: 5, sunrise: "8:07 AM", sunset: "6:23 PM", iconName: "moon.stars.fill")
    ]
    
    var body: some View {
        VStack (alignment: .leading, spacing: 8) {
            VStack(alignment: .leading) {
                Text("Weather")
                    .font(.title.weight(.semibold))
                    .foregroundStyle(.primary)
                Text("Forecast for Honor, Mi Oct 26 - 29, 2024")
                    .font(.subheadline.weight(.light))
                    .foregroundStyle(.secondary)
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.bottom, 5)

            ForEach(weatherItems.indices, id: \.self) { index in
                let item = weatherItems[index]
                WeatherRow(item: item, showDivider: index != weatherItems.count - 1)
            }
        }
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .stroke(.border, lineWidth: 1)
        )
        .padding(.horizontal, 10)
        .padding(.top, 20)
    }
}

#Preview {
    WeatherSection()
}
