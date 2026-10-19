//
//  StateView.swift
//  C-Tab
//
//  Created by Максим Лозебной on 21.09.2026.
//

import SwiftUI

// MARK: - ViewState
enum ViewState {
    case initial
    case loading
    case loaded
    case failure(Error)
    
    var isLoaded: Bool {
        switch self {
        case .loaded: return true
        default: return false
        }
    }
}

// MARK: - Generic StateView

struct StateView<Content: View>: View {
    
    // MARK: - Properties
    
    private let content: Content
    private let state: ViewState
    private let retryAction: () async -> Void
    
    // MARK: - Init
    
    init(
        content: Content,
        state: ViewState,
        retryAction: @escaping () async -> Void
    ) {
        self.content = content
        self.state = state
        self.retryAction = retryAction
    }
    
    // MARK: - Body
    
    var body: some View {
        switch state {
        case .initial, .loading:
            ProgressView()
                .frame(maxWidth: .infinity, alignment: .center)
        case .loaded:
            content
        case .failure:
            ErrorView(onRetry: retryAction)
                .frame(maxWidth: .infinity, alignment: .center)
        }
    }
}
