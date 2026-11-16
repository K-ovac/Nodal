//
//  BasicAuthTokenStorage.swift
//  Nodal
//
//  Created by Максим Лозебной on 15.11.2026.
//

import SwiftKeychainWrapper

protocol AuthTokenStorageProtocol {
    var token: String? { get set }
    var hasToken: Bool { get }
    func clearToken()
}

final class AuthTokenStorage: AuthTokenStorageProtocol {
    
    static let shared = AuthTokenStorage()
    
    private enum Keys {
        static let token = "BasicAuthToken"
    }
    
    private init() {
        debugPrint("Token Initialized")
    }
    
    var token: String? {
        get {
            if let token = KeychainWrapper.standard.string(forKey: Keys.token) {
                return token
            } else {
                return nil
            }
        }
        
        set {
            if let token = newValue, token != KeychainWrapper.standard.string(forKey: Keys.token) {
                KeychainWrapper.standard.set(token, forKey: Keys.token)
            } else if newValue == nil {
                KeychainWrapper.standard.removeObject(forKey: Keys.token)
            }
        }
    }
    
    var hasToken: Bool { token != nil }
    
    func clearToken() {
        token = nil
    }
    
    private func logKeychainStatus() {
        let status = token != nil
        ? "The token exist"
        : "The token does not exist"
        
        debugPrint("Keychain Status: \(status)")
    }
}
