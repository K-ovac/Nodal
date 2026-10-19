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
        HStack {
            
            // MARK: - Coin Icon
            
            if let url = URL(string: token.image) {
                KFImage(url)
                    .resizable()
                    .frame(width: 30, height: 30)
                    .clipShape(.circle)
            }
            
            // MARK: - Coin symbol & Market cap.
            
            VStack(alignment: .leading) {
                Text(
                    token.symbol.uppercased()
                )  //token name
                .font(.body.bold())
                .foregroundStyle(.primary)
                
                Text(
                    token.marketCap.formatted(
                        .number.notation(.compactName)
                    )
                ) //token market cap
                .font(.footnote)
                .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            // MARK: - Coin Price & Price change percentage
            
            HStack {
                Text(
                    String(
                        token.currentPrice.formatted(
                            .currency(code: currency)
                        )
                    )
                )   //coin price
                .font(.body.bold())
                .foregroundStyle(.primary)
                
                Text(
                    String(
                        format: "%.2f%%", (token.priceChangePercentage24h ?? 0)
                    )
                ) //coin price change percentage
                .font(.body.bold())
                .foregroundStyle(
                    (token.priceChangePercentage24h ?? 0).percentChangeColor
                )
                .frame(minWidth: 75, alignment: .trailing)
            }
        }
    }
}
