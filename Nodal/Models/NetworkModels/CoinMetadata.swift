//
//  TokenMetadata.swift
//  C-Tab
//
//  Created by Максим Лозебной on 25.04.2026.
//

// MARK: - CoinMetadata

struct CoinMetadata: Codable, Identifiable {
    let id: String
    let name: String
    let symbol: String
    let description: CoinDescription
    let image: CoinImage
    let marketData: CoinMarketData
    let links: CoinLinks
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case symbol
        case description
        case image
        case marketData = "market_data"
        case links
    }
}

// MARK: - Coin Description Language

struct CoinDescription: Codable {
    let en: String
    let ru: String
    let zh: String
}

// MARK: - Coin Images

struct CoinImage: Codable {
    let small: String
}

// MARK: - CoinMarketData

struct CoinMarketData: Codable {
    let currentPrice: CoinCurrentPrice
    let marketCapRank: Int
    let priceChangePercentage24h: Double?
    let fullyDilutedValuation: CoinCurrentPrice
    let marketCap: CoinCurrentPrice
    let totalVolume: CoinCurrentPrice
    let circulatingSupply: Double
    let totalSupply: Double
    let maxSupply: Int?
    let high24h: CoinCurrentPrice
    let low24h: CoinCurrentPrice
    
    enum CodingKeys: String, CodingKey {
        case currentPrice = "current_price"
        case marketCapRank = "market_cap_rank"
        case priceChangePercentage24h = "price_change_percentage_24h"
        case fullyDilutedValuation = "fully_diluted_valuation"
        case marketCap = "market_cap"
        case totalVolume = "total_volume"
        case circulatingSupply = "circulating_supply"
        case totalSupply = "total_supply"
        case maxSupply = "max_supply"
        case high24h = "high_24h"
        case low24h = "low_24h"
    }
}

// MARK: - Coin Current Price

struct CoinCurrentPrice: Codable {
    let btc: Double
    let usd: Double
    let eur: Double
    let rub: Double
    let cny: Double
}

// MARK: - Coin Links

struct CoinLinks: Codable {
    let homepage: [String]
    let whitepaper: String
    let reposUrl: CoinReposUrl
    let twitterScreenName: String
    
    enum CodingKeys: String, CodingKey {
        case homepage
        case whitepaper
        case reposUrl = "repos_url"
        case twitterScreenName = "twitter_screen_name"
    }
}

// MARK: - Coin Repos Url

struct CoinReposUrl: Codable {
    let github: [String]
}

// MARK: - Extension Coin Current Price

extension CoinCurrentPrice {
    
    // MARK: - Get Currency Method
    
    func currency(for currency: String) -> Double {
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
