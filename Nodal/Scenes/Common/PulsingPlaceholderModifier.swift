//
//  PuslingPlaceholderModifier.swift
//  Nodal
//
//  Created by Максим Лозебной on 16.11.2026.
//

import SwiftUI

struct PulsingPlaceholderModifier: ViewModifier {
    @State private var isPulsing: Bool = false
    
    func body(content: Content) -> some View {
        content
            .redacted(reason: .placeholder)
            .opacity(
                isPulsing
                ? 0.35
                : 0.8)
            .animation(
                .easeInOut(duration: 0.85)
                .repeatForever(autoreverses: true),
                value: isPulsing)
            .onAppear {
                isPulsing = true
            }
    }
}
