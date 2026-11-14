//
//  AuthState.swift
//  Nodal
//
//  Created by Максим Лозебной on 14.11.2026.
//

import SwiftUI

enum AuthState: String, CaseIterable, Identifiable {
    case signIn, createProfile
    
    var id: String { rawValue }
    
    var  signingTitle: LocalizedStringKey {
        switch self {
        case .signIn: return "auth.signInButton.title"
        case .createProfile: return "auth.createProfile.title"
        }
    }
    
    var signState: LocalizedStringKey {
        switch self {
        case .signIn: return "auth.createProfile.title"
        case .createProfile: return "auth.signInButton.title"
        }
    }
    
    var icon: String {
        switch self {
        case .signIn: return "key"
        case .createProfile: return "person.badge.plus"
        }
    }
}
