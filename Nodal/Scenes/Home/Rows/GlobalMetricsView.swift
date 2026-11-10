//
//  MarketInfoRow.swift
//  C-Tab
//
//  Created by Максим Лозебной on 09.06.2026.
//

import SwiftUI

// MARK: - GlobalMetricsView

struct GlobalMetricsView: View {
    
    // MARK: - Properties
    
    private let globalMetrics: GlobalMetrics
        
    // MARK: - Init
    
    init(globalMetrics: GlobalMetrics) {
        self.globalMetrics = globalMetrics
    }
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            Color.linearGradient
            Color.black.opacity(0.65)
            
            LazyVStack(alignment: .leading, spacing: 4) {
                HStack(spacing: 4) {
                    Image(systemName: "globe")
                        .resizable()
                        .scaledToFill()
                        .foregroundStyle(Color.solarGold)
                        .frame(width: 14, height: 14)
                    Text("markets.globalMetrics.title")
                        .foregroundStyle(Color.white)
                        .font(Font.header15.bold())
                }
                .padding(.leading, 12)
                .padding(.top, 8)
                
                LazyVGrid(columns: Metrics.columns(count: 3)) {
                    ForEach(GlobalMetricsValues.allCases) { metric in
                        switch metric {
                        case .marketCap:
                            metricCell(
                                title: "markets.globalMetrics.mCap.title",
                                value: (globalMetrics.totalMarketCap.usd ?? 0).formattedCompactCurrency(currency: CurrencyPrice.usd.id),
                                subtitle: (globalMetrics.marketCapChangePercentage24hUsd ?? 0).formattedPercentage(),
                                subtitleColor: Color.solarGold,
                                isMCap: true
                            )
                        case .btcDominance:
                            metricCell(
                                title: "markets.globalMetrics.btcDominance.title",
                                value: (globalMetrics.marketCapPercentage.btc ?? 0).formattedPercentage(isChange: false),
                                isDominance: true
                            )
                        case .totalVolume:
                            metricCell(
                                title: "markets.globalMetrics.totalVolume.title",
                                value: (globalMetrics.totalVolume.usd ?? 0).formattedCompactCurrency(currency: CurrencyPrice.usd.id),
                                subtitle: (((globalMetrics.totalVolume.usd ?? 0) * 100) / (globalMetrics.totalMarketCap.usd ?? 0)).formattedPercentage(isChange: false),
                                subtitleColor: Color.enclaveSafe
                            )
                        }
                    }
                }
                .padding(8)
            }
            .padding(8)
        }
        .clipShape(Metrics.shapeCr16)
        .overlay(Metrics.shapeCr16.strokeBorder(Color.solarGold.opacity(0.25), lineWidth: 1))
    }
}

extension GlobalMetricsView {
    private func metricCell(
        title: LocalizedStringKey,
        value: String,
        subtitle: String = "",
        subtitleColor: Color = Color.secondary,
        isDominance: Bool = false,
        isMCap: Bool = false
    ) -> some View {
        LazyVStack(alignment: .leading, spacing: 0) {
            Text(title)
                .foregroundStyle(Color.secondary)
                .font(Font.secondary11.bold())
            
            Text(value)
                .foregroundStyle(Color.primary)
                .font(Font.hashes16.bold())
            
            if isDominance {
                ProgressView(
                    value: globalMetrics.marketCapPercentage.btc,
                    total: 100)
                .progressViewStyle(.linear)
                .tint(Color.linearGradient)
                .scaleEffect(
                    x: 1,
                    y: 1.5,
                    anchor: .leading
                )
                .padding(.top, 4)
            } else {
                Text(subtitle)
                    .foregroundStyle(subtitleColor)
                    .font(Font.hashes12.bold())
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .padding(4)
        .cellStyle(position: .single)
    }
}

private enum GlobalMetricsValues: String, CaseIterable, Identifiable {
    case marketCap, btcDominance, totalVolume
    
    var id: String { rawValue }
}

#Preview {
    TabListView()
}
