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
        
    private var priceTrend: Image {
        guard let trend = coinMetadata.marketData.priceChangePercentage24h else { return Image("xmark") }
        
        return trend >= 0
        ? Image("uptrend")
        : Image("downtrend")
    }
    
    private var rangeProgress: Double {
        let currentPrice = coinMetadata.marketData.currentPrice.currency(for: currency)
        let lowPrice = coinMetadata.marketData.low24h.currency(for: currency)
        let highPrice = coinMetadata.marketData.high24h.currency(for: currency)
        
        let range = highPrice - lowPrice
        guard range > 0, !range.isNaN else { return 0 }
        
        let progress = (currentPrice - lowPrice) / range
        guard !progress.isNaN else { return 0 }
        
        return min(max(progress, 0), 1)
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
                    
                    case .price:
                        priceAndPercent
                    case .lowHighRange:
                        lowHighRange
                    }
                }
                .padding(4)
                .cellStyle(for: metric, in: CoinMetrics.allCases)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    // MARK: - Private Methods
    
    private func category() -> String {
        for category in coinMetadata.categories {
            if category == "Layer 1 (L1)" {
                return "L1"
            }
        }
        
        return ""
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
            
            VStack(alignment: .leading, spacing: -4) {
                HStack {
                    Text(coinMetadata.name)
                        .foregroundStyle(Color.primary)
                        .font(Font.header20.bold())
                        .lineLimit(1)
                    
                    if category() != "" {
                        Text(category())
                            .foregroundStyle(Color.orangeNeon)
                            .font(Font.header15)
                            .padding(.horizontal, 8)
                            .background(Color.orangeNeon.opacity(0.1))
                            .clipShape(.capsule)
                            .overlay(Metrics.shapeCapsule.strokeBorder(Color.orangeNeon, lineWidth: 1))
                    }
                }
                
                    
                Text(coinMetadata.symbol.uppercased())
                        .foregroundStyle(Color.secondary)
                        .font(Font.hashes12.bold())
                
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    // MARK: - Price and Percent
    
    private var priceAndPercent: some View {
        HStack {
            
            Text(
                coinMetadata.marketData.currentPrice.currency(for: currency)
                    .formattedPrice(currency: currency)
            )
            .foregroundStyle(Color.primary)
            .font(Font.hashes20.bold())
            
            Spacer()
            
            LazyHStack {
                Image(
                    (coinMetadata.marketData.priceChangePercentage24h ?? 0) >= 0
                    ? "uptrend"
                    : "downtrend"
                )
                .renderingMode(.template)
                .resizable()
                .scaledToFill()
                .frame(width: 16, height: 16)
                
                Text("\((coinMetadata.marketData.priceChangePercentage24h ?? 0).formattedPercentage()) coinDetails.metrics.percentage24h.title")
            }
            .foregroundStyle(
                (coinMetadata.marketData.priceChangePercentage24h ?? 0)
                    .itemColor()
            )
            .font(Font.hashes12.bold())
            .lineLimit(1)
            .padding(.vertical, 2)
            .padding(.horizontal, 8)
            .background(
                (coinMetadata.marketData.priceChangePercentage24h ?? 0)
                    .itemColor(isNeedOpacity: true))
            .overlay(
                Metrics.shapeCapsule
                    .strokeBorder(
                        (coinMetadata.marketData.priceChangePercentage24h ?? 0)
                            .itemColor()))
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
                
                Text(coinMetadata.marketData.low24h.currency(for: currency).formattedPrice(currency: currency))
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
                
                Text(coinMetadata.marketData.high24h.currency(for: currency).formattedPrice(currency: currency))
                    .bold()
                    .foregroundStyle(Color.primary)
                    .font(Font.hashes12.bold())
            }
            
            Spacer()
            
            ProgressView(
                value: rangeProgress,
                total: 1.0
            )
            .padding(.bottom, 4)
            .progressViewStyle(.linear)
            .tint(Color.linearGradient)
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
