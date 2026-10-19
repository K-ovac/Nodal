//
//  CoinDetailsFetchTests.swift
//  C-TabTests
//
//  Created by Максим Лозебной on 23.09.2026.
//

import XCTest
@testable import C_Tab

@MainActor
final class CoinDetailsFetchTests: XCTestCase {
    private let coinId = "the-open-network"

    func testFetchCoinDetails() async throws {
        let networkClient = NetworkClient()
        let service = CoinDetailsService(networkClient: networkClient)
        
        let coinDetails = try await service.fetchCoinDetails(for: coinId)
        
        XCTAssertNotNil(coinDetails)
    }
}
