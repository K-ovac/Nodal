//
//  AuthView.swift
//  Nodal
//
//  Created by Максим Лозебной on 14.11.2026.
//

import SwiftUI

// MARK: - AuthView

struct AuthView: View {
    
    // MARK: - Properties
    
    @Environment(\.dismiss) private var dismiss
    
    @StateObject private var viewModel = AuthViewModel(
        baseAuthService: BasicAuthService(
            networkClient: NetworkClient()))
    
    private var onSubmit: () -> Void
    
    // MARK: - Init
    
    init(onSubmit: @escaping () -> Void) {
        self.onSubmit = onSubmit
    }
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            Color.background
                .ignoresSafeArea()
            
            VStack(alignment: .trailing, spacing: 16) {
                
                // MARK: - Auth State
                
                authState
                
                // MARK: - State View
                
                ScrollView {
                    switch viewModel.authState {
                    case .signIn:
                        signInFields
                            .textFieldStyle(CustomTextFieldStyle())
                            .disabled(viewModel.isSigningIn)
                    case .createProfile:
                        signUpFields
                            .textFieldStyle(CustomTextFieldStyle())
                            .disabled(viewModel.isSigningIn)
                    }
                    
                    Spacer()
                    
                    // MARK: - Sign View
                    
                    if viewModel.isSigningIn {
                        ProgressView()
                            .progressViewStyle(.circular)
                            .padding(.top, 8)
                    } else {
                        Button {
                            Task {
                                await viewModel.sign()
                                if !viewModel.hasError {
                                    onSubmit()
                                    dismiss()
                                }
                            }
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
                        .disabled(!viewModel.isFormValid)
                        .padding(.top, 8)
                    }
                }
            }
            .padding(.horizontal)
        }
        .alert(isPresented: $viewModel.hasError) {
            
            // MARK: - Alert
            
            switch viewModel.authState {
            case .signIn:
                Alert(
                    title: Text("auth.failAuthAlert.title")
                        .foregroundStyle(Color.primary)
                        .font(Font.header15),
                    message: Text("auth.failAuthAlert.message")
                        .foregroundStyle(Color.primary)
                        .font(Font.body15.bold()))
            case .createProfile:
                Alert(
                    title: Text("auth.failCreateProfileAlert.title")
                        .foregroundStyle(Color.primary)
                        .font(Font.header15),
                    message: Text("auth.failCreateProfileAlert.message")
                        .foregroundStyle(Color.primary)
                        .font(Font.body15.bold()))
            }
        }
        .toolbar {
            leadingToolBar
            trailingToolBar
        }
    }
}

// MARK: - Extension AuthView

extension AuthView {
    
    // MARK: - Toolbar Content
    
    private var leadingToolBar: some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            HStack {
                Image("nodalIcon")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 24, height: 24)
                
                VStack(alignment: .leading) {
                    Text("auth.title")
                        .foregroundStyle(Color.primary)
                        .font(Font.header15)
                    
                    Text("auth.subtitle")
                        .foregroundStyle(Color.secondary)
                        .font(Font.secondary11.bold())
                }
                .fixedSize(horizontal: true, vertical: false)
            }
            .padding(.horizontal, 8)
        }
    }
    
    private var trailingToolBar: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Button {
                dismiss()
            } label: {
                Image(systemName: "xmark")
            }
        }
    }
    
    // MARK: - Auth State Content
    
    private var authState: some View {
        HStack(spacing: -4) {
            ForEach(AuthState.allCases) { state in
                let isSelected = viewModel.authState == state
                
                Button {
                    withAnimation(.linear) {
                        viewModel.authState = state
                    }
                } label: {
                    HStack {
                        Image(systemName: state.icon)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 18)
                        Text(state.signingTitle)
                            .font(Font.body15.bold())
                    }
                    .foregroundStyle(
                        isSelected
                        ? Color.orangeNeon
                        : Color.primary)
                }
                .buttonStyle(.plain)
                .padding(.vertical, 4)
                .frame(maxWidth: .infinity)
                .background(
                    isSelected
                    ? Color.orangeNeon.opacity(0.1)
                    : Color.clear)
                .clipShape(.capsule)
            }
        }
        .cellStyle(position: .single, padding: 2)
    }
    
    // MARK: - SignIn Content
    
    private var signInFields: some View {
        VStack(alignment: .leading, spacing: 12) {
            VStack(alignment: .leading) {
                Text("auth.login.title")
                    .foregroundStyle(Color.secondary)
                    .font(Font.secondary11.bold())
                TextField("auth.login.textField.title", text: $viewModel.email)
                    .textInputAutocapitalization(.none)
                    .keyboardType(.emailAddress)
                    .autocorrectionDisabled(true)
                    .font(Font.body15.bold())
                
            }
            
            VStack(alignment: .leading) {
                Text("auth.password.title")
                    .foregroundStyle(Color.secondary)
                    .font(Font.secondary11.bold())
                SecureField("auth.password.textField.title", text: $viewModel.password)
                    .font(Font.body15.bold())
            }
        }
    }
    
    // MARK: - SignUp Content
    
    private var signUpFields: some View {
        VStack(alignment: .leading, spacing: 12) {
            VStack(alignment: .leading) {
                Text("auth.username.title")
                    .foregroundStyle(Color.secondary)
                    .font(Font.secondary11.bold())
                TextField("auth.username.textField.title", text: $viewModel.username)
                    .textInputAutocapitalization(.none)
                    .keyboardType(.default)
                    .autocorrectionDisabled(true)
                    .font(Font.body15.bold())
            }
            
            signInFields
            
            if !viewModel.isValidPassword {
                passwordNotation(password: viewModel.password)
            }
            
            // MARK: - Select Avatar Section
            
            VStack(alignment: .leading) {
                Text("auth.avatar.title")
                    .foregroundStyle(Color.secondary)
                    .font(Font.body15.bold())
                LazyVGrid(columns: Metrics
                    .columns(count: 4), spacing: 4) {
                        ForEach(Avatars.title, id: \.self) { avatar in
                            let isSelected = viewModel.avatarUrl == avatar
                            
                            Image(avatar)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 52, height: 52)
                                .selectItem(isSelected: isSelected,
                                            color: Color.enclaveSafe)
                            
                                .onTapGesture {
                                    viewModel.avatarUrl = avatar
                                }
                        }
                    }
                    .padding(.top, -8)
                    .padding(.horizontal, -8)
            }
            .padding(.top, 8)
        }
    }
    
    // MARK: - Password Notation
    
    private func passwordNotation(password: String) -> some View {
        VStack(alignment: .leading) {
            ForEach(ValidPassword.allCases) { rule in
                HStack {
                    Text(rule.title)
                        .foregroundStyle(
                            rule.regex(password: password)
                            ? Color.enclaveSafe
                            : Color.drainerAlert)
                        .font(Font.body13.bold())
                }
            }
        }
    }
}

// MARK: - ValidPassword

private enum ValidPassword: String, CaseIterable, Identifiable {
    case length, letters, digits, symbols
    
    var id: String { rawValue }
    
    var title: LocalizedStringKey {
        switch self {
        case .length:
            "auth.validPassword.length.title"
        case .letters:
            "auth.validPassword.letters.title"
        case .digits:
            "auth.validPassword.digits.title"
        case .symbols:
            "auth.validPassword.symbols.title"
        }
    }
    
    func regex(password: String) -> Bool {
        switch self {
            
        case .length:
            password.count >= 8
        case .letters:
            password.contains(/[A-Z]/)
        case .digits:
            password.contains(/\d/)
        case .symbols:
            password.contains(/[@$!%*?&=+_]/)
        }
    }
}
