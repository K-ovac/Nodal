//
//  WatchlistView.swift
//  Nodal
//
//  Created by Максим Лозебной on 28.10.2026.
//

import SwiftUI

// MARK: - WatchlistView

struct WatchlistView: View {
    
    @State private var isPresented: Bool = false
    
    // MARK: - Body
    
    var body: some View {
        NavigationStack {
            List {
                indexCard
                    .listRowPreset()
                coinCard
                    .listRowPreset()
            }
            .listStyle(.plain)
            .background(Color.background)
            
            .toolbar {
                leadingToolbar
                trailingToolbar
            }
            
            .navigationDestination(isPresented: $isPresented) {
                SearchView(selectedList: .top)
            }
        }
    }
}

// MARK: - Extension WatchlistView

extension WatchlistView {
    
    // MARK: - Toolbar Items
    private var leadingToolbar: some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            HStack {
                Image(systemName: "star.fill")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 20, height: 20)
                    .foregroundStyle(Color.solarGold)
                Text("watchlist.title")
                    .fixedSize()
                    .font(Font.header20)
            }
            .padding(.horizontal, 8)
        }
    }
    
    private var trailingToolbar: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Button {
                isPresented = true
            } label: {
                Text("watchlist.addCoinButton.title")
                    .foregroundStyle(Color.primary)
                    .font(Font.body13.bold())
            }
        }
    }
    
    // MARK: - Index Card
    
    private var indexCard: some View {
//        WatchlistIndexRow(index: <#WatchlistModel#>)
//            .clipShape(
//                RoundedRectangle(cornerRadius: 16)
//            )
        EmptyView()
    }
    
    // MARK: - Coins Section
    
    private var coinCard: some View {
//        WatchlistCoinRow(
//            coin: <#TokenList#>,
//            currency: <#String#>,
//            removeAction: <#() -> Void#>
//        )
        EmptyView()
    }
}
