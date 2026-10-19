//
//  UserDefaultsService.swift
//  C-Tab
//
//  Created by Максим Лозебной on 21.04.2026.
//

import Foundation

// MARK: - Keys

enum Keys: String {
    case currency
    case appTheme
    case language
    
    var value: String { self.rawValue }
}

// MARK: - UserDefaultsService

struct UserDefaultsService {
    
    // MARK: - Properties
    
    static let shared = UserDefaultsService()
    private let storage: UserDefaults = .standard
    
    // MARK: - Private Init
    
    private init() {}
    
    // MARK: - Currency
    
    var currentCurrency: String {
        get { storage.string(
            forKey: Keys.currency.value)
            ?? CurrencyPrice.usd.id
        }
        set { storage.set(
            newValue,
            forKey: Keys.currency.value
        ) }
    }
    
    // MARK: - App Theme
    
    var currentTheme: String {
        get { storage.string(
            forKey: Keys.appTheme.value)
            ?? AppTheme.dark.id
        }
        set { storage.set(
            newValue,
            forKey: Keys.appTheme.value
        ) }
    }
    
    // MARK: - App Language
    
    var currentLanguage: String {
        get { storage.string(
            forKey: Keys.language.value)
            ?? Language.en.id
        }
        set { storage.set(
            newValue,
            forKey: Keys.language.value
        ) }
    }
}
