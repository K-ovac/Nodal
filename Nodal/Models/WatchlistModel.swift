//
//  Watchlist.swift
//  Nodal
//
//  Created by Максим Лозебной on 28.10.2026.
//

struct WatchlistModel {
    let trackedCoins: Int
    let priceChangePercentage: Double
    let topGainer: String
    let topGainerPercentage: Double
    let coins: [TokenList]
}
