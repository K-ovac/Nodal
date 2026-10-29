//
//  TopGainersView.swift
//  C-Tab
//
//  Created by Максим Лозебной on 23.04.2026.
//

import SwiftUI
import Kingfisher

struct TrendingCoinsRow: View {
    
    // MARK: - Properties
    
    private let coin: TrendingCoin
    private let currency: String
    
    // MARK: - Init
    
    init(coin: TrendingCoin, currency: String) {
        self.coin = coin
        self.currency = currency
    }
    
    // MARK: - Body
        
    var body: some View {
        LazyVStack(alignment: .leading) {
            HStack(alignment: .center) {
                
                // MARK: - Coin Image
                
                if let url = URL(string: coin.small) {
                    KFImage(url)
                        .resizable()
                        .frame(width: 28, height: 28)
                        .clipShape(.circle)
                }
                
                LazyVStack(alignment: .leading, spacing: -2) {
                    Text(coin.symbol)
                        .foregroundStyle(Color.primary)
                        .font(Font.header15)
                        .lineLimit(1)
                    Text("Name")
                        .foregroundStyle(Color.secondary)
                        .font(Font.secondary11.bold())
                        .lineLimit(1)
                }
                
                Spacer()
                
                // MARK: - Coin price change percentage
                
                Text(
                    String(
                        format: "%.2f%%",
                        coin.data.priceChangePercentage24h.currency(for: currency) ?? 0
                    )
                )
                .foregroundStyle(Color.orangeNeon)
                .font(Font.hashes12.bold())
                .padding(4)
                .background(
                    (coin.data.priceChangePercentage24h.currency(for: currency) ?? 0).percentBackgroundColor
                )
                .clipShape(Metrics.shapeCr8)
                .overlay(
                    Metrics.shapeCr8
                        .strokeBorder(
                            (coin.data.priceChangePercentage24h.currency(for: currency) ?? 0).percentBorderColor,
                            lineWidth: 0.5
                        )
                )
            }
            
            // MARK: - Coin Price
            LazyVStack(alignment: .leading) {
                Text("Price")
                    .foregroundStyle(Color.secondary)
                    .font(Font.secondary11.bold())
                
                Text(
                    coin.data.price.formatted(
                        .currency(code: currency)
                    )
                )
                .foregroundStyle(Color.primary)
                .font(Font.hashes16.bold())
            }
            
        }
        .cellStyle(position: .single)
    }
}
