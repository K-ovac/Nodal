//
//  AuthView.swift
//  Nodal
//
//  Created by Максим Лозебной on 14.11.2026.
//

import SwiftUI

enum AuthState: String, CaseIterable, Identifiable {
    case signIn, signUp
    
    var id: String { rawValue }
    
    var  signingTitle: LocalizedStringKey {
        switch self {
        case .signIn: return "auth.signInButton.title"
        case .signUp: return "auth.signUpButton.title"
        }
    }
    
    var signState: LocalizedStringKey {
        switch self {
        case .signIn: return "auth.signUpButton.title"
        case .signUp: return "auth.signInButton.title"
        }
    }
}

struct AuthView: View {
    
    @StateObject private var viewModel = AuthViewModel()
        
    var body: some View {
        VStack(alignment: .trailing) {
            VStack(alignment: .leading) {
                Text("auth.login.title")
                    .foregroundStyle(Color.secondary)
                    .font(Font.secondary11.bold())
                TextField("auth.login.textField.title", text: $viewModel.email)
                    .textInputAutocapitalization(.none)
                    .keyboardType(.emailAddress)
                    .autocorrectionDisabled(true)
                
                Text("auth.password.title")
                    .foregroundStyle(Color.secondary)
                    .font(Font.secondary11.bold())
                SecureField("auth.password.textField.title", text: $viewModel.password)
            }
            .textFieldStyle(.roundedBorder)
            .disabled(viewModel.isSigningIn)
            
            Button {
                switch viewModel.authState {
                case .signIn:
                    return viewModel.authState = .signUp
                    
                case .signUp:
                    return viewModel.authState = .signIn
                }
            } label: {
                Text(viewModel.authState.signState)
                    .foregroundStyle(Color.cautionPermit)
                    .font(Font.body15.bold())
            }
            
            if viewModel.isSigningIn {
                ProgressView()
                    .progressViewStyle(.circular)
            } else {
                Button {
                    viewModel.sign()
                } label: {
                    Text(viewModel.authState.signingTitle)
                        .foregroundStyle(Color.primary)
                        .font(Font.body15.bold())
                        .frame(maxWidth: .infinity)
                }
                .frame(maxWidth: .infinity)
                .padding(8)
                .overlay(
                    Metrics.shapeCapsule
                        .strokeBorder(Color.linearGradient, lineWidth: 1.25))
                .disabled(!viewModel.canSignIn)
                .padding(.top)
            }
        }
        .padding()
    }
}

#Preview {
    AuthView()
}
