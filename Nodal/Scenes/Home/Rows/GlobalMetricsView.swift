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
            Color.linearGradient.opacity(0.25)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            LazyVStack(alignment: .leading, spacing: 4) {
                HStack(spacing: 4) {
                    Image(systemName: "globe")
                        .resizable()
                        .scaledToFill()
                        .foregroundStyle(Color.solarGold)
                        .frame(width: 14, height: 14)
                    Text("markets.globalMetrics.title")
                        .foregroundStyle(Color.primary)
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
                                value: (globalMetrics.totalMarketCap.usd ?? 0),
                                subtitle: (globalMetrics.marketCapChangePercentage24hUsd ?? 0),
                                subtitleColor: Color.solarGold,
                                isMCap: true
                            )
                        case .btcDominance:
                            metricCell(
                                title: "markets.globalMetrics.btcDominance.title",
                                value: (globalMetrics.marketCapPercentage.btc ?? 0),
                                isDominance: true
                            )
                        case .totalVolume:
                            metricCell(
                                title: "markets.globalMetrics.totalVolume.title",
                                value: (globalMetrics.totalVolume.usd ?? 0),
                                subtitle: globalMetrics.marketCapChangePercentage24hUsd ?? 0,
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
        .overlay(Metrics.shapeCr16.strokeBorder(Color.solarGold, lineWidth: 0.5))
    }
}

extension GlobalMetricsView {
    private func metricCell(
        title: LocalizedStringKey,
        value: Double,
        subtitle: Double = 0,
        subtitleColor: Color = Color.secondary,
        isDominance: Bool = false,
        isMCap: Bool = false
    ) -> some View {
        LazyVStack(alignment: .leading, spacing: 0) {
            Text(title)
                .foregroundStyle(Color.secondary)
                .font(Font.secondary11.bold())
            
            Text(
                isDominance
                ? value.percentChange
                : value.statValue
            )
            .foregroundStyle(Color.primary)
            .font(Font.hashes16.bold())
            
            if isDominance {
                ProgressView(
                    value: value,
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
                Text(subtitle.percentChange)
                    .foregroundStyle(subtitle.percentChangeColor)
                    .font(Font.hashes12.bold())
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(4)
        .cellStyle(position: .single)
    }
}

private enum GlobalMetricsValues: String, CaseIterable, Identifiable {
    case marketCap, btcDominance, totalVolume
    
    var id: String { rawValue }
}
