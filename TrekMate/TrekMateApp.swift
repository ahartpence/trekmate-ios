//
//  TrekMateApp.swift
//  TrekMate
//
//  Created by Andrew Hartpence on 9/28/24.
//

import SwiftUI



@main
struct TrekMateApp: App {
    @StateObject var uiVM: UIModel = UIModel()
    @StateObject var tripVM: TripViewModel = TripViewModel()
    
   
    
    
    var body: some Scene {
        WindowGroup {
            //TripDetailView()
            HomeSheetView(uiVM: uiVM, tripVM: tripVM)
            //ProfileView()
            
            
        }
    }
}
