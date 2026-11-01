//
//  AppTheme.swift
//  C-Tab
//
//  Created by Максим Лозебной on 06.06.2026.
//

import SwiftUI

// MARK: - App Theme

enum AppTheme: String, CaseIterable, Identifiable {
    case light = "Light Pearl"
    case dark = "Obsidian"
    
}

// MARK: - Extension App Theme

extension AppTheme {
    var id: String { self.rawValue }
    
    // MARK: - ColorScheme
    
    var colorScheme: ColorScheme {
        switch self {
        case .light: return .light
        case .dark: return .dark
        }
    }
    
    var icon: String {
        switch self {
        case .light: return "sun.max"
        case .dark: return "moon"
        }
    }
}
