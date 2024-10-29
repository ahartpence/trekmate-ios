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
    @State var tripDestination: Location?
    
    @State private var startDate: Date = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm:ss ZZZ"
        dateFormatter.timeZone = TimeZone(abbreviation: "EST")
        return dateFormatter.date(from: "2024/10/21 12:12:12 -0500") ?? Date()
    }()
    @State private var endDate = Date()

    
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
                    uiVM.showingAddTripSheet.toggle()
                } label: {
                    Text("Create")
                }
                
                Spacer()
                

            }
            .padding([.horizontal, .vertical], 20)
            .background(Color(UIColor.systemGray6))

            
            Form {
                Section (header: Text("Trip")) {
                    TextField("Trip Name", text: $tripName)
                    
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
                    
                    if tripDestination == nil {
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
                                Text("Platte River Campground")
                                    .font(.headline)
                                Text("Sleeping Bear Dunes")
                                    .font(.subheadline.weight(.light))
                                Text("Michigan, United States")
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
        .sheet(isPresented: $uiVM.showingCampgroundSearchSheet) {
            SearchSheet(uiVM: uiVM)
        }
        
    }
    
}

struct SearchSheet: View {
    @ObservedObject var uiVM: UIModel
    @StateObject var searchVM: SearchViewModel = SearchViewModel()
    
    
    let numbers = Array(1...25)
    
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
                Text("\(recArea.description)")
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
    let facility: Facility
    
    var body: some View {
        HStack {
            Image("GoldApple")
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            VStack (alignment: .leading) {
                Text("\(facility.name)")
                    .font(.headline)
                Text("Honor, Mi")
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


#Preview {
    @Previewable @StateObject var uiVM: UIModel = UIModel()
    @Previewable @StateObject var tripVM: TripViewModel = TripViewModel()
    
    AddTrip(tripVM: tripVM ,uiVM: uiVM)
}


