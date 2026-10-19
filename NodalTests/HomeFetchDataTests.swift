//
//  HomeFetchDataTests.swift
//  C-TabTests
//
//  Created by Максим Лозебной on 23.09.2026.
//

import XCTest
@testable import C_Tab

@MainActor
final class HomeFetchDataTests: XCTestCase {
    private let currency = "usd"
    
    func testFetchTopList() async throws {
        
        let networkClient = NetworkClient()
        let service = HomeService(networkClient: networkClient)
                
        let topList = try await service.fetchTopList(currency: currency)
        
        XCTAssertFalse(topList.isEmpty)
    }
    
    func testFetchTrendingCoins() async throws {
        let networkClient = NetworkClient()
        let service = HomeService(networkClient: networkClient)
        
        let trendingCoins = try await service.fetchTrendingCoins(currency: currency)
        
        XCTAssertFalse(trendingCoins.isEmpty)
    }
    
    func testfetchGlobalMetrics() async throws {
        let networkClient = NetworkClient()
        let service = HomeService(networkClient: networkClient)
        
        let globalMetrics = try await service.fetchGlobalMetrics()
        
        XCTAssertNotNil(globalMetrics)
    }
}
