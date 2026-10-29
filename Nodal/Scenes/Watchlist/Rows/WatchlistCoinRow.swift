//
//  WatchlistCoinRow.swift
//  Nodal
//
//  Created by Максим Лозебной on 28.10.2026.
//

import SwiftUI

// MARK: - WatchlistCoinRow

struct WatchlistCoinRow: View {
    
    // MARK: - Properties
    
    private let coin: TokenList
    private let currency: String
    private let removeAction: () -> Void
    
    // MARK: - Init
    
    init(coin: TokenList, currency: String, removeAction: @escaping () -> Void) {
        self.coin = coin
        self.currency = currency
        self.removeAction = removeAction
    }
    
    // MARK: - Body
    
    var body: some View {
        HStack {
            Image(coin.image)
                .resizable()
                .scaledToFill()
                .frame(width: 32, height: 32)
            
            VStack(alignment: .leading) {
                HStack {
                    Text(coin.symbol)
                        .foregroundStyle(Color.primary)
                        .font(Font.header15.bold())
                    
                    Text("#\(coin.marketCapRank)")
                        .foregroundStyle(Color.secondary)
                        .font(Font.secondary11)
                        .padding(.vertical, 2)
                        .padding(.horizontal, 6)
                        .background(Color.gray.opacity(0.25))
                        .clipShape(RoundedRectangle(cornerRadius: 6))
                }
                
                Text(coin.name)
                    .foregroundStyle(Color.secondary)
                    .font(Font.secondary14)
            }
            
            Spacer()
            
            VStack(alignment: .trailing) {
                Text(coin.currentPrice.formatted(.currency(code: currency)))
                    .foregroundStyle(Color.primary)
                    .font(Font.header15.bold())
                
                Text(String(format: "%.2f%%", coin.priceChangePercentage24h ?? 0))
                    .font(Font.secondary14.bold())
            }
            
            // MARK: - Remove Action
            
            Image(systemName: "star.fill")
                .resizable()
                .scaledToFill()
                .frame(width: 14, height: 14)
                .foregroundStyle(Color.solarGold)
                .padding(8)
                .background(Color.solarGold.opacity(0.4))
                .clipShape(.circle)
                .onTapGesture {
                    removeAction()
                }
        }
        .cellStyle(position: .single)
    }
}
