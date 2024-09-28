//
//  EquipmentCardView.swift
//  TrekMate
//
//  Created by Andrew Hartpence on 10/24/24.
//
import SwiftUI

struct EquipmentSection: View {
    var body: some View {
        
            VStack (alignment: .leading, spacing: 7) {
                HStack {
                    VStack (alignment: .leading) {
                        Text("Equipment")
                            .font(.title2.weight(.semibold))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text("What equipment is being brought")
                            .font(.callout.weight(.semibold))
                            .foregroundStyle(.secondary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    Image(systemName: "plus")
                        .onTapGesture {
                            print("open equipment view")
                        }
                }
                .padding(.top, 10)
                .padding(.horizontal, 8)

                
                Divider()
                
                ScrollView {
                    GearListSwiftUIView()
                }
                .frame(height: 200)
            }
            .overlay(
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .stroke(.border, lineWidth: 1)
            )
            .padding(.horizontal, 10)
            .padding(.top, 20)
        
    }
}

#Preview {
    EquipmentSection()
}
