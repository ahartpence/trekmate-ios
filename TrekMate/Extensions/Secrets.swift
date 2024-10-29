//
//  Secrets.swift
//  TrekMate
//
//  Created by Andrew Hartpence on 10/29/24.
//
import Foundation

struct Secrets {
    private static func secrets() -> [String: Any] {
        let fileName = "secrets"
        let path = Bundle.main.path(forResource: fileName, ofType: "json")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
        print("Finished loading secrets")
        return try! JSONSerialization.jsonObject(with: data) as! [String: Any]
 }

    static var apiKey: String {
        return secrets()["API_KEY"] as! String
    }
}
