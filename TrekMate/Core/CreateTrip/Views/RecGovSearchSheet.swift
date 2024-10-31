//
//  SearchSheet.swift
//  TrekMate
//
//  Created by Andrew Hartpence on 10/31/24.
//
import SwiftUI

struct RecGovSearchSheet: View {
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
//                        case .recArea(let recArea):
//                            RecAreaListItem(recArea: recArea)
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
