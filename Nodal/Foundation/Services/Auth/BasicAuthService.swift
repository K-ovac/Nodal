//
//  BaseAuthService.swift
//  Nodal
//
//  Created by Максим Лозебной on 15.11.2026.
//

import Foundation

enum AuthServiceError: Error {
    case invalidRequest
}

final class BasicAuthService: AuthServiceProtocol {
    
    private let networkClient: NetworkClient
    private var tokenStorage: AuthTokenStorageProtocol
    
    init(
        networkClient: NetworkClient = NetworkClient(),
        tokenStorage: AuthTokenStorageProtocol = AuthTokenStorage.shared
    ) {
        self.networkClient = networkClient
        self.tokenStorage = tokenStorage
    }
    
    func signIn(dto: SignIn) async throws -> User {
        guard let token = makeBasicAuthToken(email: dto.email, password: dto.password) else {
            throw AuthServiceError.invalidRequest
        }
        
        let request = UserRequest(token: token)
        let user = try await networkClient.execute(request, responseType: User.self)
        
        tokenStorage.token = token
        
        return user
    }
    
    func signUp(dto: SignUp) async throws -> User {
        let request = SignUpRequest(dto: dto)
        let user = try await networkClient.execute(request, responseType: User.self)
        
        if let token = makeBasicAuthToken(email: dto.email, password: dto.password) {
            tokenStorage.token = token
        }
        
        return user
    }
    
    func signOut() {
        tokenStorage.clearToken()
    }
    
    func fetchUser() async throws -> User {
        guard let token = tokenStorage.token else {
            throw AuthServiceError.invalidRequest
        }
        let request = UserRequest(token: token)
        
        return try await networkClient.execute(request, responseType: User.self)
    }
    
    private func makeBasicAuthToken(email: String, password: String) -> String? {
        let credentials = email + ":" + password
        guard let data = credentials.data(using: .utf8) else { return nil }
        
        return "Basic " + data.base64EncodedString()
    }
}
