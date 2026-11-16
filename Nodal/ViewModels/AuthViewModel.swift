//
//  AuthViewModel.swift
//  Nodal
//
//  Created by Максим Лозебной on 14.11.2026.
//

import SwiftUI
import Combine

// MARK: - AuthViewModel

@MainActor
final class AuthViewModel: ObservableObject {
    
    // MARK: - Published
    
    @Published var username: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var avatarUrl: String = ""
    
    @Published var hasError: Bool = false
    @Published var isSigningIn: Bool = false
    
    @Published var authState: AuthState = .signIn
    
    // MARK: - Properties
    
    var isFormValid: Bool {
        switch authState {
        case .signIn:
            return isValidEmail(email) && !password.isEmpty
        case .createProfile:
            return isValidUsername(username) && isValidEmail(email) && isValidPassword(password) && isValidAvatarUrl(avatarUrl)
        }
    }
    
    private var baseAuthService: BasicAuthService
    
    // MARK: - Init
    
    init(baseAuthService: BasicAuthService) {
        self.baseAuthService = baseAuthService
    }
    
    // Sign In & Up, Logout methods
    
    func sign() async {
        guard isFormValid else { return }
        
        isSigningIn = true
        hasError = false
        
        defer { isSigningIn = false}
        
        do {
            switch authState {
            case .signIn:
                _ = try await baseAuthService.signIn(dto: convert())
            case .createProfile:
                _ = try await baseAuthService.signUp(dto: convert())
            }
        } catch {
            debugPrint("auth error: \(error)")
            hasError = true
        }
    }
    
    func logout() async {
        baseAuthService.signOut()
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = /^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,64}$/
        
        return email.wholeMatch(of: emailRegex) != nil
    }
    
    private func isValidPassword(_ password: String) -> Bool {
        let passwordRegex = /^(?=.*[A-Z])(?=.*\d)[A-Za-z\d@$!%*?&]{8,}$/
        
        return (password.wholeMatch(of: passwordRegex) != nil) && !password.isEmpty
    }
    
    private func isValidAvatarUrl(_ avatar: String) -> Bool {
        !avatarUrl.isEmpty
    }
    
    private func isValidUsername(_ username: String) -> Bool {
        return !username.isEmpty && (username.count >= 6)
    }
    
    private func convert() -> SignIn {
        .init(
            email: email,
            password: password)
    }
    
    private func convert() -> SignUp {
        .init(
            username: username,
            email: email,
            password: password,
            avatarUrl: avatarUrl)
    }
}
