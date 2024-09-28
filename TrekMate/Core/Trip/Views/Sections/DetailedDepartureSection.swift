//
//  DetailedDepartureSection.swift
//  TrekMate
//
//  Created by Andrew Hartpence on 10/26/24.
//
import SwiftUI

struct DetailedDepartureSection: View {
    var body: some View {
        VStack (alignment: .leading, spacing: 5){
            HStack {
                Image(systemName: "arrow.up.right")
                    .font(.headline.weight(.semibold))
                Text("Home • Detroit, Mi")
                    .font(.footnote.weight(.semibold))
            }
            
            VStack (alignment: .leading) {
                Text("8:30 AM")
                    .font(.title)
                Text("12d 21m until departure")
                    .font(.footnote)
            }
            
            HStack {
                Image(systemName: "clock")
                    .font(.caption)
                Text("1h 50m • 456 mi")
                    .font(.caption)
                
                Rectangle()
                    .frame(width: UIScreen.main.bounds.width - 170, height: 0.5)
               
            }
            .padding(.vertical, 10)
            .foregroundStyle(.separator)
            
            HStack {
                Image(systemName: "arrow.down.right")
                    .font(.headline.weight(.semibold))
                Text("Sleeping Bear Dunes • Platte River Campground")
                    .font(.footnote.weight(.semibold))
            }
            
            VStack (alignment: .leading) {
                Text("6:15 PM")
                    .font(.title)
                Text("12d 6h 21m until arrival")
                    .font(.footnote)
            }
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 20)
    }
}

#Preview {
    DetailedDepartureSection()
}
