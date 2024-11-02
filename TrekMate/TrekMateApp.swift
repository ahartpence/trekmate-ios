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
    @StateObject var profileVM: ProfileViewModel = ProfileViewModel()
    
   
    
    
    var body: some Scene {
        WindowGroup {
            //TripDetailView()
            //HomeSheetView(uiVM: uiVM, tripVM: tripVM)
            //ProfileView()
            HomeView()
            
            
        }
        .environmentObject(tripVM)
        .environmentObject(profileVM)
        .environmentObject(uiVM)
    }
}
