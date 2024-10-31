//
//  FacilityListItem.swift
//  TrekMate
//
//  Created by Andrew Hartpence on 10/31/24.
//
import SwiftUI
import SwiftRecGovApi

struct FacilityListItem: View {
    @StateObject var searchVM: SearchViewModel = SearchViewModel()
    @EnvironmentObject var tripVM: TripViewModel
    let facility: Facility?

    
    var body: some View {
        HStack {
            Image(systemName: "location")
                .resizable()
                .scaledToFit()
                .foregroundStyle(.white)
                .padding(8)
                .frame(width: 40, height: 40)
                .background(Color.darkForestGreen)
                .clipShape(RoundedRectangle(cornerRadius: 10))
              
            
            
            VStack (alignment: .leading) {
                Text("\(facility?.name ?? "Platte River Campground")")
                    .font(.headline)
                Text("\(facility?.recArea?.last?.name ?? "Sleeping Bear Dunes Recreation Area")")
                    .font(.callout.weight(.light))
                HStack {
                    Text("\(facility?.address?.last?.city.capitalized ?? "No City"), \(facility?.address?.last?.stateCode ?? "No State")")
                        .font(.subheadline.weight(.thin))
                    
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
    
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 10)
        .padding(.vertical, 10)
        .overlay(
            Group {
                
                    Rectangle()
                        .frame(height: 1)
                        .foregroundStyle(.border)
                        .padding(.horizontal, 40) // Adjust to align with text
                
            },
            alignment: .bottom
        )
        .onTapGesture {
            tripVM.selectedFacility = facility
            print("Tapped Facility is: \(facility?.name)")
        }
    }
}
