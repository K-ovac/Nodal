//
//  Fonts.swift
//  C-Tab
//
//  Created by Максим Лозебной on 21.04.2026.
//

import SwiftUI

extension Font {
    
    // MARK: - UI BODY / NAVIGATION / DESCRIPTIONS
    
    static var body13 = Font.custom("PlusJakartaSans-Regular", size: 13)
    static var body18 = Font.custom("PlusJakartaSans-Regular", size: 18)
    
    static var secondary11 = Font.custom("PlusJakartaSans-Regular", size: 11)
    static var secondary14 = Font.custom("PlusJakartaSans-Regular", size: 14)
    
    static var tabCapsule = Font.custom("PlusJakartaSans-Regular", size: 9.5)
    
    // MARK: - DISPLAY / HEADERS / TICKERS
    
    static var price28 = Font.custom("SpaceGrotesk-Light_Bold", size: 28)
    static var price32 = Font.custom("SpaceGrotesk-Light_Bold", size: 32)
    
    static var header15 = Font.custom("SpaceGrotesk-Light_Bold", size: 15)
    static var header20 = Font.custom("SpaceGrotesk-Light_Bold", size: 20)
    
    static var ticker13 = Font.custom("SpaceGrotesk-Light_Bold", size: 13)
    static var ticker16 = Font.custom("SpaceGrotesk-Light_Bold", size: 16)
    
    // MARK: - QUOTES / HASHES / RPC TELEMETRY
    
    static var hashes = Font.custom("JetBrainsMonoRoman-Medium", size: 16)
}
