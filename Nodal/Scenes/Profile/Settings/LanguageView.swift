//
//  LanguageView.swift
//  C-Tab
//
//  Created by Максим Лозебной on 15.09.2026.
//

import SwiftUI

//TODO: - переработать

struct LanguageView: View {
    @AppStorage(Keys.language.value)
    private var selectedLanguage: Language = .en
    
    let title: LocalizedStringKey
    
    var body: some View {
        List {
            ForEach(Language.allCases) { lang in
                HStack {
                    Image(lang.icon)
                        .resizable()
                        .frame(width: 25, height: 25)
                    Text(lang.title)
                        .foregroundStyle(.primary)
                        .font(.body)
                    
                    Spacer()
                    
                    if selectedLanguage == lang {
                        Image(systemName: "checkmark")
                            .foregroundStyle(.blue)
                    }
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    selectedLanguage = lang
                    
                    print("LANG:", selectedLanguage)

                    print("DEFAULTS:", UserDefaults.standard.string(forKey: Keys.language.value) as Any)
                }
            }
        }
        .navigationTitle(title)
        .scrollDisabled(true)
    }
}
