//
//  WatchlistIndexRow.swift
//  Nodal
//
//  Created by Максим Лозебной on 28.10.2026.
//

import SwiftUI

// MARK: - WatchlistIndexRow

struct WatchlistIndexRow: View {
    
    // MARK: - Properties
    
    private let index: WatchlistModel
    
    // MARK: - Init
    
    init(index: WatchlistModel) {
        self.index = index
    }
    
    // MARK: - Body
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.gradient
                
                VStack(alignment: .leading) {
                    HStack {
                        Image(systemName: "star.hexagon")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 14, height: 14)
                        Text("WATCHLIST INDEX 24h")
                            .font(Font.secondary14.bold())
                        
                        Spacer()
                        
                        Text("NODE ALERT ACTIVE")
                            .font(Font.body13.bold())
                            .foregroundStyle(Color.solarGold)
                            .padding(.vertical, 4)
                            .padding(.horizontal, 8)
                            .background(Color.navigation.opacity(0.7))
                            .clipShape(.capsule)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Spacer()
                    
                    HStack(alignment: .bottom) {
                        VStack(alignment: .leading) {
                            Text("+8.62% 24h")
                                .font(Font.header20.bold())
                            
                            HStack {
                                Text("Top Gainer:")
                                    .font(Font.secondary14)
                                Text("SUI(+14.2%)")
                                    .font(Font.secondary14.bold())
                            }
                        }
                        
                        Spacer()
                        
                        VStack(alignment: .trailing) {
                            Text("Tracked")
                                .font(Font.secondary14)
                            Text("\(index.trackedCoins) coins")
                                .font(Font.body18.bold())
                        }
                    }
                }
                .padding()
                .foregroundStyle(Color.white)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
    }
}
