//
//  HomeViewModel.swift
//  C-Tab
//
//  Created by Максим Лозебной on 23.04.2026.
//

import SwiftUI
import Combine

// MARK: - HomeViewModel

@MainActor
final class HomeViewModel: ObservableObject {
    
    // MARK: - Published Properties
    
    @Published private(set) var topList: [TokenList] = []
    @Published private(set) var trendingCoins: [TrendingCoinItem] = []
    @Published private(set) var globalMetrics: GlobalMetrics?
    
    @Published var globalMetricsState: ViewState = .initial
    @Published var trendingCoinsState: ViewState = .initial
    @Published var topListState: ViewState = .initial
    
    @Published var selectedCoinId: String?
    @Published var selectedList: TokenLists?
    
    // MARK: - Properties
    
    private var homeService: HomeService
    private var storage = UserDefaultsService.shared
    
    var selectedCurrency: String {
        get { storage.currentCurrency }
    }
    
    // MARK: - Init
    
    init(homeService: HomeService) {
        self.homeService = homeService
    }
    
    // MARK: - Factory Methods
    
    func fetchData() async {
        await fetchGlobalMetrics()
        await fetchTrendingCoins()
        await fetchTopList()
    }
    
    func fetchGlobalMetrics() async {
        globalMetricsState = .loading
        
        do {
            globalMetrics = try await homeService.fetchGlobalMetrics()
            globalMetricsState = .loaded
        } catch {
            globalMetricsState = .failure(error)
            print(error)
        }
    }
    
    func fetchTrendingCoins() async {
        trendingCoinsState = .loading
        
        do {
            trendingCoins = try await homeService.fetchTrendingCoins(
                currency: selectedCurrency
            )
            trendingCoinsState = .loaded
        } catch {
            trendingCoinsState = .failure(error)
            print(error)
        }
    }
    
    func fetchTopList() async {
        topListState = .loading
        
        do {
            topList = try await homeService.fetchTopList(
                currency: selectedCurrency
            )
            topListState = .loaded
        } catch {
            topListState = .failure(error)
            print(error)
        }
    }
    
    // MARK: - Factory Methods
    
    func trendingCoinsRows() -> Int {
        6
    }
    
    func topCoinsRows() -> Int {
        10
    }
}
