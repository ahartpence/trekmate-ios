//
//  String.swift
//  TrekMate
//
//  Created by Andrew Hartpence on 10/30/24.
//

extension String {
    var stripHTML: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression)
    }
}
