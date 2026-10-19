//
//  TrendingCoins.swift
//  C-Tab
//
//  Created by Максим Лозебной on 17.09.2026.
//

// MARK: - Trending Coins

struct TrendingCoin: Codable, Hashable {
    let id: String
    let symbol: String
    let small: String
    let data: TrendingCoinData
}

// MARK: - Trending Coins Data

struct TrendingCoinData: Codable, Hashable {
    let price: Double
    let priceChangePercentage24h: TrendingCoinPriceChangePercentage24h
    
    enum CodingKeys: String, CodingKey {
        case price
        case priceChangePercentage24h = "price_change_percentage_24h"
    }
}

// MARK: - Trending Coin Price Change Percentage 24h

struct TrendingCoinPriceChangePercentage24h: Codable, Hashable {
    let btc: Double?
    let usd: Double?
    let eur: Double?
    let rub: Double?
    let cny: Double?
}

// MARK: - Trending Coin Item

struct TrendingCoinItem: Codable, Hashable {
    let item: TrendingCoin
}

// MARK: - Trending Coin Provider

struct TrendingCoinsProvider: Codable, Hashable {
    let coins: [TrendingCoinItem]
}

// MARK: - Extension Trending Coin Price Change Percentage 24h

extension TrendingCoinPriceChangePercentage24h {
    func currency(for currency: String) -> Double? {
        let currencyPrice = CurrencyPrice(rawValue: currency)
        switch currencyPrice {
        case .usd:
            return usd
        case .rub:
            return rub
        case .eur:
            return eur
        case .cny:
            return cny
        case .btc:
            return btc
        case nil:
            return usd
        }
    }
}
