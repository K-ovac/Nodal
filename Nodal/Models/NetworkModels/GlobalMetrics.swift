//
//  QuotesLatest.swift
//  C-Tab
//
//  Created by Максим Лозебной on 25.04.2026.
//

// MARK: - Global Metrics

struct GlobalMetrics: Codable {
    let activeCryptocurrencies: Int
    let marketCapPercentage: MarketCapPercentage
    let marketCapChangePercentage24hUsd: Double?
    
    enum CodingKeys: String, CodingKey {
        case activeCryptocurrencies = "active_cryptocurrencies"
        case marketCapPercentage = "market_cap_percentage"
        case marketCapChangePercentage24hUsd = "market_cap_change_percentage_24h_usd"
    }
}

// MARK: - Market Cap Percentage

struct MarketCapPercentage: Codable {
    let btc: Double?
    let eth: Double?
    let usdt: Double?
}

// MARK: - Global Metrics Data

struct GlobalMetricsData: Codable {
    let data: GlobalMetrics
}
