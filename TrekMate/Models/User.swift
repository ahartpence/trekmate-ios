//
//  User.swift
//  TrekMate
//
//  Created by Andrew Hartpence on 10/27/24.
//
import SwiftUI

struct User: Hashable, Identifiable {
    let id: UUID = UUID()
    let name: String
    let homeLocation: String?
    let trips: [Trip]?
    let friends: [User]?
    let profilePicture: Image?
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
