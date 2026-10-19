//
//  C_TabApp.swift
//  C-Tab
//
//  Created by Максим Лозебной on 21.04.2026.
//

import SwiftUI

// MARK: - C_TabApp

@main
struct C_TabApp: App {
    
    //MARK: - Storage Properties
    
    @AppStorage(Keys.appTheme.value)
    private var selectedTheme: AppTheme = .dark
    @AppStorage(Keys.language.value)
    private var selectedLanguage: Language = .en
    
    // MARK: - Body
    
    var body: some Scene {
        WindowGroup {
            TabListView()
                .preferredColorScheme(selectedTheme.colorScheme)
                .environment(\.locale, Locale(identifier: selectedLanguage.id))
                .id(selectedLanguage)
        }
    }
}
