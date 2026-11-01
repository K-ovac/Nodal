//
//  TokenMetricsView.swift
//  C-Tab
//
//  Created by Максим Лозебной on 09.09.2026.
//

import SwiftUI
import Kingfisher

// MARK: - CoinMetricsView

struct CoinMetricsView: View {
    
    // MARK: - Properties
        
    private let coinMetadata: CoinMetadata
    private let currency: String
    
    private let nodalVerified = 98.9.percentChange
    
    private var priceTrend: Image {
        guard let trend = coinMetadata.marketData.priceChangePercentage24h else { return Image("xmark") }
        
        return trend >= 0
        ? Image("uptrend")
        : Image("downtrend")
    }
    
    // MARK: - Init
    
    init(
        coinMetadata: CoinMetadata,
        currency: String
    ) {
        self.coinMetadata = coinMetadata
        self.currency = currency
    }
    
    // MARK: - Body
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 0) {
            
            // MARK: - Coin Price Data
            
            coinName
                .padding(.bottom)
            
            ForEach(CoinMetrics.allCases) { metric in
                LazyVStack {
                    switch metric {
                    
                    case .price: priceAndPercent
                    
                    case .lowHighRange: lowHighRange
                    }
                }
                .padding(4)
                .cellStyle(for: metric, in: CoinMetrics.allCases)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

// MARK: - Extension CoinMetricsView

extension CoinMetricsView {
    
    // MARK: - Coin name, Image, Nodal status
    
    private var coinName: some View {
        LazyHStack {
            if let url = URL(string: coinMetadata.image.small) {
                KFImage(url)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 36, height: 36)
                    .clipShape(.circle)
            }
            
            LazyVStack(alignment: .leading, spacing: 0) {
                Text(coinMetadata.name)
                    .foregroundStyle(Color.primary)
                    .font(Font.header20.bold())
                    .lineLimit(1)
                
                // TODO: - доработка с модулем Sign Guard
                
                LazyHStack(spacing: 4) {
                    Image("signGuard")
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 12, height: 12)
                        .foregroundStyle(Color.enclaveSafe)
                    
                    Text("coinDetails.metrics.nodalStatus.title (\(nodalVerified))")
                        .foregroundStyle(Color.enclaveSafe)
                        .font(Font.hashes12.bold())
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    // MARK: - Price and Percent
    
    private var priceAndPercent: some View {
        HStack {
            
            Text(
                coinMetadata.marketData.currentPrice.currency(for: currency)
                    .formatted(
                        .currency(code: currency)
                    )
            )
            .foregroundStyle(Color.primary)
            .font(Font.hashes20.bold())
            
            Spacer()
            
            LazyHStack {
                priceTrend
                .renderingMode(.template)
                
                Text("\((coinMetadata.marketData.priceChangePercentage24h ?? 0).percentChange) coinDetails.metrics.percentage24h.title")
            }
            .foregroundStyle(
                (coinMetadata.marketData.priceChangePercentage24h ?? 0)
                    .percentChangeColor
            )
            .font(Font.hashes12.bold())
            .lineLimit(1)
            .padding(.vertical, 2)
            .padding(.horizontal, 8)
            .background(
                (coinMetadata.marketData.priceChangePercentage24h ?? 0)
                    .percentBackgroundColor)
            .overlay(
                Metrics.shapeCapsule
                    .strokeBorder(
                        (coinMetadata.marketData.priceChangePercentage24h ?? 0)
                            .percentBorderColor))
            .clipShape(.capsule)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    // MARK: - Low/High Range
    
    private var lowHighRange: some View {
        LazyVStack(alignment: .leading) {
            HStack {
                
                Text("coinDetails.metrics.low24h.title")
                    .foregroundStyle(Color.secondary)
                    .font(Font.hashes12.bold())
                
                Text(coinMetadata.marketData.low24h.currency(for: currency).formatted(.currency(code: currency)))
                    .bold()
                    .foregroundStyle(Color.primary)
                    .font(Font.hashes12.bold())
                
                Spacer()
                
                Text("coinDetails.metrics.lowHighRange.title")
                    .foregroundStyle(Color.solarGold)
                    .font(Font.hashes12.bold())
                
                Spacer()
                
                Text("coinDetails.metrics.high24h.title")
                    .foregroundStyle(Color.secondary)
                    .font(Font.hashes12.bold())
                
                Text(coinMetadata.marketData.high24h.currency(for: currency).formatted(.currency(code: currency)))
                    .bold()
                    .foregroundStyle(Color.primary)
                    .font(Font.hashes12.bold())
            }
            
            Spacer()
            
            ProgressView(
                value: coinMetadata.marketData.currentPrice.currency(for: currency),
                total: coinMetadata.marketData.high24h.currency(for: currency)
            )
            .padding(.bottom, 4)
            .progressViewStyle(.linear)
            .tint(Color.progressGradient)
            .scaleEffect(
                x: 1,
                y: 1.5,
                anchor: .center
            )
        }
    }
}

// MARK: - Enum CoinMetrics

private enum CoinMetrics: String, Identifiable, CaseIterable {
    case price, lowHighRange
    
    var id: String { rawValue }
}
