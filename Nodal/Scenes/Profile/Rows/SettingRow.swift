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
    private let color: Color
    
    // MARK: - Init
    
    init(
        iconName: String,
        title: LocalizedStringKey,
        value: String?,
        color: Color
    ) {
        self.iconName = iconName
        self.title = title
        self.value = value
        self.color = color
    }
    
    // MARK: - Body
    
    var body: some View {
        HStack {
            //icon
            Image(iconName)
                .renderingMode(.template)
                .resizable()
                .scaledToFill()
                .frame(width: 20, height: 20, alignment: .center)
                .foregroundStyle(color)
                .padding(4)
                .background(color.opacity(0.1))
                .clipShape(.circle)
            //title
            Text(title)
                .font(Font.body15)
                .foregroundStyle(Color.primary)
            
            Spacer()
            
            //show value
            
            if let value {
                HStack {
                    Text(value)
                        .font(Font.hashes12.bold())
                        .foregroundStyle(color)
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
