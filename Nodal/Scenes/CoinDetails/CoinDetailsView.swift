//
//  TokenInfoView.swift
//  C-Tab
//
//  Created by Максим Лозебной on 09.09.2026.
//

import SwiftUI

// MARK: - CoinDetailsView

struct CoinDetailsView: View {
    
    // MARK: - Properties
        
    @State private var isExpanded: Bool = false
    @State private var isPresented: Bool = false
    @State private var showWebsite: Bool = false
    @State private var showBlockExplorer: Bool = false
    @StateObject private var viewModel: CoinDetailsViewModel
    
    private let coinId: String
    
    // MARK: - Init
    
    init(coinId: String) {
        self.coinId = coinId
        _viewModel = StateObject(
            wrappedValue: CoinDetailsViewModel(
                coinDetailsServise: CoinDetailsService(
                    networkClient: NetworkClient()
                ),
                coinId: coinId
            )
        )
    }
    
    // MARK: - Body
    
    var body: some View {
        
        // MARK: - Coin Details
        
        List {
            coinDetails
                .listRowSeparator(.hidden)
                .listRowBackground(Color.clear)
        }
        .listStyle(.plain)
        .background(Color.background)
        
        .navigationBarBackButtonHidden()
        
        .toolbar(.hidden, for: .tabBar)
        .toolbar {
            leadingToolBar
            principicalToolbar
            trailingToolbar
        }
        
        .navigationDestination(isPresented: $isPresented) {
            TopCoinsListView(selectedList: .trending)
        }
        
        // MARK: - Task fetchCoinDetails
        
        .task {
            await viewModel.fetchCoinDetails()
        }
        .refreshable {
            await viewModel.fetchCoinDetails()
        }
    }
}

// MARK: - Extension CoinDetailsView

extension CoinDetailsView {
    
    // MARK: - Leading ToolBar
    
    private var leadingToolBar: some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            BackButtonView()
        }
    }
    
    private var trailingToolbar: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Button {
                //
            } label: {
                Image(systemName: "star.fill")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 16, height: 16)
                    .foregroundStyle(Color.solarGold)
            }
        }
    }
    
    private var principicalToolbar: some ToolbarContent {
        ToolbarItem(placement: .principal) {
            Button {
                isPresented.toggle()
            } label: {
                LazyHStack {
                    Text(
                        (viewModel.coinDetails?.symbol ?? "coin")
                            .uppercased()
                    )
                        .foregroundStyle(Color.primary)
                        .font(Font.header15.bold())
                    Text(
                        "#" + String(viewModel.coinDetails?.marketData.marketCapRank ?? 0)
                    )
                    .foregroundStyle(Color.solarGold)
                    .font(Font.hashes12)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.solarGold.opacity(0.1))
                    .clipShape(.capsule)
                }
            }
            .applyLiquidGlassEffect()
        }
    }
    
    // MARK: - Coin Details
    
    private var coinDetails: some View {
        StateView(
            content: coinDetailsContent,
            state: viewModel.coinDetailsState,
            retryAction: viewModel.fetchCoinDetails
        )
    }
    
    // MARK: - CoinDetailsContent
    
    private var coinDetailsContent: some View {
        LazyVStack(alignment: .leading) {
            tokenMetricsView
            coinStatistics
            aboutToken
            warningTitle
        }
    }
    
    // MARK: - Warning Title
    
    private var warningTitle: some View {
        Text("coinDetails.warningTitle.title")
            .foregroundStyle(.secondary)
            .font(Font.secondary11)
            .padding(.top, 8)
    }
    
    // TODO: - !!!
    
    private var tokenMetricsView: some View {
        Section {
            if let metrics = viewModel.coinDetails {
                CoinMetricsView(
                    coinMetadata: metrics,
                    currency: viewModel.selectedCurrency
                )
            }
        }
    }
    
    // MARK: - Coin Description
    
    private var aboutToken: some View {
        Section {
            if let coinMetadata = viewModel.coinDetails {
                VStack(alignment: .leading) {
                    Text("coinDetails.description.title (\(coinMetadata.name))")
                        .foregroundStyle(Color.primary)
                        .font(Font.header15.bold())
                        .lineLimit(1)
                        .padding(.bottom, 4)
                    
                    if coinMetadata.description.en != "" {
                        Text(coinMetadata.description.en)
                            .foregroundStyle(Color.secondary)
                            .font(Font.body13)
                            .lineLimit(viewModel.descriptionLineLimit(isExpanded: isExpanded))
                    } else {
                        Text("coinDetails.abouToken.empty.title")
                            .foregroundStyle(Color.secondary)
                            .font(Font.body13)
                    }
                    
                    Button {
                        isExpanded.toggle()
                    } label: {
                        if coinMetadata.description.en != "" {
                            Text(
                                isExpanded ?
                                 "coinDetails.aboutToken.button.title.less"
                                 : "coinDetails.aboutToken.button.title.more"
                            )
                            .foregroundStyle(Color.secondary)
                            .font(Font.secondary11)
                        }
                    }
                    .clipShape(Rectangle())
                    .buttonStyle(.plain)
                    .foregroundStyle(.secondary)
                    .font(Font.secondary11)
                    .padding(.bottom, 4)
                    
                    coinLinks
                }
                .padding(8)
                .frame(maxWidth: .infinity, alignment: .leading)
                .cellStyle(position: .single)
                
                .sheet(isPresented: $showWebsite) {
                    if let url = URL(string: coinMetadata.links.homepage[0]) {
                        SafariView(url: url)
                    }
                }
                .sheet(isPresented: $showBlockExplorer) {
                    if let url = URL(string: coinMetadata.links.blockchainSite[0]) {
                        SafariView(url: url)
                    }
                }
            }
        }
        .padding(.top, 8)
    }
    
    // MARK: - Coin Stats
    
    private var coinStatistics: some View {
        Section {
            if let coinMetadata = viewModel.coinDetails {
                CoinStatisticsView(
                    currency: viewModel.selectedCurrency,
                    coinMarketdata: coinMetadata.marketData
                )
            }
        } header: {
            Text("coinDetails.stat.title")
                .foregroundStyle(Color.secondary)
                .font(Font.header15.bold())
                .padding(.bottom, -4)
                .padding(.top, 4)
        }
    }
    
    // MARK: - Coin Links
    
    private var coinLinks: some View {
        LazyHStack {
            Button {
                showWebsite.toggle()
            } label: {
                HStack() {
                    Image(systemName: "globe")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 13, height: 13)
                        .foregroundStyle(Color.solarGold)
                    Text("coinDetails.links.website.title")
                        .foregroundStyle(Color.primary)
                        .font(Font.secondary11.bold())
                }
            }
            .buttonStyle(.plain)
            .cellStyle(position: .single)
            
            Button {
                showBlockExplorer.toggle()
            } label: {
                HStack() {
                    Image(systemName: "link")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 13, height: 13)
                        .foregroundStyle(Color.drainerAlert)
                    Text("coinDetails.links.blockExplorer.title")
                        .foregroundStyle(Color.primary)
                        .font(Font.secondary11.bold())
                }
            }
            .buttonStyle(.plain)
            .cellStyle(position: .single)
        }
    }
}
