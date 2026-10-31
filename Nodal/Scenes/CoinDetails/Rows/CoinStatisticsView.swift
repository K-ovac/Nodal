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
    
    // MARK: - Private
    
    private var circulatingSupplyPercent: String {
        coinMarketdata.maxSupply != nil
        ? ((coinMarketdata.circulatingSupply * 100) / Double((coinMarketdata.maxSupply ?? 0))).percentChange
        : "∞"
    }
    
    private var maxSupply: String {
        coinMarketdata.maxSupply != nil
        ? (coinMarketdata.maxSupply ?? 0).formatted(.number.notation(.compactName))
        : "∞"
    }
    
    private var fdvSubtitle: String {
       let result = (coinMarketdata.marketCap.currency(for: currency)
         / coinMarketdata.fullyDilutedValuation.currency(for: currency))
        
        return String(format: "%.2f%", result)
    }
    
    private var tradingVolSubtitle: String {
        let result = (coinMarketdata.totalVolume.currency(for: currency)
          / coinMarketdata.marketCap.currency(for: currency))
        
        return result.percentChange
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
                            subtitle: "coinDetails.stat.mCap.subtitle \((coinMarketdata.marketCapChangePercentage24h ?? 0).percentChange)",
                            subtitleColor: Color.solarGold
                        )
                        
                        // TODO: добавить значение подтекста
                        
                    case .fullyDilutedValuation:
                        statValue(
                            title: stat.title,
                            value: coinMarketdata.fullyDilutedValuation.currency(for: currency),
                            subtitle: "coinDetails.stat.fdv.subtitle: \(fdvSubtitle)",  //here
                            subtitleColor: Color.gray
                        )

                        // TODO: добавить значение подтекста
                        
                    case .totalVolume:
                        statValue(
                            title: stat.title,
                            value: coinMarketdata.circulatingSupply,
                            subtitle: "coinDetails.stat.totalVolume.subtitle \(tradingVolSubtitle)", //here
                            subtitleColor: Color.enclaveSafe
                        )
                        
                    case .ath:
                        statValue(
                            title: stat.title,
                            value: coinMarketdata.ath.currency(for: currency),
                            subtitle: "\((coinMarketdata.athChangePercentage.currency(for: currency).percentChange)) coinDetails.stat.ath.subtitle",
                            subtitleColor: Color.orangeNeon
                        )
                    }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .cellStyle(position: .single)
        }
        
        circulatingSupply
    }
}

// MARK: - Extension CoinStatisticsView

extension CoinStatisticsView {
    
    // MARK: - Stat Cell
    
    private func statValue(
        title: LocalizedStringKey,
        value: Double,
        subtitle: LocalizedStringKey,
        subtitleColor: Color
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
            
            Text(subtitle)
                .foregroundStyle(subtitleColor)
                .font(Font.secondary11.bold())
        }
    }
    
    // MARK: - Circulating Supply
    
    private var circulatingSupply: some View {
        VStack(alignment: .leading) {
            HStack {
                
                Text("coinDetails.stat.circSupply.title")
                    .foregroundStyle(Color.secondary)
                    .font(Font.body13.bold())
                
                Text(coinMarketdata.circulatingSupply.statValue)
                    .bold()
                    .foregroundStyle(Color.primary)
                    .font(Font.hashes12.bold())
                
                Spacer()
                
                Text(circulatingSupplyPercent)
                    .foregroundStyle(Color.solarGold)
                    .font(Font.hashes12.bold())
            }
            
            Spacer()
            
            ProgressView(
                value: coinMarketdata.circulatingSupply,
                total: Double(coinMarketdata.maxSupply ?? 0)
            )
            .progressViewStyle(.linear)
            .tint(Color.progressGradient)
            .scaleEffect(
                x: 1,
                y: 1.5,
                anchor: .center
            )
            
            HStack {
                
                Text(
                    "coinDetails.stat.maxSupply.title \(maxSupply))"
                )
                .foregroundStyle(Color.secondary)
                .font(Font.body13.bold())
                
                Spacer()
                
                Text(
                    "coinDetails.stat.atl.title \((coinMarketdata.atl.currency(for: currency)).statValue))"
                )
                .foregroundStyle(Color.secondary)
                .font(Font.body13.bold())
            }
        }
        .cellStyle(position: .single)
    }
}
