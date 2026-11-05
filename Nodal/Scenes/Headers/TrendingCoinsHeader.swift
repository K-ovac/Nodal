//
//  TrendingCoinsHeader.swift
//  Nodal
//
//  Created by Максим Лозебной on 29.10.2026.
//

import SwiftUI

// TODO: - next

struct TrendingCoinsHeader: View {
    
    private let onShowMoreTap: () -> Void
    
    init(onShowMoreTap: @escaping () -> Void) {
        self.onShowMoreTap = onShowMoreTap
    }
    
    var body: some View {
        HStack {
            Image(systemName: "flame")
                .resizable()
                .scaledToFill()
                .frame(width: 12, height: 12)
                .foregroundStyle(Color.orangeNeon)
            Text("markets.trendingCoins.title")
                .foregroundStyle(Color.primary)
                .font(Font.ticker16.bold())
            
            Spacer()
            
            Button {
                onShowMoreTap()
            } label: {
                Text("markets.trendingCoins.showMoreButton.title")
                    .foregroundStyle(Color.cautionPermit)
                    .font(Font.header15)
            }
            .buttonStyle(.plain)
        }
        .padding(.bottom, 4)
    }
}
