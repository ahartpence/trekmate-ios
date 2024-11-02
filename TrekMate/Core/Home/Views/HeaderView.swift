//
//  HeaderView.swift
//  TrekMate
//
//  Created by Andrew Hartpence on 10/19/24.
//
import SwiftUI

struct HeaderView: View {
    
    @State var isShowingAddTripSheet: Bool = false
    @ObservedObject var uiVM: UIModel
    @ObservedObject var tripVM: TripViewModel
  
    
    @Binding var trips: [Trip]
    
    var body: some View {
        VStack {
            HStack {
                Text("My Trips")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
                Image(systemName: "chevron.down")
                    .foregroundColor(.secondary)
                Spacer()
                HStack (spacing: 16) {
                    Image(systemName: "plus")
                        .onTapGesture {
                            uiVM.showingAddTripSheet.toggle()
                        }
                        .foregroundStyle(.primary)
                    Image(systemName: "square.and.arrow.up")
                        .foregroundStyle(.primary)
                    Button(action: {
                        print("Initials button tapped!")
                    }) {
                        ZStack {
                            Circle()
                                .fill(Color.blue)
                                .frame(width: 30, height: 30)
                            Text("AH")
                                .foregroundColor(.white)
                                .font(.subheadline)
                        }
                    }
                }
            }

            HStack {
                TextField("search...", text: .constant(""))
    
            }
            .foregroundColor(.primary)
            .padding(.horizontal, 5)
            .textFieldStyle(TrekMateTextFieldStyle())

        }
        .padding(4)
        .padding([.vertical, .horizontal], 10)
        .background(Color(UIColor.systemBackground))
        .sheet(isPresented: $uiVM.showingAddTripSheet) {
            AddTrip()
                .interactiveDismissDisabled()
        }
    }
}


#Preview {
    @Previewable @StateObject var uiVM: UIModel = UIModel()
    @Previewable @StateObject var tripVM: TripViewModel = TripViewModel()
    HeaderView( uiVM: uiVM, tripVM: tripVM, trips: .constant([]))
}
