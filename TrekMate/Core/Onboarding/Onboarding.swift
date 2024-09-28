//
//  Onboarding.swift
//  TrekMate
//
//  Created by Andrew Hartpence on 10/27/24.
//
import SwiftUI

struct OnboardingWelcomeScreen: View {
    var body: some View {
        VStack {
            
        }
    }
    
    func getWelcomePages() -> [WelcomeSheetPage] {
        return [WelcomeSheetPage(title: "Welcome to TrekMate", rows: [
            WelcomeSheetPageRow(imageSystemName: "rectangle.stack.fill.badge.plus",
                                title: "Log and Plan Camping trips",
                                content: "")
        ])]
    }
}
