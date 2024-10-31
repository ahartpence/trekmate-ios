//
//  NewTripView.swift
//  TrekMate
//
//  Created by Andrew Hartpence on 10/9/24.
//
import SwiftUI


struct AddTrip: View {
    @ObservedObject var tripVM: TripViewModel
    @ObservedObject var uiVM: UIModel
    
    var isCreateEnabled: Bool {
        return tripVM.selectedFacility != nil && !tripVM.tripName.trimmingCharacters(in: .whitespaces).isEmpty
    }
    
    
    @State private var startDate: Date = Date().addingTimeInterval((60 * 60 * 24) * 3)
    @State private var endDate = Date().addingTimeInterval((60 * 60 * 24) * 9)

    
    var body: some View {
        
        VStack {
            
            HStack {
                Button {
                    uiVM.showingAddTripSheet.toggle()
                } label: {
                    Text("Cancel")
                }
                
                Spacer()
                
                Text("Create Trip")
                    .font(.title3.weight(.semibold))
                    .frame(maxWidth: .infinity, alignment: .center)
                
                Button {
                    tripVM.createTrip(name: tripVM.tripName, description: nil, location: Location(campArea: tripVM.selectedFacility), startDate: startDate, endDate: endDate, attendees: [], status: .planning)
                    uiVM.showingAddTripSheet.toggle()
                    tripVM.selectedFacility = nil
                } label: {
                    Text("Create")
                }
                .disabled(!isCreateEnabled )
                
                Spacer()
                

            }
            .padding([.horizontal, .vertical], 20)
            .background(Color(UIColor.systemGray6))

            
            Form {
                Section (header: Text("Trip")) {
                    TextField("Trip Name", text: $tripVM.tripName)
                    
                    VStack (alignment: .leading){
                        HStack {
                            Text("Start")
                            Spacer()
                            Text("End")
                        }
                        HStack {
                            DatePicker("",selection: $startDate, displayedComponents: .date)
                                .frame(width: 135)
                            Spacer()
                            Image(systemName: "arrow.right")
                            Spacer()
                            DatePicker("",selection: $endDate, displayedComponents: .date)
                                .frame(width: 135)
                        }
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                }

                Section (header: Text("Destination")) {
                    
                    if tripVM.selectedFacility == nil {
                        HStack {
                            Image(systemName: "plus.circle.fill")
                                .symbolRenderingMode(.hierarchical)
                                .foregroundStyle(.blue)
                            Menu("Add") {
                                Button {
                                    uiVM.showingCampgroundSearchSheet.toggle()
                                } label: {
                                    Label("Campground", systemImage: "mountain.2")
                                }
                                Button {
                                    uiVM.showingBackcountrySearchSheet.toggle()
                                } label: {
                                    Label("Dispersed / Backcountry", systemImage: "globe")
                                }

                            }
                           
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity , alignment: .leading)
                    } else {
                        HStack {
                            Image("Paypal")
                            VStack (alignment: .leading){
                                Text(tripVM.selectedFacility?.name ?? "Error")
                                    .font(.headline)
                                Text(tripVM.selectedFacility?.recArea?.last?.name ?? "Error")
                                    .font(.subheadline.weight(.light))
                                Text("\(tripVM.selectedFacility?.address?.last?.city.capitalized ?? "Error") \(tripVM.selectedFacility?.address?.last?.stateCode ?? "Error")")
                                    .font(.subheadline.weight(.ultraLight))
                            }
                            Spacer()
                            Image(systemName: "x.circle.fill")
                                .symbolRenderingMode(.hierarchical)
                                .foregroundStyle(.mint)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity , alignment: .leading)
                        
                    }
                    
                    
                    
                }
            }
            .scrollContentBackground(.hidden)
            
        }
        .background(Color(UIColor.systemGray3))
        .sheet(isPresented: Binding<Bool>(
            get: { tripVM.selectedFacility == nil && uiVM.showingCampgroundSearchSheet },
            set: { isPresented in
                if !isPresented {
                    uiVM.showingCampgroundSearchSheet = false
                }
            }
        )) {
            RecGovSearchSheet(uiVM: uiVM)
        }
    }
}


