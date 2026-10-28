//
//  Profile.swift
//  C-Tab
//
//  Created by Максим Лозебной on 04.06.2026.
//

import SwiftUI

// MARK: - Profile

struct Profile {
    let avatar: String
    let username: String
    let email: String
}

// MARK: - Profile Setting

struct ProfileSetting: Identifiable, Equatable {
    let id = UUID()
    let title: LocalizedStringKey
    let iconName: String
    let value: String?
    let destination: SettingsDestination
}

// MARK: - Setting Destination

enum SettingsDestination {
    case appTheme, currency, language
    
}

// MARK: - Profile Link

struct ProfileLink: Identifiable, Equatable {
    let id = UUID()
    let title: String
    let iconName: String
    let link: String
}
