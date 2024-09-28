//
//  Date.swift
//  TrekMate
//
//  Created by Andrew Hartpence on 10/14/24.
//
import Foundation


extension Date {
    func trekmateFormatted() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: self)
    }
}
