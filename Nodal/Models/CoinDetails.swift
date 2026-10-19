//
//  CoinDetails.swift
//  C-Tab
//
//  Created by Максим Лозебной on 13.09.2026.
//

import SwiftUI

// MARK: - Coin Statistics

enum CoinStatistics: String, CaseIterable, Identifiable {
    case high24h, low24h, marketCap, circulatingSupply, fullyDilutedValuation, totalSupply, totalVolume, maxSupply
    
    var id: String { rawValue }
    
    // MARK: - Stat Title
    
    var title: LocalizedStringKey {
        switch self {
        case .high24h:
            "coinDetails.stat.high24h"
        case .low24h:
            "coinDetails.stat.low24h"
        case .marketCap:
            "coinDetails.stat.marketCap"
        case .circulatingSupply:
            "coinDetails.stat.circulatingSupply"
        case .fullyDilutedValuation:
            "coinDetails.stat.fullyDilutedValuation"
        case .totalSupply:
            "coinDetails.stat.totalSupply"
        case .totalVolume:
            "coinDetails.stat.tradingVolume"
        case .maxSupply:
            "coinDetails.stat.maxSupply"
        }
    }
    
    // MARK: - Stat Description
    
    var description: LocalizedStringKey {
        switch self {
        case .high24h: 
            return "coinDetails.stat.description.high24h"
        case .low24h:
            return "coinDetails.stat.description.low24h"
        case .marketCap:
            return "coinDetails.stat.description.marketCap"
        case .circulatingSupply:
            return "coinDetails.stat.description.circulatingSupply"
        case .fullyDilutedValuation:
            return "coinDetails.stat.description.fullyDilutedValuation"
        case .totalSupply:
            return "coinDetails.stat.description.totalSupply"
        case .totalVolume:
            return "coinDetails.stat.description.totalVolume"
        case .maxSupply:
            return "coinDetails.stat.description.maxSupply"
        }
    }
}
