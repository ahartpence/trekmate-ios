//
//  ProfileView.swift
//  TrekMate
//
//  Created by Andrew Hartpence on 10/25/24.
//

import SwiftUI

struct ProfileView: View {
    @StateObject var viewModel = ProfileViewModel()
    
    var body: some View {
        
        VStack (spacing: 20) {
            //MARK: - Header
            HStack {
                ZStack {
                    Circle()
                        .foregroundStyle(.cyan)
                        .frame(width: 40, height: 40)
                    Text("\(viewModel.firstName.prefix(1))\(viewModel.lastName.prefix(1))")
                        .foregroundStyle(.white)
                        .font(.subheadline.weight(.semibold))
                    
                }
                
                VStack (alignment: .leading){
                    Text("\(viewModel.firstName) \(viewModel.lastName)")
                        .font(.title2.weight(.semibold))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("My trip log • \(viewModel.homeLocation)")
                        .font(.callout.weight(.thin))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                }
                
                Image(systemName: "x.circle.fill")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 25, height: 25)
                    .foregroundStyle(.primary, .brown)
                    .symbolRenderingMode(.palette)
                    .padding(.bottom, 10)
                
            }
            .padding(.horizontal, 10)
            
            //MARK: - Separator
            Rectangle()
                .frame(width: UIScreen.main.bounds.width - 20, height: 0.5)
                .foregroundStyle(.separator)
                .padding(.horizontal, 10)
            
            
            //MARK: - 2024 Stats Section
            ZStack {
                VStack {
                    HStack {
                        Text("2024 stats")
                            .foregroundStyle(.brown)
                        Spacer()
                        Image(systemName: "arrow.right")
                            .foregroundStyle(.brown)
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                    .padding([.top,.horizontal], 20)
                    
                    HStack {
                        VStack (alignment: .leading){
                            Text("22222222")
                                .font(.largeTitle.weight(.bold))
                            Text("Activities")
                                .font(.callout.weight(.regular))
                        }
                        .frame(width: 140, height: 90, alignment: .leading)
                        
                        Rectangle()
                            .frame(width: 0.5, height: 90)
                            .padding(.horizontal, 10)
                        VStack (alignment: .leading) {
                            Text("468.37")
                                .font(.largeTitle.weight(.bold))
                            Text("Miles")
                        }
                        .frame(width: 170, height: 90, alignment: .leading)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .frame(height: 120)
                    
                    
                }
                
            }
            .background(.gray.opacity(0.2))
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .frame(width: UIScreen.main.bounds.width - 20)
        
            
        }
    }
}

#Preview {
    ProfileView()
}
