//
//  AlertSection.swift
//  TrekMate
//
//  Created by Andrew Hartpence on 10/26/24.
//

import SwiftUI

struct AlertSection: View {
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        HStack {
            
            Image(systemName: "wrongwaysign.fill")
                .resizable()
                .scaledToFill()
                .symbolRenderingMode(.hierarchical)
                .frame(width: 30, height: 30)
            
            
            VStack (alignment: .leading){
                Text("Juniper Lake Road Closed")
                    .foregroundStyle(.red)
                    .fontWeight(.semibold)
                Text("Juniper Lake Road remains closed to vehicle traffic after the 2021 Dixie Fire. There is no current re-opening date.")
                    .font(.callout.weight(.thin))
                    .foregroundStyle(.pink)
            }
         
            
            
           
        }
        .frame(maxWidth: .infinity,  alignment: .leading)
        .padding(.vertical, 13)
        .padding(.horizontal, 15)
        .background(
            Rectangle()
                .fill(Color.darkRed.opacity(colorScheme == .dark ? 0.9 : 0.05))
        )
        .overlay(Rectangle().frame(width: nil, height: 0.25, alignment: .top).foregroundColor(Color.darkRed.opacity(colorScheme == .dark ? 1 : 0.15)), alignment: .top)
        .overlay(Rectangle().frame(width: nil, height: 0.5, alignment: .top).foregroundColor(Color.darkRed.opacity(colorScheme == .dark ? 1 : 0.25)), alignment: .bottom)
    }
}

extension Color {
    static let darkRed = Color(rgb: 0x580000)
}


#Preview {
    AlertSection()
}
