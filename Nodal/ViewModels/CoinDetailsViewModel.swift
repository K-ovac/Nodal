//
//  CoinDetailsViewModel.swift
//  C-Tab
//
//  Created by Максим Лозебной on 12.09.2026.
//

import Foundation
import Combine

// MARK: - CoinDetailsViewModel

@MainActor
final class CoinDetailsViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published private(set) var coinDetails: CoinMetadata?
    @Published private(set) var coinDetailsState: ViewState = .initial
    
    private var coinDetailsServise: CoinDetailsService
    private var storage = UserDefaultsService.shared
    private let coinId: String
    
    var selectedCurrency: String {
        get { storage.currentCurrency }
    }
    
    // MARK: - Init
    
    init(coinDetailsServise: CoinDetailsService, coinId: String) {
        self.coinDetailsServise = coinDetailsServise
        self.coinId = coinId
    }
    
    // MARK: - Factory Methods
    
    func fetchCoinDetails() async {
        coinDetailsState = .loading
        
        do {
            coinDetails = try await coinDetailsServise.fetchCoinDetails(for: coinId)
            coinDetailsState = .loaded
        } catch {
            coinDetailsState = .failure(error)
        }
    }
    
    func descriptionLineLimit(isExpanded: Bool) -> Int? {
        isExpanded ? nil : 3
    }
}
