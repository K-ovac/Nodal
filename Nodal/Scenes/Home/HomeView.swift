//
//  ContentView.swift
//  C-Tab
//
//  Created by Максим Лозебной on 21.04.2026.
//

import SwiftUI

// MARK: - HomeView

struct HomeView: View {
    
    // MARK: - Properties
    
    @StateObject private var viewModel = HomeViewModel(
        homeService: HomeService(
            networkClient: NetworkClient()
        )
    )
    @State private var selectedCoinId: String?
    
    // MARK: - Body
    
    var body: some View {
        NavigationStack {
            List {
                
                // MARK: - Global Metrics
                
                globalMetricsSection
                    .listRowPreset()
                
                // MARK: - Trending Coins
                
                trandingCoinsSection
                    .listRowPreset()
                
                // MARK: - Top list
                
                topListSection
                    .listRowPreset()
            }
            .listStyle(.plain)
            .background(Color.background)
            
            // MARK: - ToolBar
            
            .toolbar {
                leadingToolbar
                trailingToolbar
            }
            
            // MARK: - NavigationDestination
            
            .navigationDestination(item: $selectedCoinId) { coinId in
                CoinDetailsView(
                    coinId: coinId
                )
            }
            .navigationDestination(item: $viewModel.selectedList) { list in
                
                SearchView(selectedList: list)
            }
            
            // MARK: - FetchData
            
            .task {
                await viewModel.fetchData()
            }
            .refreshable() {
                await viewModel.fetchData()
            }
        }
    }
}

// MARK: - Extension Home View

extension HomeView {
    
    // MARK: - Toolbar
    
    private var leadingToolbar: some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            HStack {
                Image("nodalIcon")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 24, height: 24)
                Text("markets.title")
                    .foregroundStyle(Color.primary)
                    .font(Font.header20)
                    .fixedSize(horizontal: true, vertical: false)
            }
            .padding(.horizontal, 8)
        }
    }
    
//    @ViewBuilder
    private var trailingToolbar: some ToolbarContent {
        
        ToolbarItem(placement: .topBarTrailing) {
            HStack(spacing: 16) {
                Button {
                    viewModel.selectedList = .top
                } label: {
                    Image(systemName: "magnifyingglass")
                }
                
                
                
                Button {
                    // TODO
                } label: {
                    Text(viewModel.selectedCurrency)
                        .font(Font.hashes16.bold())
                }
                .background(Color.orangeNeon.opacity(0.1))
                .clipShape(.capsule)
            }
        }
    }
    
    // MARK: - Global Metrics Section
    
    private var globalMetricsSection: some View {
        Section {
            StateView(
                content: globalMetricsContent,
                state: viewModel.globalMetricsState,
                retryAction: viewModel.fetchGlobalMetrics
            )
        }
    }
    
    // MARK: - Global Metrics Content
    
    @ViewBuilder
    private var globalMetricsContent: some View {
        if let metrics = viewModel.globalMetrics {
            GlobalMetricsView(
                globalMetrics: metrics
            )
        }
    }
    
    // MARK: - Trending Coins Section
    
    private var trandingCoinsSection: some View {
        Section(
            header: TrendingCoinsHeader {
                viewModel.selectedList = .trending
            }
        ) {
            StateView(
                content: trendingCoinsContent,
                state: viewModel.trendingCoinsState,
                retryAction: viewModel.fetchTrendingCoins
            )
        }
    }
    
    // MARK: - Trending Coins Content
    
    private var trendingCoinsContent: some View {
        LazyVGrid(columns: viewModel.trendingCoinsColumns()) {
            ForEach(
                viewModel.trendingCoins
                    .prefix(viewModel.trendingCoinsRows()),
                id: \.item
            ) { coin in
                TrendingCoinsRow(
                    coin: coin.item,
                    currency: viewModel.selectedCurrency
                )
                    .contentShape(Rectangle())
                    .onTapGesture {
                        selectedCoinId = coin.item.id
                    }
            }
        }
    }
    
    // MARK: - TopList Section
    
    private var topListSection: some View {
        Section(
            header: TopCoinsHeader()
        ) {
            StateView(
                content: topListContent,
                state: viewModel.topListState,
                retryAction: viewModel.fetchTopList
            )
            
            if viewModel.topListState.isLoaded {
                Button {
                    viewModel.selectedList = .top
                } label: {
                    Text("markets.topCoins.showMoreButton.title")
                        .foregroundStyle(Color.white.opacity(0.85))
                        .font(.body18.bold())
                    
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .contentShape(Rectangle())
                .padding(.vertical, 8)
                .background(Color.linearGradient)
                .clipShape(.capsule)
            }
        }
    }
    
    // MARK: - TopList Content
    
    private var topListContent: some View {
        ForEach(
            viewModel.topList
                .prefix(viewModel.topCoinsRows())
        ) { item in
            TopCoinsRow(
                token: item,
                currency: viewModel.selectedCurrency
            )
                .contentShape(Rectangle())
                .onTapGesture {
                    selectedCoinId = item.id
                }
                .cellStyle(
                    for: item,
                    in: viewModel.topList
                )
        }
    }
}

#Preview {
    TabListView()
}
