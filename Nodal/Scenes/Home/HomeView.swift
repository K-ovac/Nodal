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
                    .listRowInsets(
                        EdgeInsets(
                            top: 0, leading: 16, bottom: 0, trailing: 16
                        )
                    )
                
                // MARK: - Trending Coins
                
                trandingCoinsSection
                    .listRowSeparator(.hidden)
                    .listRowInsets(
                        EdgeInsets(
                            top: 16, leading: 16, bottom: 0, trailing: 16
                        )
                    )
                
                // MARK: - Top list
                
                topListSection
                    .listRowSeparator(.hidden)
                    .listRowInsets(
                        EdgeInsets(
                            top: 0, leading: 16, bottom: 0, trailing: 16
                        )
                    )
            }
            .listStyle(.inset)
            
            .navigationTitle("markets.title")
            .navigationBarTitleDisplayMode(.large)
            
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
            Button {
                viewModel.profilePresented.toggle()
            } label: {
                Image(systemName: "person.fill")
            } .sheet(isPresented: $viewModel.profilePresented) {
                ProfileView()
                    .presentationDetents([.large])
            }
        }
    }
    
    private var trailingToolbar: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Button {
                viewModel.topListPresented.toggle()
            } label: {
                Image(systemName: "magnifyingglass")
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
                        .foregroundStyle(.primary)
                        .font(.body.bold())
                    
                }
                .contentShape(Rectangle())
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(.gray.opacity(0.3))
                .clipShape(.capsule)
                .frame(maxWidth: .infinity, alignment: .center)
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
        }
    }
}

#Preview {
        TabListView()
}

