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
        HStack {
            
            // MARK: - Coin Image
            
            if let url = URL(string: coin.small) {
                KFImage(url)
                    .resizable()
                    .frame(width: 20, height: 20)
                    .clipShape(Circle())
            }
            
            // MARK: - Coin Price
            
            Text(
                coin.data.price.formatted(
                    .currency(code: currency)
                )
            )
            
            Spacer()
            
            // MARK: - Coin price change percentage
            
            Text(
                String(
                    format: "%.2f%%",
                    coin.data.priceChangePercentage24h.currency(for: currency) ?? 0
                )
            )
            .padding(4)
            .frame(alignment: .center)
            .foregroundStyle(.white.opacity(0.8))
            .background((coin.data.priceChangePercentage24h.currency(for: currency) ?? 0).percentChangeColor)
            .cornerRadius(8)
            
        }
        .padding(4)
        .background(.gray.opacity(0.3))
        .cornerRadius(8)
        .foregroundStyle(.primary)
        .font(.body)
        .bold()
    }
}
