//
//  WatchlistView.swift
//  Nodal
//
//  Created by Максим Лозебной on 28.10.2026.
//

import SwiftUI

// MARK: - WatchlistView

struct WatchlistView: View {
    
    // MARK: - Body
    
    var body: some View {
        NavigationStack {
            List {
                indexCard
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
                coinCard
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
            }
            .listStyle(.plain)
            .background(Color.background)
            
            .toolbar {
                leadingToolbar
                trailingToolbar
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
                    .frame(width: 18, height: 18)
                    .foregroundStyle(Color.solarGold)
                Text("Favorive Coins(4)")
                    .fixedSize()
                    .font(Font.header20)
            }
            .padding(.horizontal, 8)
        }
    }
    
    private var trailingToolbar: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Button {
                print("add tapped")
            } label: {
                Text("+Add")
                    .foregroundStyle(Color.primary)
                    .font(Font.header15)
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
