//
//  SettingRow.swift
//  C-Tab
//
//  Created by Максим Лозебной on 08.06.2026.
//

import SwiftUI

// MARK: - SettingRow

struct SettingRow: View {
    
    // MARK: - Properties
    
    private let iconName: String
    private let title: LocalizedStringKey
    private let value: String?
    
    // MARK: - Init
    
    init(
        iconName: String,
        title: LocalizedStringKey,
        value: String?
    ) {
        self.iconName = iconName
        self.title = title
        self.value = value
    }
    
    // MARK: - Body
    
    var body: some View {
        HStack {
            //icon
            Image(systemName: iconName)
                .font(.title3)
                .frame(width: 28, alignment: .center)
            //title
            Text(title)
                .font(Font.body18)
                .foregroundStyle(Color.primary)
            
            Spacer()
            
            //show value
            
            if let value {
                HStack {
                    Text(value.uppercased())
                        .font(Font.secondary14)
                        .foregroundStyle(.secondary)
                    Image(systemName: "chevron.right")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 6, height: 6)
                        .foregroundStyle(Color.secondary)
                }
            } else {
                Image(systemName: "arrow.up.forward.app")
                    .foregroundStyle(Color.solarGold)
            }
        }
    }
}
