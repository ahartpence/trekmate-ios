//
//  LogView.swift
//  TrekMate
//
//  Created by Andrew Hartpence on 10/28/24.
//
import SwiftUI

struct LogView: View {
    @StateObject var viewModel: ProfileViewModel = ProfileViewModel()
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        VStack {
            //MARK: - Header
            HStack (spacing: 16) {
                Text("Logbook")
                    .font(.title2.weight(.bold))
                Spacer()
                Image(systemName: "magnifyingglass.circle.fill")
                    .resizable()
                    .scaledToFill()
                    .symbolRenderingMode(.hierarchical)
                    .foregroundStyle(.indigo)
                    .frame(width: 25, height: 25)
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .scaledToFill()
                    .symbolRenderingMode(.hierarchical)
                    .foregroundStyle(.indigo)
                    .frame(width: 25, height: 25)
                
            }
            .padding(.top, 10)
            
            //MARK: - Profile Stats
            HStack {
                ZStack {
                    Circle()
                        .foregroundStyle(.cyan)
                        .frame(width: 40, height: 40)
                    Text("\(viewModel.firstName.prefix(1))\(viewModel.lastName.prefix(1))")
                        .foregroundStyle(.white)
                        .font(.subheadline.weight(.semibold))
                    
                }
                
                VStack (alignment: .leading) {
                    Text("4,312")
                    HStack (spacing: 2) {
                        Image(systemName: "location.circle.fill")
                            .symbolRenderingMode(.hierarchical)
                            .foregroundStyle(.gray)
                        Text("miles driven")
                            .font(.caption.weight(.thin))
                    }
                }
                
                Rectangle()
                    .frame(width: 0.5, height: 40)
                
                VStack (alignment: .leading){
                    Text("20 Nights")
                    HStack (spacing: 2) {
                        Image(systemName: "calendar")
                            .symbolRenderingMode(.hierarchical)
                            .foregroundStyle(.gray)
                        Text("Nights outdoor")
                            .font(.caption.weight(.thin))
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.bottom, 20)
            
            
            //MARK: - Upcoming Trips section
            Section {
                HStack {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .scaledToFill()
                        .foregroundColor(.blue)
                        .symbolRenderingMode(.hierarchical)
                        .font(.headline)
                        .frame(width: 25, height: 25)
                    
                    Text("Add Your Next Trip")
                        .foregroundColor(.blue)
                        .symbolRenderingMode(.hierarchical)
                        .font(.headline)
                        .padding(.horizontal, 20)
                    
                    Spacer()
                }
                .padding()
                .background(Color.white)
                .cornerRadius(12)
                .padding(.bottom, 30)
                
            }header: {
                VStack {
                    Text("Upcoming Trips")
                        .font(.title3.weight(.semibold))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            //MARK: - Historical Trips section
            Section {
                HStack {
                    Text("No Recordings")
                        .foregroundColor(.gray)
                        .font(.subheadline.weight(.medium))
                        .padding(.horizontal, 20)
                    
                    Spacer()
                }
                .padding()
                .background(Color.white)
                .cornerRadius(12)
                .padding(.bottom, 30)
                
            }header: {
                VStack (alignment: .leading){
                    Text("2024/2025 Season")
                        .font(.title3.weight(.semibold))
                    HStack {
                        Image(systemName: "arrow.down")
                        Text("0.0k FT")
                        
                        Rectangle()
                            .frame(width: 0.5, height: 20)
                        
                        Image(systemName: "calendar")
                        Text("0 days")
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            
        }
        .padding(.horizontal, 20)
        .background(.gray.opacity(0.2))
    }
}

#Preview {
    LogView()
}
