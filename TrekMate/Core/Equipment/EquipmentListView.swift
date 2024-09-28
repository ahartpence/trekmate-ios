//
//  EquipmentView.swift
//  TrekMate
//
//  Created by Andrew Hartpence on 10/23/24.
//

import SwiftUI

enum Product: String, CaseIterable {
    case tent = "Tent"
    case backpack = "Backpack"
    case cooler = "Cooler"
    case sleepingBag = "Sleeping Bag"
    case tool = "Tool"

    var icon: Image {
        switch self {
        case .tent:
            return Image(systemName: "tent.fill")
        case .backpack:
            return Image(systemName: "backpack.fill")
        case .cooler:
            return Image(systemName: "cube.box.fill")
        case .sleepingBag:
            return Image(systemName: "bed.double.fill")
        case .tool:
            return Image(systemName: "wrench.fill")
        }
    }
}

struct Equipment: Identifiable {
    let id = UUID()
    var name: String
    var type: Product

    var icon: Image {
        type.icon
    }
}

struct EquipmentView: View {
    @State private var equipmentList: [Equipment] = [
        Equipment(name: "Mountain Tent", type: .tent),
        Equipment(name: "Explorer Backpack", type: .backpack),
        Equipment(name: "Travel Cooler", type: .cooler),
        Equipment(name: "Sleeping Bag", type: .sleepingBag),
        Equipment(name: "Multi-tool", type: .tool)
    ]
    
    @State private var isShowingAddEquipmentSheet = false

    var body: some View {
        NavigationView {
            List {
                ForEach(Product.allCases, id: \.self) { productType in
                    Section(header: Text(productType.rawValue)) {
                        ForEach(equipmentList.filter { $0.type == productType }) { equipment in
                            HStack {
                                equipment.icon
                                Text(equipment.name)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Equipment")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isShowingAddEquipmentSheet.toggle()
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $isShowingAddEquipmentSheet) {
                AddEquipmentView(equipmentList: $equipmentList)
            }
        }
    }
}

struct AddEquipmentView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var name: String = ""
    @State private var selectedProduct: Product = .tent
    @Binding var equipmentList: [Equipment]
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Equipment Name", text: $name)
                
                Picker("Type", selection: $selectedProduct) {
                    ForEach(Product.allCases, id: \.self) { product in
                        Text(product.rawValue).tag(product)
                    }
                }
                
                Button("Add Equipment") {
                    let newEquipment = Equipment(name: name, type: selectedProduct)
                    equipmentList.append(newEquipment)
                    dismiss()
                }
            }
            .navigationTitle("Add Equipment")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    EquipmentView()
}
