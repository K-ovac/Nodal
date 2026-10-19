//
//  ProfileRow.swift
//  C-Tab
//
//  Created by Максим Лозебной on 06.06.2026.
//

import SwiftUI

// MARK: - ProfileRow

struct ProfileRow: View {
    
    // MARK: - Body
    
    var body: some View {
        HStack {
            Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: 50, height: 50)
                .foregroundStyle(.gray)
            VStack(alignment: .leading, spacing: 3) {
                Text("profile.username.title")
                    .font(.headline)
                Text("profile.email.title")
                    .font(.subheadline)
            }
            Spacer()
            HStack {
                Button {
                    
                } label: {
                    HStack {
                        Text("profile.signButton.title")
                        Image(systemName: "rectangle.portrait.and.arrow.forward")
                    }
                    .foregroundStyle(.red)
                }
            }
        }
    }
}
