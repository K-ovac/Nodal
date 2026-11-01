//
//  CoinDetails.swift
//  C-Tab
//
//  Created by Максим Лозебной on 13.09.2026.
//

import SwiftUI

// MARK: - Coin Statistics

enum CoinStatistics: String, CaseIterable, Identifiable {
    case marketCap, fullyDilutedValuation, totalVolume, ath
    
    var id: String { rawValue }
    
    // MARK: - Stat Title
    
    var title: LocalizedStringKey {
        switch self {
        
        case .marketCap:
            "coinDetails.stat.marketCap.title"
        
        case .fullyDilutedValuation:
            "coinDetails.stat.fdv.title"
            
        case .totalVolume:
            "coinDetails.stat.totalVolume.title"
        
        case .ath:
            "coinDetails.stat.ath.title"
        }
    }
}
