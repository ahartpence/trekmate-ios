//
//  EquipmentListViewRepresentable.swift
//  TrekMate
//
//  Created by Andrew Hartpence on 10/24/24.
//

import SwiftUI

struct GearItem: Identifiable {
    let id = UUID()
    let name: String
    let sharedBy: String?
    let sharedByImage: Image?
}

struct GearListSwiftUIView: View {
    let gearItems: [GearItem] = [
        GearItem(name: "Tent", sharedBy: nil, sharedByImage: nil),
        GearItem(name: "Cooler", sharedBy: nil, sharedByImage: nil),
        GearItem(name: "25' Tarp", sharedBy: "David", sharedByImage: Image("GoldApple")),
        GearItem(name: "Collapseable Sink", sharedBy: "Andrew", sharedByImage: Image("BookStore")),
        GearItem(name: "Camp Stove", sharedBy: nil, sharedByImage: nil),
        GearItem(name: "Biiiig cooler", sharedBy: "Nick", sharedByImage: Image("Paypal"))
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ForEach(gearItems) { gear in
                GearRowView(gear: gear)
                    .padding(.vertical, 8)
                    .padding(.horizontal)
                Divider()
            }
            .frame(width: .infinity, height: 25)
        }
    }
}

struct GearRowView: View {
    let gear: GearItem

    var body: some View {
        HStack {
            Text(gear.name)
                .font(.body)
                .foregroundColor(.primary)
            Spacer()
            if let sharedBy = gear.sharedBy, let sharedByImage = gear.sharedByImage {
                HStack(spacing: 8) {
                    sharedByImage
                        .resizable()
                        .frame(width: 24, height: 24)
                        .clipShape(Circle())
                    Text("Shared By: \(sharedBy)")
                        .font(.subheadline)
                        .foregroundColor(.primary)
                }
                .padding(.vertical, 4)
                .padding(.horizontal, 8)
                .background(Color(.systemGray5))
                .cornerRadius(15)
            }
        }
    }
}


#Preview {
    GearListSwiftUIView()
}
