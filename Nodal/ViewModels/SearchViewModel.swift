//
//  SearchViewModel.swift
//  Nodal
//
//  Created by Максим Лозебной on 11.11.2026.
//

import SwiftUI
import Combine

// MARK: - HomeViewModel

@MainActor
final class SearchViewModel: ObservableObject {
    
    // MARK: - Published Properties
    
    @Published private(set) var trendingCoinsState: ViewState = .initial
    @Published private(set) var topListState: ViewState = .initial
    
    @Published var selectedList: TokenLists
    @Published var selectedCoinId: String?
    @Published var searchText: String = ""
    
    // MARK: - Properties
    
    private var homeService: HomeService
    private var storage = UserDefaultsService.shared
    
    private var topList: [TokenList] = []
    private var trendingCoins: [TrendingCoinItem] = []
    
    var selectedCurrency: String {
        get { storage.currentCurrency }
    }
    
    var filteredCoins: [TokenList] {
        if !searchText.isEmpty {
            return list(in: selectedList).filter {
                $0.symbol.localizedCaseInsensitiveContains(searchText) ||
                $0.name.localizedCaseInsensitiveContains(searchText)
            }
        } else {
            return list(in: selectedList)
        }
    }
    
    // MARK: - Init
    
    init(homeService: HomeService, list: TokenLists) {
        self.homeService = homeService
        self.selectedList = list
    }
    
    // MARK: - Factory Methods
    
    func fetchData() async {
        await fetchTrendingCoins()
        await fetchTopList()
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
    
    // MARK: - Private Methods
    
    private func list(in list: TokenLists) -> [TokenList] {
        switch list {
        case .top:
            return topList
            
        case .trending:
            let coins = Set(trendingCoins.map { $0.item.id })
            return topList
                .filter { coins.contains($0.id) }
        }
    }
}
