//
//  ProfileViewModel.swift
//  TrekMate
//
//  Created by Andrew Hartpence on 10/25/24.
//
import SwiftUI
import CloudKit

final class ProfileViewModel: ObservableObject {
    @Published var firstName = "John"
    @Published var lastName = "Appleseed"
    @Published var homeLocation = "Detroit, Mi"
    @Published var trips = []
    @Published var friends = []
    @Published var profileImage: Image?
    
    @Published var error: String?
    @Published var permissionStatus: Bool = false
    
    private let cloudKitManager = CloudKitManager.shared
    
    init() {
        getiCloudStatus()
        populateUserName()
    }

    // Get iCloud account status
    func getiCloudStatus() {
        cloudKitManager.getiCloudStatus { [weak self] status, errorString in
            self?.error = errorString
        }
    }

    // Fetch the user's first and last name using the CloudKitManager
    func populateUserName() {
        cloudKitManager.fetchUserName { [weak self] firstName, lastName in
            if let firstName = firstName {
                self?.firstName = firstName
            }
            if let lastName = lastName {
                self?.lastName = lastName
            }
        }
    }
}

enum CloudKitError: String, LocalizedError {
    case iCloudAccountNotFound
    case iCloudAccountNotDetermined
    case iCloudAccountRestricted
    case iCloudAccountTempUnavailable
}
