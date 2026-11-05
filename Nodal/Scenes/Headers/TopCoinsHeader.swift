//
//  TopCoinsHeader.swift
//  Nodal
//
//  Created by Максим Лозебной on 05.11.2026.
//

import SwiftUI

struct TopCoinsHeader: View {
    var body: some View {
        LazyHStack(spacing: 4) {
            Image("vertical.equalize")
                .renderingMode(.template)
                .resizable()
                .scaledToFill()
                .frame(width: 16, height: 18)
                .foregroundStyle(Color.solarGold)
            
            Text("markets.topCoins.title")
                .foregroundStyle(Color.primary)
                .font(Font.ticker16.bold())
        }
        .padding(.bottom, 4)
    }
}
