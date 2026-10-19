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
            Rectangle()
                .frame(maxHeight: 60)
                .cornerRadius(12)
                .foregroundStyle(Color.gray)
                .opacity(0.3)
            HStack(spacing: 10) {
                VStack(alignment: .leading) {
                    Text("globalMetrics.mCap.title")
                        .font(.system(size: 12))
                    Text(String(format: "%.2f%%", globalMetrics.marketCapChangePercentage24hUsd ?? 0))
                        .bold()
                }
                VStack(alignment: .leading) {
                    Text("coinMetrics.value.title")
                        .font(.system(size: 12))
                    Text(String(globalMetrics.activeCryptocurrencies))
                        .bold()
                }
                VStack(alignment: .leading) {
                    Text("coinMetrics.btcDominance.title")
                        .font(.system(size: 12))
                    Text(String.make(for: globalMetrics.marketCapPercentage.btc ?? 0, isPrice: !Constants.isPrice))
                        .bold()
                }
            }.frame(maxWidth: .infinity)
        }
    }
}
