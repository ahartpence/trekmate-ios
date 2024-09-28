import Foundation
import CloudKit
import SwiftUI

final class CloudKitManager {
    static let shared = CloudKitManager()
    private let container = CKContainer.default()
    
    private init() {}
    
    

    // Fetch user's first and last name using CKShare.Participant for iOS 17+
    func fetchUserName(completion: @escaping (String?, String?) -> Void) {
        // Fetch the user record ID
        container.fetchUserRecordID { [weak self] recordID, error in
            guard let recordID = recordID, error == nil else {
                completion(nil, nil)
                print("Failed to fetch user record ID: \(String(describing: error?.localizedDescription))")
                return
            }
            
            // Fetch the share participant using the user record ID
            self?.container.fetchShareParticipant(withUserRecordID: recordID) { participant, error in
                guard let participant = participant, error == nil else {
                    completion(nil, nil)
                    print("Failed to fetch share participant: \(String(describing: error?.localizedDescription))")
                    return
                }
                
                // Extract the user's first and last name from the participant's userIdentity
                let firstName = participant.userIdentity.nameComponents?.givenName
                let lastName = participant.userIdentity.nameComponents?.familyName
                
                DispatchQueue.main.async {
                    completion(firstName, lastName)
                }
            }
        }
    }

    
    // Other methods for iCloud status and permissions
    func getiCloudStatus(completion: @escaping (CKAccountStatus, String?) -> Void) {
        container.accountStatus { status, error in
            DispatchQueue.main.async {
                var errorString: String? = nil
                switch status {
                case .available:
                    break
                case .noAccount:
                    errorString = CloudKitError.iCloudAccountNotFound.rawValue
                case .couldNotDetermine:
                    errorString = CloudKitError.iCloudAccountNotDetermined.rawValue
                case .restricted:
                    errorString = CloudKitError.iCloudAccountRestricted.rawValue
                case .temporarilyUnavailable:
                    errorString = CloudKitError.iCloudAccountTempUnavailable.rawValue
                @unknown default:
                    break
                }
                completion(status, errorString)
            }
        }
    }
    
    func fetchiCloudUserRecordID(completion: @escaping (CKRecord.ID?) -> Void) {
        container.fetchUserRecordID { returnedID, error in
            DispatchQueue.main.async {
                completion(returnedID)
            }
        }
    }
}
