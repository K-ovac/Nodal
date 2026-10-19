//
//  NetworkRequest.swift
//  C-Tab
//
//  Created by Максим Лозебной on 25.04.2026.
//

import Foundation

enum HttpMethod: String {
    case get = "GET"
    
    var value: String { rawValue }
}

protocol NetworkRequest {
    var endpoint: URL? { get }
    var httpMethod: HttpMethod { get }
}
