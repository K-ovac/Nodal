//
//  CoinDetailsService.swift
//  C-Tab
//
//  Created by Максим Лозебной on 12.09.2026.
//

import Foundation

// MARK: - CoinDetailsServiceData

protocol CoinDetailsServiceData {
    func fetchCoinDetails(for id: String) async throws -> CoinMetadata
}

// MARK: - CoinDetailsService

final class CoinDetailsService: CoinDetailsServiceData {
    
    // MARK: - Properties
    
    private let networkClient: NetworkClient
    
    // MARK: - Init
    
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    // MARK: - Fetch Coin Details
    
    func fetchCoinDetails(for id: String) async throws -> CoinMetadata {
        let request = CoinDetailsRequest(id: id)
        
        guard let url = request.endpoint else {
            throw NetworkError.urlSessionError
        }
        
        let response = try await networkClient.parse(
            url: url,
            type: CoinMetadata.self
        )
        
        return response
    }
}
