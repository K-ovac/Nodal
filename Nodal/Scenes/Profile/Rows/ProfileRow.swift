//
//  ProfileRow.swift
//  C-Tab
//
//  Created by Максим Лозебной on 06.06.2026.
//

import SwiftUI
import Kingfisher

// MARK: - ProfileRow

struct ProfileRow: View {
    
    private var user: User?
    private var isAuthorized: Bool
    private let onActionTap: () -> Void
    
    // MARK: - Init
    
    init(
        user: User? = nil,
        isAuthorized: Bool,
        onActionTap: @escaping () -> Void
    ) {
        self.user = user
        self.isAuthorized = isAuthorized
        self.onActionTap = onActionTap
    }
    
    // MARK: - Body
    
    var body: some View {
        VStack {
            if isAuthorized {
                if let user = user {
                    authorized(user: user)
                } else {
                    authorized(user: .placeholder)
                        .shimmer(active: true)
                        .allowsHitTesting(false)
                }
            } else {
                unauthorized
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

extension ProfileRow {
    
    // MARK: - Unauthorized
    
    private var unauthorized: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                let shape = Metrics.shapeCr12
                
                Image(systemName: "touchid")
                    .foregroundStyle(Color.cautionPermit)
                    .padding(8)
                    .background(Color.orangeNeon.opacity(0.1))
                    .overlay(shape.strokeBorder(Color.drainerAlert))
                    .clipShape(shape)
                
                VStack(alignment: .leading) {
                    Text("profile.card.unauthorized.title")
                        .foregroundStyle(Color.primary)
                        .font(Font.body15.bold())
                    
                    Text("profile.card.unauthorized.subtitle")
                        .foregroundStyle(Color.secondary)
                        .font(Font.secondary11.bold())
                }
            }
            .frame(alignment: .topLeading)
            
            Button {
                onActionTap()
            } label: {
                HStack {
                    Image(systemName: "key")
                    Text("profile.card.authorizeButton.title")
                        .font(Font.body13.bold())
                }
                .foregroundStyle(Color.white)
                .frame(maxWidth: .infinity)
            }
            .padding(4)
            .frame(maxWidth: .infinity)
            .background(Color.linearGradient)
            .clipShape(.capsule)
            .padding(.top)
        }
        .cellStyle(position: .single, padding: 16)
    }
    
    // MARK: - Autnhorized
    
    private func authorized(user: User) -> some View {
        ZStack {
            Color.linearGradient.opacity(0.75)
            
            HStack(spacing: 16) {
                Image(user.avatarUrl ?? "")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 48, height: 48)
                    .padding(8)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.black.opacity(0.4))
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.cautionPermit, lineWidth: 0.5)
                    )
                
                VStack(alignment: .leading) {
                    Text("@" + user.username)
                        .font(.body18.bold())
                        .foregroundStyle(.white)
                    Text(user.email)
                        .font(Font.body15.bold())
                        .foregroundStyle(.white)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                
                Spacer()
                
                Button {
                    onActionTap()
                } label: {
                    Image(systemName: "rectangle.portrait.and.arrow.right")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 12, height: 12)
                        .foregroundStyle(Color.white)
                        .padding(12)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.black.opacity(0.4))
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .strokeBorder(Color.cautionPermit, lineWidth: 0.5)
                        )
                        .unredacted()
                }
                .buttonStyle(.plain)
            }
            .padding()
        }
    }
}
