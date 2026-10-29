//
//  CoinStatisticsView.swift
//  C-Tab
//
//  Created by Максим Лозебной on 13.09.2026.
//

import SwiftUI

struct CoinStatisticsRow: View {
    
    // MARK: - Properties
    
    private let colums: [GridItem] = Array(repeating: GridItem(.flexible()), count: 2)
    private let currency: String
    private let coinMetadata: CoinMetadata
    
    // MARK: - Init
    
    init(
        currency: String,
        coinMetadata: CoinMetadata,
    ) {
        self.currency = currency
        self.coinMetadata = coinMetadata
    }
    
    // MARK: - Body
    
    var body: some View {
        LazyVGrid(columns: colums) {
            ForEach(CoinStatistics.allCases) { stat in
                VStack(alignment: .leading, spacing: 0) {
                    
                    // MARK: - Stat Name
                    
                    Text(stat.title)
                        .foregroundStyle(Color.secondary)
                        .font(Font.secondary11.bold())
                    
                    // MARK: - Stat Value
                    
                    switch stat {
                    case .marketCap:
                        LazyVStack(alignment: .leading) {
                            Text(coinMetadata.marketData.marketCap.currency(for: currency)
                                .formatted(
                                    .number.notation(.compactName)
                                )
                            )
                            .foregroundStyle(Color.primary)
                            .font(Font.hashes16)
                            
                            Text(stat.subText)
                                .foregroundStyle(Color.solarGold)
                                .font(Font.secondary11.bold())
                        }
                    case .circulatingSupply:
                        LazyVStack(alignment: .leading) {
                            Text(coinMetadata.marketData.circulatingSupply
                                .formatted(
                                    .number.notation(.compactName)
                                )
                            )
                            .foregroundStyle(Color.primary)
                            .font(Font.hashes16)
                            
                            Text(stat.subText)
                                .foregroundStyle(Color.gray)
                                .font(Font.secondary11.bold())
                        }
                        
                    case .fullyDilutedValuation:
                        LazyVStack(alignment: .leading) {
                            Text(coinMetadata.marketData.circulatingSupply
                                .formatted(
                                    .number.notation(.compactName)
                                )
                            )
                            .foregroundStyle(Color.primary)
                            .font(Font.hashes16)
                            
                            Text(stat.subText)
                                .foregroundStyle(Color.enclaveSafe)
                                .font(Font.secondary11.bold())
                        }
                        
                    case .totalVolume:
                        LazyVStack(alignment: .leading) {
                            Text(coinMetadata.marketData.totalVolume.currency(for: currency)
                                .formatted(
                                    .number.notation(.compactName)
                                )
                            )
                            .foregroundStyle(Color.primary)
                            .font(Font.hashes16)
                            
                            Text(stat.subText)
                                .foregroundStyle(Color.orangeNeon)
                                .font(Font.secondary11.bold())
                        }
                        
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .cellStyle(position: .single)
        }
    }
}

#Preview {
    CoinDetailsView(coinId: "bitcoin")
}
