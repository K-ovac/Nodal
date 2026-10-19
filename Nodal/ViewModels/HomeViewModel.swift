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
    
    @Published var sortDirection: SortDirection = .descending
    @Published var currentSortType: SortTypes? = nil
    @Published var rankCrypto: RankCrypto = .top100
    @Published var priceChange: PriceChange = .day
    @Published var selectedCoinId: String?
    @Published var topListPresented = false
    @Published var profilePresented = false
    @Published var globalMetricsState: ViewState = .initial
    @Published var trendingCoinsState: ViewState = .initial
    @Published var topListState: ViewState = .initial
    
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
    
    func trendingCoinsColumns() -> [GridItem] {
        [
            GridItem(.flexible()),
            GridItem(.flexible())
        ]
    }
    
    func trendingCoinsRows() -> Int {
        4
    }
    
    func topCoinsRows() -> Int {
        10
    }
    
    func topListRows() -> Int {
        switch rankCrypto {
        case .top20:
            return 20
        case .top100:
            return 100
        case .top200:
            return 200
        case .allTokens:
            return topList.count
        }
    }
    
    // MARK: - Sort Methods
    
    func toggleSort(by type: SortTypes) {
        if currentSortType == type {
            sortDirection.toggle()
        } else {
            currentSortType = type
            sortDirection = .descending
        }
        
        switch type {
        case .marketCap:
            topList.sort {
                sortDirection == .descending ?
                ($0.marketCap) > ($1.marketCap)
                : ($0.marketCap) < ($1.marketCap)
            }
        case .price:
            topList.sort {
                sortDirection == .descending ?
                ($0.currentPrice) > ($1.currentPrice)
                : ($0.currentPrice) < ($1.currentPrice)
            }
        case .percentChange:
            topList.sort {
                sortDirection == .descending ?
                ($0.priceChangePercentage24h ?? 0) > ($1.priceChangePercentage24h ?? 0)
                : ($0.priceChangePercentage24h ?? 0) < ($1.priceChangePercentage24h ?? 0)
            }
        }
    }
}
