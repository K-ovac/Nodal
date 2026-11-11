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
    
    // MARK: - Сalculated Values
    
    private var circulatingSupplyPercent: String {
        guard let maxSupply = coinMarketdata.maxSupply, maxSupply > 0 else {
            return "∞"
        }
        return ((coinMarketdata.circulatingSupply * 100) / Double(maxSupply))
            .formattedPercentage(isChange: false)
    }
    
    private var circulatingProgress: Double {
        guard let maxSupply = coinMarketdata.maxSupply, maxSupply > 0 else {
            return 0
        }
        let progress = coinMarketdata.circulatingSupply / Double(maxSupply)
        guard !progress.isNaN else { return 0 }
        return min(max(progress, 0), 1)
    }
    
    private var maxSupply: String {
        guard let maxSupply = coinMarketdata.maxSupply, maxSupply > 0 else {
            return "∞"
        }
        return maxSupply.formatted(.number.notation(.compactName))
    }
    
    private var fdvSubtitle: String {
       let result = (coinMarketdata.marketCap.currency(for: currency)
         / coinMarketdata.fullyDilutedValuation.currency(for: currency))
        
        return String(format: "%.2f%", result)
    }
    
    private var tradingVolSubtitle: String {
        let result = (coinMarketdata.totalVolume.currency(for: currency)
          / coinMarketdata.marketCap.currency(for: currency))
        
        return result.formattedPercentage(isChange: false)
    }
    
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
                            value: coinMarketdata.marketCap.currency(for: currency).formattedCompactCurrency(currency: currency),
                            subtitle: "coinDetails.stat.mCap.subtitle \((coinMarketdata.marketCapChangePercentage24h ?? 0).formattedPercentage())",
                            subtitleColor: Color.solarGold
                        )
                                                
                    case .fullyDilutedValuation:
                        statValue(
                            title: stat.title,
                            value: coinMarketdata.fullyDilutedValuation.currency(for: currency).formattedCompactCurrency(currency: currency),
                            subtitle: "coinDetails.stat.fdv.subtitle: \(fdvSubtitle)",  //here
                            subtitleColor: Color.gray
                        )
                        
                    case .totalVolume:
                        statValue(
                            title: stat.title,
                            value: coinMarketdata.totalVolume.currency(for: currency).formattedCompactCurrency(currency: currency),
                            subtitle: "coinDetails.stat.totalVolume.subtitle \(tradingVolSubtitle)", //here
                            subtitleColor: Color.enclaveSafe
                        )
                        
                    case .ath:
                        statValue(
                            title: stat.title,
                            value: coinMarketdata.ath.currency(for: currency).formattedPrice(currency: currency),
                            subtitle: "\((coinMarketdata.athChangePercentage.currency(for: currency).formattedPercentage())) coinDetails.stat.ath.subtitle",
                            subtitleColor: Color.orangeNeon
                        )
                    }
            }
            .padding(4)
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
        value: String,
        subtitle: LocalizedStringKey,
        subtitleColor: Color
    ) -> some View {
        LazyVStack(alignment: .leading) {
            Text(title)
                .foregroundStyle(Color.secondary)
                .font(Font.secondary11.bold())
            
            Text(value)
            .foregroundStyle(Color.primary)
            .font(Font.hashes16)
            
            Text(subtitle)
                .foregroundStyle(subtitleColor)
                .font(Font.hashes12.bold())
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
    
    // MARK: - Circulating Supply
    
    private var circulatingSupply: some View {
        LazyVStack(alignment: .leading) {
            HStack {
                
                Text("coinDetails.stat.circSupply.title")
                    .foregroundStyle(Color.secondary)
                    .font(Font.hashes12.bold())
                
                Text(coinMarketdata.circulatingSupply.formattedCompactValue())
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
                value: circulatingProgress,
                total: 1.0
            )
            .progressViewStyle(.linear)
            .tint(Color.linearGradient)
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
                .font(Font.hashes12.bold())
                
                Spacer()
                
                Text(
                    "coinDetails.stat.atl.title \((coinMarketdata.atl.currency(for: currency)).formattedPrice(currency: currency))"
                )
                .foregroundStyle(Color.secondary)
                .font(Font.hashes12.bold())
            }
        }
        .padding(4)
        .cellStyle(position: .single)
        .frame(maxHeight: .infinity)
    }
}
