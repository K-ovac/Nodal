//
//  CoinStatisticsView.swift
//  C-Tab
//
//  Created by Максим Лозебной on 13.09.2026.
//

import SwiftUI

struct CoinStatisticsView: View {
    
    // MARK: - Properties
    
    private let colums: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    private let currency: String
    private let coinMetadata: CoinMetadata
    private let onSelect: (CoinStatistics) -> Void
    
    // MARK: - Init 
    
    init(
        currency: String,
        coinMetadata: CoinMetadata,
        onSelect: @escaping (CoinStatistics) -> Void
    ) {
        self.currency = currency
        self.coinMetadata = coinMetadata
        self.onSelect = onSelect
    }
    
    // MARK: - Body
    
    var body: some View {
        LazyVGrid(columns: colums, alignment: .leading, spacing: 16) {
            ForEach(CoinStatistics.allCases) { stat in
                VStack(alignment: .leading) {
                    
                    // MARK: - Stat Name
                    
                    Button {
                        onSelect(stat)
                    } label: {
                        HStack {
                            Text(stat.title)
                            Image(systemName: "info.circle")
                        }
                        .font(.footnote)
                        .foregroundStyle(.gray)
                    }
                    
                    // MARK: - Stat Value
                    
                    switch stat {
                    case .high24h:
                        Text(coinMetadata.marketData.high24h.currency(for: currency)
                            .formatted(
                                .currency(code: currency)
                            )
                        )
                    case .low24h:
                        Text(coinMetadata.marketData.low24h.currency(for: currency)
                            .formatted(
                                .currency(code: currency)
                            )
                        )
                    case .marketCap:
                        Text(coinMetadata.marketData.marketCap.currency(for: currency)
                            .formatted(
                                .currency(code: currency)
                            )
                        )
                    case .circulatingSupply:
                        Text(coinMetadata.marketData.circulatingSupply
                            .formatted(
                                .currency(code: currency)
                            )
                        )
                    case .fullyDilutedValuation:
                        Text(coinMetadata.marketData.circulatingSupply
                            .formatted(
                                .currency(code: currency)
                            )
                        )
                    case .totalSupply:
                        Text(coinMetadata.marketData.fullyDilutedValuation.currency(for: currency)
                            .formatted(
                                .currency(code: currency)
                            )
                        )
                    case .maxSupply:
                        coinMetadata.marketData.maxSupply != nil
                        ? Text(
                            (coinMetadata.marketData.maxSupply ?? 0).formatted(.number)
                        )
                        : Text("∞")
                    case .totalVolume:
                        Text(coinMetadata.marketData.totalVolume.currency(for: currency)
                            .formatted(
                                .currency(code: currency)
                            )
                        )
                    }
                }
            }
        }
    }
}
