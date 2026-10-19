//
//  RankCrypto.swift
//  C-Tab
//
//  Created by Максим Лозебной on 11.06.2026.
//

enum RankCrypto: String, CaseIterable, Identifiable {
    case top20 = "Top 20"
    case top100 = "Top 100"
    case top200 = "Top 200"
    case allTokens = "All Tokens"
    
    var id: String { self.rawValue }
}

enum PriceChange: String, CaseIterable, Identifiable {
    case hour = "1 Hour"
    case day = "24 Hours"
    case month = "1 Month"
    
    var id: String { self.rawValue }
}
