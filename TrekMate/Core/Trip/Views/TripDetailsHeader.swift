//
//  TripDetailsHeader.swift
//  TrekMate
//
//  Created by Andrew Hartpence on 10/26/24.
//
import SwiftUI

struct TripDetailsHeader: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Summer 2025 Campathon")
                .font(.title.weight(.semibold))
                .foregroundColor(.primary)
                .frame(maxWidth: .infinity, alignment: .leading)
            HStack {
                VStack (alignment: .leading) {
                    Text("Sleeping Bear Dunes")
                        .font(.title2)
                    Text("Platte River Campground")
                        .font(.title3)
                    Text("Loop 5 • Campsite 401")
                        .foregroundColor(.secondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                VStack (alignment: .trailing){
                    HStack {
                        VStack (alignment: .center){
                            Text("23")
                                .font(.callout)
                            Text("October")
                                .font(.caption)
                        }
                        
                        
                        Rectangle()
                            .frame(width: 10, height: 0.5)
                        
                        
                        VStack (alignment: .center){
                            Text("27")
                                .font(.callout)
                            Text("October")
                                .font(.caption)
                        }
                        
                    }
                }
                .frame(maxWidth: 130, alignment: .trailing)
                
            }
            
            
            
        }
        .padding(.top, 10)
        .padding(.horizontal, 15)
    }
}


#Preview {
    TripDetailsHeader()
}
