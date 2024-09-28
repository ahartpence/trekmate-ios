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
            CampgroundSearchSheet(uiVM: uiVM)
        }
        .sheet(isPresented: $uiVM.showingBackcountrySearchSheet) {
            BackcountrySearchSheet(uiVM: uiVM)
        }
    }
    
}

struct CampgroundSearchSheet: View {
    @ObservedObject var uiVM: UIModel
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
                
                Text("Campground")
                    .font(.title2.weight(.bold))
                    .frame(maxWidth: .infinity, alignment: .center)
                
            }
            .padding([.horizontal, .vertical], 20)
            
                
            TextField("search...", text: .constant(""))
                .foregroundColor(.primary)
                .padding(.horizontal, 5)
                .padding(.bottom, 10)
                .textFieldStyle(TrekMateTextFieldStyle())
    
            
            
            ScrollView {
                VStack (spacing: 0){
                    HStack {
                        Image("nps")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 50, height: 50)
                            .background(.clear)
                            .clipped()
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        
                        VStack (alignment: .leading) {
                            Text("Platte River Campground ")
                                .font(.headline)
                            Text("Austria")
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

                    
                    
                    HStack {
                        Image("Paypal")
                            .background(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        
                        VStack (alignment: .leading) {
                            Text("Annaberg")
                                .font(.headline)
                            Text("Austria")
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
                .background(Color(UIColor.systemGray5))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                
            }
            
            
        }
        .padding(.horizontal, 10)
        .background(Color(UIColor.systemGray3))

    }
}

struct BackcountrySearchSheet: View {
    @ObservedObject var uiVM: UIModel
    let numbers = Array(1...25)
    var body: some View {
        VStack {
            ZStack {
                Button {
                    print("button Tapped. State is: \(uiVM.showingBackcountrySearchSheet.description.capitalized)")
                    uiVM.showingBackcountrySearchSheet.toggle()
                   
                } label: {
                    Text("Close")
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("Location Search")
                    .font(.title2.weight(.bold))
                    .frame(maxWidth: .infinity, alignment: .center)
                
                
            }
            .padding([.horizontal, .vertical], 20)
            
                
            TextField("search...", text: .constant(""))
                .foregroundColor(.primary)
                .padding(.horizontal, 5)
                .padding(.bottom, 10)
                .textFieldStyle(TrekMateTextFieldStyle())
    
            
            
            ScrollView {
                VStack (spacing: 0){
                    VStack (alignment: .leading) {
                        Text("Honor, MI")
                            .font(.headline)
                        Text("United States")
                            .font(.subheadline.weight(.light))
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

                    
                    
                    VStack (alignment: .leading) {
                        Text("Honoraville, AL")
                            .font(.headline)
                        Text("United States")
                            .font(.subheadline.weight(.light))
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
                .background(Color(UIColor.systemGray5))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                
            }
            
            
        }
        .padding(.horizontal, 10)
        .background(Color(UIColor.systemGray3))

    }
}


#Preview {
    @Previewable @StateObject var uiVM: UIModel = UIModel()
    @Previewable @StateObject var tripVM: TripViewModel = TripViewModel()
    
    AddTrip(tripVM: tripVM ,uiVM: uiVM)
}
#Preview {
    @Previewable @StateObject var uiVM: UIModel = UIModel()
    BackcountrySearchSheet(uiVM: uiVM)
}

#Preview {
    @Previewable @StateObject var uiVM: UIModel = UIModel()
    CampgroundSearchSheet(uiVM: uiVM)
}

