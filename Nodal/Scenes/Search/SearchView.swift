//
//  TopCoinsListView.swift
//  C-Tab
//
//  Created by Максим Лозебной on 17.09.2026.
//

import SwiftUI

// MARK: - TopCoinsListView

struct SearchView: View {
    
    // MARK: - Properties
    
    @StateObject private var viewModel: SearchViewModel
    
    init(selectedList: TokenLists = .top) {
        _viewModel = StateObject(
            wrappedValue: SearchViewModel(
                homeService: HomeService(
                    networkClient: NetworkClient()),
                list: selectedList))
    }
        
    // MARK: - Body
    
    var body: some View {
        List {
            topListSection
                .listRowPreset()
        }
        .listStyle(.plain)
        .background(Color.background)
        .navigationBarBackButtonHidden()
        
        .navigationDestination(item: $viewModel.selectedCoinId) { coinId in
            CoinDetailsView(coinId: coinId)
        }
        
        .toolbar(.hidden, for: .tabBar)
        .toolbar {
            leadingToolbar
            principalToolBar
        }
        .searchable(
            text: $viewModel.searchText,
            placement: .navigationBarDrawer(displayMode: .automatic),
            prompt: "Solana, SOL"
        )
        
        // MARK: - task fetchTopList
        
        .task {
            await viewModel.fetchData()
        }
        .refreshable {
            await viewModel.fetchData()
        }
    }
}

// MARK: - Extension TopCoinsListView

extension SearchView {
    
    private var leadingToolbar: some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            BackButtonView()
        }
    }
    
    private var principalToolBar: some ToolbarContent {
        ToolbarItem(placement: .principal) {
            Text("topListCoins.title")
                .foregroundStyle(Color.primary)
                .font(Font.header15.bold())
        }
    }
    
    // MARK: - Top List Section
    
    private var topListSection: some View {
        Section(
            header: TopListHeader(selectedList: $viewModel.selectedList)
        ) {
            StateView(
                content: topListContent,
                state: viewModel.topListState,
                retryAction: viewModel.fetchTopList
            )
        }
    }
    
    // MARK: - Top List Content
        
    private var topListContent: some View {
        ForEach(viewModel.filteredCoins) { coin in
            TopCoinsRow(
                token: coin,
                currency: viewModel.selectedCurrency
            )
                .contentShape(Rectangle())
                .onTapGesture {
                    viewModel.selectedCoinId = coin.id
                }
                .cellStyle(
                    for: coin,
                    in: viewModel.filteredCoins
                )
        }
    }
}
