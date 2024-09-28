//
//  UIModel.swift
//  TrekMate
//
//  Created by Andrew Hartpence on 10/2/24.
//
import SwiftUI

class UIModel: ObservableObject {
    @Published var selectedDetent: PresentationDetent = .medium
    @Published var showingCampgroundSearchSheet: Bool = false
    @Published var showingBackcountrySearchSheet: Bool = false
    @Published var showingAddTripSheet: Bool = false
}
