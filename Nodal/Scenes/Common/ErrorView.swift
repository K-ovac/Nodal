//
//  ErrorView.swift
//  C-Tab
//
//  Created by Максим Лозебной on 21.09.2026.
//

import SwiftUI

// MARK: - ErrorView

struct ErrorView: View {
    
    // MARK: - Properties
    
    private let onRetry: () async -> Void
    
    // MARK: - Init
    
    init(onRetry: @escaping () async -> Void) {
        self.onRetry = onRetry
    }
    
    // MARK: - Body
    
    var body: some View {
        LazyVStack {
            //Error title
            Text("error.load.title")
                .foregroundStyle(Color.primary)
                .font(Font.header20)
            
            //Retry Button
            Button {
                Task {
                    await onRetry()
                }
            } label: {
                Text("error.button.retry.title")
                    .foregroundStyle(Color.white)
                    .font(Font.header15)
            }
            .buttonStyle(.plain)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(Color.linearGradient)
            .clipShape(.capsule)
        }
    }
}
