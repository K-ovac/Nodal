//
//  NetworkClient.swift
//  C-Tab
//
//  Created by Максим Лозебной on 21.04.2026.
//

import Foundation

// MARK: - NetworkError

enum NetworkError: Error {
    case httpStatusCode(Int)
    case urlRequestError(Error)
    case urlSessionError
    case decodeError(Error)
}

// MARK: - NetworkRouting

protocol NetworkRouting {
    func fetchData(url: URL, method: String, headers: [String: String]) async throws -> Data
}

// MARK: - NetworkClient

struct NetworkClient: NetworkRouting {
    
    // MARK: - Properties
    
    private let session: URLSession
    private let decoder: JSONDecoder
    private let encoder: JSONEncoder
    
    private static let codeRange = 200..<300
    
    // MARK: - Init
    
    init(
        session: URLSession = URLSession.shared,
        decoder: JSONDecoder = JSONDecoder(),
        encoder: JSONEncoder = JSONEncoder()
    ) {
        self.session = session
        //decoder.keyDecodingStrategy = .convertFromSnakeCase
        self.decoder = decoder
        self.encoder = encoder
    }
    
    // MARK: - Factory Methods
    
    func fetchData(
        url: URL,
        method: String,
        headers: [String: String] = [:]
    ) async throws -> Data {
        let request = request(url: url, method: method, headers: headers)
        let (data, response) = try await session.data(for: request)
        
        guard let response = response as? HTTPURLResponse else {
            throw NetworkError.urlSessionError
        }
        
        guard NetworkClient.codeRange ~= response.statusCode else {
            throw NetworkError.httpStatusCode(response.statusCode)
        }
        
        return data
    }
    
    func parse<T: Decodable>(
        url: URL,
        method: String,
        type: T.Type
    ) async throws -> T {
        let data = try await fetchData(url: url, method: method)
        
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw NetworkError.decodeError(error)
        }
    }
    
    func execute<T: Decodable>(_ req: NetworkRequest, responseType: T.Type) async throws -> T {
        guard let urlRequest = request(from: req) else {
            throw NetworkError.urlSessionError
        }
        
        let (data, response) = try await session.data(for: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.urlSessionError
        }
        
        guard NetworkClient.codeRange ~= httpResponse.statusCode else {
            throw NetworkError.httpStatusCode(httpResponse.statusCode)
        }
        
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw NetworkError.decodeError(error)
        }
    }
    
    // MARK: - Private Methods
    
    private func request(
        url: URL,
        method: String,
        headers: [String: String] = [:]
    ) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method
        
        let allHeaders = headers.merging(
            [AppEnviropment.apiHeader: AppEnviropment.apiKey]
        ) { _, new in new }
        
        allHeaders.forEach { key, value in
            request.addValue(value, forHTTPHeaderField: key)
        }
        
        return request
    }
    
    private func request(from req: NetworkRequest) -> URLRequest? {
        guard let url = req.endpoint else { return nil }
        
        var request = URLRequest(url: url)
        request.httpMethod = req.httpMethod.value
        
        var allHeaders = req.headers.merging(
            [AppEnviropment.apiHeader: AppEnviropment.apiKey]
        ) { _, new in new }
        
        if let body = req.body {
            request.httpBody = body
            allHeaders["Content-Type"] = "application/json"
        }
        
        allHeaders.forEach { key, value in
            request.addValue(value, forHTTPHeaderField: key)
        }
        
        return request
    }
}
