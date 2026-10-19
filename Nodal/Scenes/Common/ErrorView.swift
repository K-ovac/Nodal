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
            
            //Retry Button
            Button {
                Task {
                    await onRetry()
                }
            } label: {
                Text("error.button.retry.title")
                    .font(.body)
                    .foregroundStyle(.primary)
            }
            .padding(.horizontal)
            .padding(.vertical, 8)
            .foregroundStyle(.primary)
            .background(.gray.opacity(0.4))
            .clipShape(.buttonBorder)
        }
    }
}
