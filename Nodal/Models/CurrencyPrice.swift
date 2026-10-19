//
//  Currency.swift
//  C-Tab
//
//  Created by Максим Лозебной on 15.09.2026.
//

// MARK: - Current Price

enum CurrencyPrice: String, CaseIterable, Identifiable {
    case btc = "BTC"
    case usd = "USD"
    case rub = "RUB"
    case eur = "EUR"
    case cny = "CNY"
    
    var id: String { self.rawValue }
    
    // MARK: - Currency Title
    
    var title: String {
        switch self {
        case .usd: return "US Dollar"
        case .rub: return "Russian Ruble"
        case .eur: return "Euro"
        case .cny: return "Chinese Yuan Renminbi"
        case .btc: return "BTC"
        }
    }
    
    // MARK: - Currency Icon
    
    var icon: String {
        switch self {
        case .usd: return "dollarsign"
        case .rub: return "rublesign"
        case .eur: return "eurosign"
        case .cny: return "chineseyuanrenminbisign"
        case .btc: return "bitcoinsign"
        }
    }
}
