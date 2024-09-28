//
//  TransparentNavigationBarModifier.swift
//  TrekMate
//
//  Created by Andrew Hartpence on 10/26/24.
//
import SwiftUI


struct TransparentNavigationBarModifier: ViewModifier {
    init() {
        // Create a new appearance instance
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .clear // Make background clear
        appearance.shadowColor = .clear // Remove shadow

        // Apply the appearance to all navigation bars
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }

    func body(content: Content) -> some View {
        content
    }
}

extension View {
    /// Applies a transparent navigation bar to the view
    func transparentNavigationBar() -> some View {
        self.modifier(TransparentNavigationBarModifier())
    }
}
