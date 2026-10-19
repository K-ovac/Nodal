//
//  TopCoinsListView.swift
//  C-Tab
//
//  Created by Максим Лозебной on 17.09.2026.
//

import SwiftUI

// MARK: - TopCoinsListView

struct TopCoinsListView: View {
    
    // MARK: - Properties
    
    @StateObject private var viewModel = HomeViewModel(
        homeService: HomeService(
            networkClient: NetworkClient()
        ))
    @State private var searchText: String = ""
        
    // MARK: - Body
    
    var body: some View {
        List {
            topListSection
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
                .listRowInsets(
                    EdgeInsets(
                        top: 0,
                        leading: 16,
                        bottom: 0,
                        trailing: 16
                    )
                )
        }
        .listStyle(.grouped)
        .scrollContentBackground(.hidden)
        
        .navigationDestination(item: $viewModel.selectedCoinId) { coinId in
            CoinDetailsView(coinId: coinId)
        }
        
        .toolbar(.hidden, for: .tabBar)
        .searchable(
            text: $searchText,
            placement: .navigationBarDrawer(displayMode: .always),
            prompt: "Solana, SOL"
        )
        
        // MARK: - task fetchTopList
        
        .task {
            await viewModel.fetchTopList()
        }
        .refreshable {
            await viewModel.fetchTopList()
        }
    }
}

// MARK: - Extension TopCoinsListView

extension TopCoinsListView {
    
    // MARK: - Search Promt
    
    private var filteredCoins: [TokenList] {
        if !searchText.isEmpty {
            return viewModel.topList.filter {
                $0.symbol.localizedCaseInsensitiveContains(searchText) ||
                $0.name.localizedCaseInsensitiveContains(searchText)
            }
        } else {
            return viewModel.topList
        }
    }
    
    // MARK: - Top List Section
    
    private var topListSection: some View {
        Section(
            header: TopListHeader(
                rankCtrypto: $viewModel.rankCrypto,
                priceChange: $viewModel.priceChange,
                actionSort: viewModel.toggleSort(by:),
                currentSort: viewModel.currentSortType,
                sortDirection: viewModel.sortDirection
            )
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
        ForEach(
            filteredCoins
                .prefix(
                    viewModel.topListRows()
                )
        ) { coin in
            HStack {
                Text(String(coin.marketCapRank))
                    .font(.body)
                    .foregroundColor(.secondary)
                    .frame(minWidth: 20, alignment: .center)
                
                TopListRow(token: coin, currency: viewModel.selectedCurrency)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        viewModel.selectedCoinId = coin.id
                    }
            }
            
        }
    }
}
