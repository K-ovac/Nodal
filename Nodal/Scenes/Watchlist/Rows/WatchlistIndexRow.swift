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
                Color.linearGradient
                
                VStack(alignment: .leading) {
                    HStack {
                        Image(systemName: "star.hexagon")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 14, height: 14)
                        
                        Text("watchlist.index.title")
                            .font(Font.secondary14.bold())
                        
                        Spacer()
                        
                        Text("watchlist.index.nodeStatus.title")
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
                            //percentage 24h
                            Text("﹪")
                                .font(Font.header20.bold())
                            
                            HStack {
                                Text("watchlist.index.topGainer.title")
                                    .font(Font.secondary14)
                                
                                // TODO: - Top Gainer & Percentage 24h
                                Text("📈")
                                    .font(Font.secondary14.bold())
                            }
                        }
                        
                        Spacer()
                        
                        VStack(alignment: .trailing) {
                            Text("watchlist.index.trackedCoins.title")
                                .font(Font.secondary14)
                            Text("\(index.trackedCoins) watchlist.index.trackedCoins.count")
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
