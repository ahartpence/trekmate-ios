//
//  CKContainer.swift
//  TrekMate
//
//  Created by Andrew Hartpence on 10/27/24.
//

import UIKit
import CloudKit

// MARK: - Account checking
//
extension CKContainer {
    func checkAccountStatus(completionHandler: @escaping ((Bool, CKRecord.ID?, Error?) -> Void)) {
        accountStatus { (status, error) in
            guard handleCloudKitError(error, operation: .accountStatus, alert: true) == nil && status == .available else {
                DispatchQueue.main.async {
                    completionHandler(false, nil, nil)
                }
                return
            }
            
            self.fetchUserRecordID { (userRecordID, error) in
                _ = handleCloudKitError(error, operation: .fetchUserID, alert: false)
                DispatchQueue.main.async {
                    completionHandler(true, userRecordID, error)
                }
            }
        }
    }
}
