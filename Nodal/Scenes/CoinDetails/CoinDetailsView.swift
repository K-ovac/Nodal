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
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var isExpanded: Bool = false
    @State private var showWebsite: Bool = false
    @State private var selectedStat: CoinStatistics?
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
            trailingToolbar
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
            Button {
                dismiss()
            } label: {
                
                HStack(spacing: 4) {
                    Image(systemName: "chevron.left")
                        .padding(.trailing, 8)
                    Image("hamburger")
                        .renderingMode(.template)
                        .resizable()
                        .frame(width: 25, height: 25)
                    Text(
                        "\(viewModel.coinDetails?.symbol ?? "Coin")/\(viewModel.selectedCurrency)"
                            .uppercased()
                    )
                }
            }
        }
    }
    
    private var trailingToolbar: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Button {
                //
            } label: {
                Image(systemName: "star.fill")
                    .foregroundStyle(Color.solarGold)
            }
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
                    
                    Text(coinMetadata.description.en)
                        .foregroundStyle(Color.secondary)
                        .font(Font.body13)
                        .lineLimit(viewModel.descriptionLineLimit(isExpanded: isExpanded))
                    
                    Button {
                        isExpanded.toggle()
                    } label: {
                        Text(
                            isExpanded ?
                             "coinDetails.aboutToken.button.title.less"
                             : "coinDetails.aboutToken.button.title.more"
                        )
                        .foregroundStyle(Color.secondary)
                        .font(Font.secondary11)
                    }
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
            }
        }
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
        }
    }
    
    // MARK: - Coin Links
    
    private var coinLinks: some View {
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
                    .font(Font.body13.bold())
            }
        }
        .buttonStyle(.plain)
        .cellStyle(position: .single)
    }
}
