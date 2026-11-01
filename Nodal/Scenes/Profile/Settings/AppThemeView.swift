//
//  AppThemeView.swift
//  C-Tab
//
//  Created by Максим Лозебной on 06.06.2026.
//

import SwiftUI

//TODO: - переработать

struct AppThemeView: View {
    @Environment(\.dismiss) var dismiss
    @AppStorage(Keys.appTheme.value)
    private var selectedTheme: AppTheme = .dark
    private let title: LocalizedStringKey
    
    init(title: LocalizedStringKey) {
        self.title = title
    }
    
    var body: some View {
        List {
            theme
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
        .toolbar {
            leadingToolBar
            trailingToolBar
        }
        .preferredColorScheme(selectedTheme.colorScheme)
    }
}

extension AppThemeView {
    private var leadingToolBar: some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            Text(title)
                .padding(.horizontal, 8)
                .foregroundStyle(Color.primary)
                .font(Font.header20)
                .fixedSize(horizontal: true, vertical: false)
        }
    }
    
    private var trailingToolBar: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Button {
                dismiss()
            } label: {
                Image(systemName: "xmark")
            }
        }
    }
    
    private var theme: some View {
        LazyVStack(spacing: 4) {
            ForEach(AppTheme.allCases) { theme in
                HStack {
                    Image(systemName: theme.icon)
                        .font(.title3)
                    Text(theme.rawValue)
                        .foregroundStyle(Color.primary)
                        .font(Font.body18)
                    
                    Spacer()
                    
                    if selectedTheme == theme {
                        Image(systemName: "checkmark")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 10, height: 10)
                            .foregroundStyle(Color.black)
                        
                            .padding(8)
                            .background(Color.gradient)
                            .clipShape(.circle)
                    }
                }
                .cellStyle(for: theme, in: AppTheme.allCases)
                .onTapGesture {
                    withAnimation {
                        selectedTheme = theme
                    }
                }
            }
        }
    }
}
