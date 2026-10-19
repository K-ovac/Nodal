//
//  CoinDetailsRequest.swift
//  C-Tab
//
//  Created by Максим Лозебной on 12.09.2026.
//

import Foundation

struct CoinDetailsRequest: NetworkRequest {
    var endpoint: URL? {
        URL(string: RequestConstants.baseURL + "coins/" + id)
    }
    
    var httpMethod: HttpMethod { .get }
    var id: String
}
