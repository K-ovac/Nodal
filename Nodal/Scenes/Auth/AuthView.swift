//
//  AuthView.swift
//  Nodal
//
//  Created by Максим Лозебной on 14.11.2026.
//

import SwiftUI

struct AuthView: View {
    @Environment(\.dismiss) private var dismiss
    
    @StateObject private var viewModel = AuthViewModel()
    
    var body: some View {
        ZStack {
            Color.background
                .ignoresSafeArea()
            
            VStack(alignment: .trailing, spacing: 16) {
                authState
                
                switch viewModel.authState {
                case .signIn:
                    signInFields
                        .textFieldStyle(CustomTextFieldStyle())
                        .disabled(viewModel.isSigningIn)
                case .createProfile:
                    signUpFields
                        .textFieldStyle(.roundedBorder)
                        .disabled(viewModel.isSigningIn)
                }
                
                Spacer()
                
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
                }
            }
            .padding()
        }
        .toolbar {
            leadingToolBar
            trailingToolBar
        }
    }
}

extension AuthView {
    private var leadingToolBar: some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            HStack {
                Image("nodalIcon")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 24, height: 24)
                
                VStack {
                    Text("auth.title")
                        .foregroundStyle(Color.primary)
                        .font(Font.header15)
                    
                    Text("auth.subtitle")
                        .foregroundStyle(Color.secondary)
                        .font(Font.secondary11.bold())
                }
            }
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
            }
            
            VStack(alignment: .leading) {
                Text("auth.password.title")
                    .foregroundStyle(Color.secondary)
                    .font(Font.secondary11.bold())
                SecureField("auth.password.textField.title", text: $viewModel.password)
            }
        }
    }
    
    private var signUpFields: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                VStack(alignment: .leading) {
                    Text("auth.username.title")
                        .foregroundStyle(Color.secondary)
                        .font(Font.secondary11.bold())
                    TextField("auth.username.textField.title", text: $viewModel.username)
                        .textInputAutocapitalization(.none)
                        .keyboardType(.default)
                        .autocorrectionDisabled(true)
                }
                
                signInFields
                
                VStack(alignment: .leading) {
                    Text("auth.avatar.title")
                        .foregroundStyle(Color.secondary)
                        .font(Font.body15.bold())
                    LazyVGrid(columns: Metrics
                        .columns(count: 4)) {
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
                }
            }
        }
    }
}

#Preview {
    AuthView()
}
