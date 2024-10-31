//
//  NewTripView.swift
//  TrekMate
//
//  Created by Andrew Hartpence on 10/9/24.
//
import SwiftRecGovApi
import SwiftUI


struct AddTrip: View {
    @ObservedObject var tripVM: TripViewModel
    @ObservedObject var uiVM: UIModel
    
    @State var tripName: String = ""
    
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
            SearchSheet(uiVM: uiVM)
        }
    }
}

#Preview {
    @Previewable @StateObject var tripVM: TripViewModel = TripViewModel()
    @Previewable @StateObject var uiVM = UIModel()
    AddTrip(tripVM: tripVM, uiVM: uiVM)
}

struct SearchSheet: View {
    @ObservedObject var uiVM: UIModel
    @StateObject var searchVM: SearchViewModel = SearchViewModel()
    
    var body: some View {
        VStack {
            ZStack {
                Button {
                    uiVM.showingCampgroundSearchSheet.toggle()
                } label: {
                    Text("Close")
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("Destination")
                    .font(.title2.weight(.bold))
                    .frame(maxWidth: .infinity, alignment: .center)
                
            }
            .padding([.horizontal, .vertical], 20)
            
                
            TextField("search...", text: $searchVM.searchText)
                .foregroundColor(.primary)
                .padding(.horizontal, 5)
                .padding(.bottom, 10)
                .autocorrectionDisabled()
                .textFieldStyle(TrekMateTextFieldStyle())
                
    
            
            
            ScrollView {
                VStack (spacing: 0){
                    ForEach(searchVM.searchResults) { item in
                        switch item {
                        case .recArea(let recArea):
                            RecAreaListItem(recArea: recArea)
                        case .facility(let facility):
                            FacilityListItem(facility: facility)
                        }
                    }
                    
                }
                .background(Color(UIColor.systemGray5))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                
            }
            
            
        }
        .padding(.horizontal, 10)
        .background(Color(UIColor.systemGray3))

        
    }
}

struct RecAreaListItem: View {
    let recArea: RecArea
    
    var body: some View {
        HStack {
            Image("Paypal")
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            VStack (alignment: .leading) {
                Text("\(recArea.name)")
                    .font(.headline)
                Text("\(recArea.address?.last?.city.capitalized ?? "No City"), \(recArea.address?.last?.countryCode ?? "No Country Code")")
                    .font(.subheadline.weight(.light))
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
    }
}

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


#Preview {
    @Previewable @StateObject var uiVM: UIModel = UIModel()
    @Previewable @StateObject var tripVM: TripViewModel = TripViewModel()
    
    AddTrip(tripVM: tripVM ,uiVM: uiVM)
}

#Preview {
    FacilityListItem(facility: nil)
        
}

