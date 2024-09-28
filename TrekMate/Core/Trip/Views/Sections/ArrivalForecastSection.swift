
//
//  ArrivalForecastItem.swift
//  TrekMate
//
//  Created by Andrew Hartpence on 10/26/24.
//


import SwiftUI

struct ArrivalForecastItem: Identifiable {
    let id = UUID()
    let name: String
    let estimatedArrival: String
    let progress: Double
    let profileImage: Image
}

struct ArrivalForecastRow: View {
    let item: ArrivalForecastItem
    let showDivider: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(item.name)
                    .font(.headline)
                Text("•")
                Text("Estimated: \(item.estimatedArrival)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .padding(.bottom, 5)
            
            ZStack(alignment: .leading) {
                // Progress bar background
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color.gray.opacity(0.3))
                    .frame(height: 10)
                
                // Progress bar
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color.blue)
                    .frame(width: CGFloat(item.progress * 200), height: 10) 
                
                // Profile picture overlay
                item.profileImage
                    .resizable()
                    .background(.orange)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 2))
                    .frame(width: 30, height: 30)
                    .offset(x: CGFloat(item.progress * 200) - 12.5) // Center the profile image on the progress bar
            }
            .padding(.bottom, 10)
            
            if showDivider {
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.gray.opacity(0.5))
                    .padding(.leading, 0)
            }
        }
        .padding(.horizontal, 5)
    }
}

struct ArrivalForecastSection: View {
    let items: [ArrivalForecastItem] = [
        ArrivalForecastItem(name: "David", estimatedArrival: "8:41 PM", progress: 0.75, profileImage: Image(systemName: "person.fill")),
        ArrivalForecastItem(name: "Taylor", estimatedArrival: "2:11 PM", progress: 0.25, profileImage: Image(systemName: "person.fill"))
        // Add more items as needed
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 7) {
            VStack(alignment: .leading) {
                Text("Arrival Forecast")
                    .font(.title2.weight(.semibold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("When is everyone arriving")
                    .font(.callout.weight(.semibold))
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.horizontal, 8)
            
            ForEach(items.indices, id: \.self) { index in
                let item = items[index]
                ArrivalForecastRow(item: item, showDivider: index != items.count - 1)
            }
        }
        .padding(.horizontal, 5)
        .padding(.vertical, 5)
        .overlay(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .stroke(Color.gray.opacity(0.5), lineWidth: 1)
        )
        .padding(.top, 10)
        .padding(.horizontal, 10)
    }
}

#Preview {
    ArrivalForecastSection()
}
