//
//  Colors.swift
//  TrekMate
//
//  Created by Andrew Hartpence on 9/30/24.
//
import SwiftUI



extension Color {
    init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, opacity: 1)
   }

    init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
}

extension Color {
    static let darkForestGreen = Color(rgb: 0x002D04)
    static let darkRed = Color(rgb: 0x580000)
    static let forestGreen = Color(rgb: 0x228B22)
    static let offBlack = Color(rgb: 0x30363a)
    static let offWhite = Color(rgb: 0xfa)
}



