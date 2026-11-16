//
//  NetworkRequest.swift
//  C-Tab
//
//  Created by Максим Лозебной on 25.04.2026.
//

import Foundation

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
    
    var value: String { rawValue }
}

protocol NetworkRequest {
    var endpoint: URL? { get }
    var httpMethod: HttpMethod { get }
    var body: Data? { get }
    var headers: [String:String] { get }
}

extension NetworkRequest {
    var httpMethod: HttpMethod { .get }
    var body: Data? { nil }
    var headers: [String:String] { [:] }
}
