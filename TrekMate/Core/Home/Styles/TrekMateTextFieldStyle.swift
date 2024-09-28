//
//  TrekMateTextFieldStyle.swift
//  TrekMate
//
//  Created by Andrew Hartpence on 10/19/24.
//
import SwiftUI

struct TrekMateTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(Color(UIColor.tertiaryLabel))
            configuration
                .shadow(color: .gray, radius: 10)
                .foregroundColor(.primary)
        }
        .padding(10)
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(8)
    }
}
