//
//  View+Extensions.swift
//  Nodal
//
//  Created by Максим Лозебной on 28.10.2026.
//

import SwiftUI

extension View {
    func stylePreset(isSelected: Bool = false) -> some View {
        let shape = RoundedRectangle(cornerRadius: 16, style: .continuous)
        
        return self
            .foregroundStyle(.primary)
            .padding(8)
            .background(Color.navigation)
            .clipShape(shape)
            .overlay(
                shape
                    .strokeBorder(
                        isSelected
                        ? Color.orangeNeon.opacity(0.6)
                        : Color.gray.opacity(0.25),
                        lineWidth: 1
                    )
            )
    }
}
