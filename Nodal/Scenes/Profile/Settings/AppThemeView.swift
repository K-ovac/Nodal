//
//  AppThemeView.swift
//  C-Tab
//
//  Created by Максим Лозебной on 06.06.2026.
//

import SwiftUI

//TODO: - переработать

struct AppThemeView: View {
    @AppStorage(Keys.appTheme.value)
    private var selectedTheme: AppTheme = .dark
    
    let title: LocalizedStringKey
    
    var body: some View {
        VStack {
            List {
                ForEach(AppTheme.allCases) { theme in
                    Button(action: {
                        withAnimation {
                            selectedTheme = theme
                        }
                    }) {
                        HStack {
                            Image(systemName: theme.icon)
                                .font(.title3)
                            Text(theme.rawValue)
                                .font(.body)
                            
                            Spacer()
                            
                            if selectedTheme == theme {
                                Image(systemName: "checkmark")
                                    .foregroundStyle(.blue)
                            }
                        }
                    }
                    .foregroundStyle(.primary)
                }
            }
            .navigationTitle(title)
            .scrollDisabled(true)
        }
        .preferredColorScheme(selectedTheme.colorScheme)
    }
}
