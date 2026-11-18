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

struct StateView<Content: View, Placeholder: View>: View {
    
    // MARK: - Properties
    
    private let content: Content
    private let placeholder: Placeholder
    private let state: ViewState
    private let retryAction: () async -> Void
    
    // MARK: - Init with Placeholder
    
    init(
        content: Content,
        state: ViewState,
        retryAction: @escaping () async -> Void,
        @ViewBuilder placeholder: () -> Placeholder
    ) {
        self.content = content
        self.state = state
        self.retryAction = retryAction
        self.placeholder = placeholder()
    }
    
    // MARK: - Body
    
    var body: some View {
        switch state {
        case .initial, .loading:
            placeholder
        case .loaded:
            content
        case .failure:
            ErrorView(onRetry: retryAction)
                .frame(maxWidth: .infinity, alignment: .center)
        }
    }
}

extension StateView where Placeholder == AnyView {
    init(
        content: Content,
        state: ViewState,
        retryAction: @escaping () async -> Void
    ) {
        self.init(
            content: content,
            state: state,
            retryAction: retryAction,
            placeholder: {
                AnyView(
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                )
            }
        )
    }
}
