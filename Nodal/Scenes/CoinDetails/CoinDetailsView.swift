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
        ZStack(alignment: .bottom) {
            
            // MARK: - Coin Details
            
            List {
                coinDetails
                    .listRowSeparator(.hidden)
            }
            .listStyle(.inset)
            
            // MARK: - Show Stat DescriptionView
            
            if let stat = selectedStat {
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                    .onTapGesture {
                        selectedStat = nil
                    }

                DescriptionView(
                    title: stat.title,
                    text: stat.description,
                    onClose: { selectedStat = nil }
                )
                .background(.background)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .padding()
                
            }
        }
        .navigationBarBackButtonHidden()
        
        .toolbar(.hidden, for: .tabBar)
        .toolbar {
            leadingToolBar
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
    
    // MARK: - Coin Details
    
    private var coinDetails: some View {
        StateView(
            content: coinDetailsContent,
            state: viewModel.coinDetailsState,
            retryAction: viewModel.fetchCoinDetails
        )
    }
    
    // MARK: - CoinDetailsContent
    
    @ViewBuilder
    private var coinDetailsContent: some View {
        warningTitle
        tokenMetricsView
        coinStatistics
        aboutToken
        coinLinks
    }
    
    // MARK: - Warning Title
    
    private var warningTitle: some View {
        Text("coinDetails.warningTitle.title")
            .foregroundStyle(.secondary)
            .font(.footnote)
    }
    
    // MARK: - Coin Metrics
    
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
                    Text(coinMetadata.description.en)
                        .lineLimit(viewModel.descriptionLineLimit(isExpanded: isExpanded))
                    
                    Button(
                        isExpanded ?
                        "coinDetails.aboutToken.button.title.less"
                        : "coinDetails.aboutToken.button.title.more"
                    ) {
                        isExpanded.toggle()
                    }
                    .foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        } header: {
            if let coinMetadata = viewModel.coinDetails {
                Text("coinDetails.description.header.title \(coinMetadata.name)?")
            }
        }
    }
    
    // MARK: - Coin Stats
    
    private var coinStatistics: some View {
        Section(
            header: Text("coinDetails.statistics.header.title")
        ) {
            if let coinMetadata = viewModel.coinDetails {
                CoinStatisticsView(
                    currency: viewModel.selectedCurrency,
                    coinMetadata: coinMetadata,
                    onSelect: { stat in
                        selectedStat = stat
                    }
                )
            }
        }
    }
    
    // MARK: - Coin Links
    
    private var coinLinks: some View {
        Section {
            if let coinMetadata = viewModel.coinDetails {
                Button {
                    showWebsite = true
                } label: {
                    HStack() {
                        Image(systemName: "globe")
                            .foregroundStyle(.white)
                        Text("coinDetails.links.website.title")
                            .foregroundStyle(.white)
                            .font(.body)
                    }
                    .padding(4)
                }
                .background(.secondary.opacity(0.6))
                .clipShape(.capsule)
                .sheet(isPresented: $showWebsite) {
                    if let url = URL(string: coinMetadata.links.homepage[0]) {
                        SafariView(url: url)
                    }
                }
            }
        }
    }
}
