//
//  CoinDetails.swift
//  C-Tab
//
//  Created by Максим Лозебной on 13.09.2026.
//

import SwiftUI

// MARK: - Coin Statistics

enum CoinStatistics: String, CaseIterable, Identifiable {
    case marketCap, circulatingSupply, fullyDilutedValuation, totalVolume
    
    var id: String { rawValue }
    
    // MARK: - Stat Title
    
    var title: LocalizedStringKey {
        switch self {
        case .marketCap:
            "coinDetails.stat.marketCap"
        case .circulatingSupply:
            "coinDetails.stat.circulatingSupply"
        case .fullyDilutedValuation:
            "coinDetails.stat.fullyDilutedValuation"
        case .totalVolume:
            "coinDetails.stat.tradingVolume"
        }
    }
    
    // MARK: - Stat Description
    
    var description: LocalizedStringKey {
        switch self {
        case .marketCap:
            return "coinDetails.stat.description.marketCap"
        case .circulatingSupply:
            return "coinDetails.stat.description.circulatingSupply"
        case .fullyDilutedValuation:
            return "coinDetails.stat.description.fullyDilutedValuation"
        case .totalVolume:
            return "coinDetails.stat.description.totalVolume"
        }
    }
    
    var subText: LocalizedStringKey {
        switch self {
            
        case .marketCap:
            return "Market Dominance:"
        case .circulatingSupply:
            return "from ATH"
        case .fullyDilutedValuation:
            return "MCap/FDV:"
        case .totalVolume:
            return "Vol/MCap:"
        }
    }
}
