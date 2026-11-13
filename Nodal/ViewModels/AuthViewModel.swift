//
//  AuthViewModel.swift
//  Nodal
//
//  Created by Максим Лозебной on 14.11.2026.
//

import SwiftUI
import Combine

final class AuthViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var hasError: Bool = false
    @Published var isSigningIn: Bool = false
    
    @Published var authState: AuthState = .signIn
    
    var canSignIn: Bool {
        !email.isEmpty && !password.isEmpty
    }
    
    
    func sign() {
        
    }
}
