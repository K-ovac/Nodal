//
//  TopListView.swift
//  C-Tab
//
//  Created by Максим Лозебной on 22.04.2026.
//

import SwiftUI
import Kingfisher

// MARK: - TopListRow

struct TopListRow: View {
    
    // MARK: - Properties
    
    private let token: TokenList
    private let currency: String
    
    // MARK: - Init
    
    init(token: TokenList, currency: String) {
        self.token = token
        self.currency = currency
    }
    
    // MARK: - Body
    
    var body: some View {
        HStack(spacing: 4) {
            
            Text(
                String(token.marketCapRank)
            )
            .foregroundStyle(Color.secondary)
            .font(Font.hashes16)
            .frame(width: 20, alignment: .center)
            
            // MARK: - Coin Icon
            
            if let url = URL(string: token.image) {
                KFImage(url)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 32, height: 32)
                    .clipShape(.circle)
            }
            
            // MARK: - Coin symbol & Market cap.
            
            VStack(alignment: .leading, spacing: 0) {
                HStack(spacing: 4) {
                    //coin name
                    Text(
                        token.symbol.uppercased()
                    )
                    .font(Font.header15.bold())
                    .foregroundStyle(.primary)
                    
                    //coin market cap
                    Text(
                        token.marketCap.formatted(
                            .number.notation(.compactName)
                        )
                    )
                    .font(Font.secondary11.bold())
                    .foregroundStyle(Color.drainerAlert)
                    .padding(.horizontal, 4)
                    .padding(.vertical, 2)
                    .background(Color.drainerAlert.opacity(0.1))
                    .clipShape(Metrics.shapeCr8)
                }
                
                //coin name
                Text(token.name)
                    .foregroundStyle(Color.secondary)
                    .font(Font.secondary11.bold())
            }
            
            Spacer()
            
            // MARK: - Coin Price & Price change percentage
            
            VStack(alignment: .trailing) {
                Text(
                    String(
                        token.currentPrice.formatted(
                            .currency(code: currency)
                        )
                    )
                )   //coin price
                .font(Font.hashes16.bold())
                .foregroundStyle(.primary)
                
                Text(
                    String(
                        format: "%.2f%%", (token.priceChangePercentage24h ?? 0)
                    )
                ) //coin price change percentage
                .font(Font.secondary11.bold())
                .foregroundStyle(
                    (token.priceChangePercentage24h ?? 0).percentChangeColor
                )
                .frame(minWidth: 75, alignment: .trailing)
            }
        }
        .padding(.trailing, 8)
        
    }
}
