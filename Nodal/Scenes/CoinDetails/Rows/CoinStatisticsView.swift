//
//  CoinStatisticsView.swift
//  C-Tab
//
//  Created by Максим Лозебной on 13.09.2026.
//

import SwiftUI

struct CoinStatisticsView: View {
    
    // MARK: - Properties
    
    private let colums: [GridItem] = Array(repeating: GridItem(.flexible()), count: 2)
    private let currency: String
    private let coinMarketdata: CoinMarketData
    
    // MARK: - Init
    
    init(
        currency: String,
        coinMarketdata: CoinMarketData,
    ) {
        self.currency = currency
        self.coinMarketdata = coinMarketdata
    }
    
    // MARK: - Body
    
    var body: some View {
        LazyVGrid(columns: colums) {
            ForEach(CoinStatistics.allCases) { stat in
                    
                    switch stat {
                        
                    case .marketCap:
                        statValue(
                            title: stat.title,
                            value: coinMarketdata.marketCap.currency(for: currency),
                            subTitle: "coinDetails.stat.mCapDominance.subTitle",
                            subTextColor: Color.solarGold
                        )
                        

                    case .circulatingSupply:
                        statValue(
                            title: stat.title,
                            value: coinMarketdata.circulatingSupply,
                            subTitle: "coinDetails.stat.circSupply.subTitle",
                            subTextColor: Color.gray
                        )
                        
                    case .fullyDilutedValuation:
                        statValue(
                            title: stat.title,
                            value: coinMarketdata.fullyDilutedValuation.currency(for: currency),
                            subTitle: "coinDetails.stat.fdv.subTitle",
                            subTextColor: Color.enclaveSafe
                        )
                        
                    case .totalVolume:
                        statValue(
                            title: stat.title,
                            value: coinMarketdata.totalVolume.currency(for: currency),
                            subTitle: "coinDetails.stat.totalVolume.subTitle",
                            subTextColor: Color.orangeNeon
                        )
                    }
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .cellStyle(position: .single)
        }
    }
}

extension CoinStatisticsView {
    private func statValue(
        title: LocalizedStringKey,
        value: Double,
        subTitle: LocalizedStringKey,
        subTextColor: Color
    ) -> some View {
        LazyVStack(alignment: .leading) {
            Text(title)
                .foregroundStyle(Color.secondary)
                .font(Font.secondary11.bold())
            
            Text(value
                .formatted(
                    .number.notation(.compactName)
                )
            )
            .foregroundStyle(Color.primary)
            .font(Font.hashes16)
            
            Text(subTitle)
                .foregroundStyle(subTextColor)
                .font(Font.secondary11.bold())
        }
    }
}

#Preview {
    CoinDetailsView(coinId: "bitcoin")
}
