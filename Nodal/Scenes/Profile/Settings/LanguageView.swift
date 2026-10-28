//
//  LanguageView.swift
//  C-Tab
//
//  Created by Максим Лозебной on 15.09.2026.
//

import SwiftUI

//TODO: - переработать

struct LanguageView: View {
    @Environment(\.dismiss) var dismiss
    @AppStorage(Keys.language.value)
    private var selectedLanguage: Language = .en
    
    let title: LocalizedStringKey
    
    var body: some View {
        List {
            languageSection
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
        .toolbar {
            leadingToolBar
            trailingToolBar
        }
    }
}

extension LanguageView {
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
    
    private var languageSection: some View {
        LazyVStack(spacing: 4) {
            ForEach(Language.allCases) { lang in
                HStack {
                    Image(lang.icon)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 20, height: 20)
                        
                    Text(lang.title)
                        .foregroundStyle(Color.primary)
                        .font(Font.body18)
                    
                    Spacer()
                    
                    if selectedLanguage == lang {
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
                .stylePreset()
                .onTapGesture {
                    withAnimation {
                        selectedLanguage = lang
                    }
                }
            }
        }
    }
}
