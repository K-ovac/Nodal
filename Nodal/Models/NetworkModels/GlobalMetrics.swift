//
//  QuotesLatest.swift
//  C-Tab
//
//  Created by Максим Лозебной on 25.04.2026.
//

// MARK: - Global Metrics

struct GlobalMetrics: Codable {
    let marketCapPercentage: MarketCapPercentage
    let marketCapChangePercentage24hUsd: Double?
    let totalMarketCap: MarketCapValue
    let totalVolume: MarketCapValue
    
    enum CodingKeys: String, CodingKey {
        case marketCapPercentage = "market_cap_percentage"
        case marketCapChangePercentage24hUsd = "market_cap_change_percentage_24h_usd"
        case totalMarketCap = "total_market_cap"
        case totalVolume = "total_volume"
    }
}

// MARK: - Market Cap Percentage

struct MarketCapPercentage: Codable {
    let btc: Double?
}

// MARK: - Global Metrics Data

struct GlobalMetricsData: Codable {
    let data: GlobalMetrics
}

struct MarketCapValue: Codable {
    let usd: Double?
}
