//
//  CoinDetailsRequest.swift
//  C-Tab
//
//  Created by Максим Лозебной on 12.09.2026.
//

import Foundation

struct CoinDetailsRequest: NetworkRequest {
    var endpoint: URL? {
        URL(string: AppEnviropment.baseURL + "api/market/coin/" + id)
    }
    
    var httpMethod: HttpMethod { .get }
    var id: String
}
