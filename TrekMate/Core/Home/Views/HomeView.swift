//
//  HomeView.swift
//  TrekMate
//
//  Created by Andrew Hartpence on 10/24/24.
//

import SwiftUI
import ScalingHeaderScrollView

struct HomeView: View {
    @StateObject var uiVM: UIModel = UIModel()
    @StateObject var tripVM: TripViewModel = TripViewModel()
    var body: some View {
        ZStack {
            ScalingHeaderScrollView {
                MapViewRepresentable()
                    .ignoresSafeArea(.all)
            } content: {
                HomeSheetView(uiVM: uiVM, tripVM: tripVM)
            }

        }
    }
}

#Preview {
    HomeView()
}
