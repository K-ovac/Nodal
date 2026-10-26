//
//  Colors.swift
//  C-Tab
//
//  Created by Максим Лозебной on 21.04.2026.
//

import SwiftUI
import UIKit

extension Color {
    
    // MARK: - Color Properties
    
    static var background = color(dark: "08070B", light: "F5F4F8")
    static var card = color(dark: "13111C", opDark: 0.9, light: "FFFFFF", opLight: 0.85)
    static var navigation = color(dark: "14111F", opDark: 0.65, light: "FFFFFF", opLight: 0.75)
    
    static var solarGold = Color(hex: "FFD700")
    static var orangeNeon = Color(hex: "FF4500")
    static var deepBurgundy = Color(hex: "800020")
    static var enclaveSafe = Color(hex: "10B981")
    static var cautionPermit = Color(hex: "F59E0B")
    static var drainerAlert = Color(hex: "EF4444")
    
    // MARK: - Hex Init
    
    init(hex: String) {
            let scanner = Scanner(
                string: hex.trimmingCharacters(
                    in: CharacterSet.alphanumerics.inverted
                ))
            var hexNumber: UInt64 = 0
            scanner.scanHexInt64(&hexNumber)
            
            let r = Double((hexNumber & 0xff0000) >> 16) / 255
            let g = Double((hexNumber & 0x00ff00) >> 8) / 255
            let b = Double(hexNumber & 0x0000ff) / 255
            
            self.init(red: r, green: g, blue: b)
        }
    
    // MARK: - Private func Color Scheme
    
    private static func color(
        dark: String, opDark: Double = 1,
        light: String, opLight: Double = 1
    ) -> Color {
        Color(uiColor: UIColor { traits in
            traits.userInterfaceStyle == .dark
            ? UIColor(Color(hex: dark)).withAlphaComponent(CGFloat(opDark))
            : UIColor(Color(hex: light)).withAlphaComponent(CGFloat(opLight))
        })
    }
}
