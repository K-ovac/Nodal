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
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
                    .listRowInsets(
                        EdgeInsets(
                            top: 0, leading: 16, bottom: 0, trailing: 16
                        )
                    )
                
                // MARK: - Trending Coins
                
                trandingCoinsSection
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
                    .listRowInsets(
                        EdgeInsets(
                            top: 0, leading: 16, bottom: 0, trailing: 16
                        )
                    )
                
                // MARK: - Top list
                
                topListSection
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
                    .listRowInsets(
                        EdgeInsets(
                            top: 0, leading: 16, bottom: 0, trailing: 16
                        )
                    )
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
            .navigationDestination(isPresented: $viewModel.topListPresented) {
                TopCoinsListView()
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
                Image("nodal")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                Text("NODAL")
                    .foregroundStyle(Color.primary)
                    .font(Font.header20)
                    .fixedSize(horizontal: true, vertical: false)
            }
            .padding(.horizontal, 8)
        }
    }
    
    @ViewBuilder
    private var trailingToolbar: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Button {
                viewModel.topListPresented.toggle()
            } label: {
                Image(systemName: "magnifyingglass")
            }
            
        }
        
        ToolbarItem(placement: .topBarTrailing) {
            Button {
                // TODO
            } label: {
                Text(viewModel.selectedCurrency)
                    .font(Font.hashes.bold())
                    .padding(.vertical, 8)
                    .padding(.horizontal, 16)
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
            header: Text("markets.trendingCoins.title")
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
            header: Text("markets.topCoins.title")
        ) {
            StateView(
                content: topListContent,
                state: viewModel.topListState,
                retryAction: viewModel.fetchTopList
            )
            
            if viewModel.topListState.isLoaded {
                Button {
                    viewModel.topListPresented.toggle()
                } label: {
                    Text("markets.topCoins.showMoreButton.title")
                        .foregroundStyle(Color.white)
                        .font(.body.bold())
                    
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .contentShape(Rectangle())
                .padding(.vertical, 8)
                .background(Color.gradient)
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
            TopListRow(
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

