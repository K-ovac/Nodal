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
        
        // MARK: - ZStack
        
        VStack(alignment: .leading) {
            
            coinName
            
            // MARK: - Coin Price Data
            
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
                
                Text(
                    String(
                        format: "%.2f%%",
                        coinMetadata.marketData.priceChangePercentage24h ?? 0
                    )
                )
                .foregroundStyle(
                    (coinMetadata.marketData.priceChangePercentage24h ?? 0)
                        .percentChangeColor
                )
                .font(Font.hashes16.bold())
                .padding(.vertical, 4)
                .padding(.horizontal, 8)
                .background((coinMetadata.marketData.priceChangePercentage24h ?? 0).percentBackgroundColor)
                .clipShape(Metrics.shapeCr8)
                .overlay(Metrics.shapeCr8.strokeBorder((coinMetadata.marketData.priceChangePercentage24h ?? 0).percentBorderColor))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .cellStyle(position: .single)
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}


extension CoinMetricsView {
    private var coinName: some View {
        HStack {
            if let url = URL(string: coinMetadata.image.small) {
                KFImage(url)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 32, height: 32)
                    .clipShape(.circle)
            }
            
            Text(coinMetadata.name)
                .foregroundStyle(Color.primary)
                .font(Font.header20.bold())
                .lineLimit(1)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    CoinDetailsView(coinId: "bitcoin")
}
