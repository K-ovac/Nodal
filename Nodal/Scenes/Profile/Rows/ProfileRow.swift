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
        ZStack {
            Color.gradient
            
            VStack {
                HStack(spacing: 16) {
                    Image(systemName: "person.fill")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 24, height: 24)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.black.opacity(0.4)
                        ))
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.cautionPermit, lineWidth: 2)
                        )
                    
                    VStack(alignment: .leading) {
                        Text("Aleksey K.")
                            .font(.header20.bold())
                            .foregroundStyle(.white)
                        Text("kovac.eth")
                            .font(Font.body18)
                            .foregroundStyle(.white)
                    }
                    
                    Spacer()
                    
                    Button {
                        print("log out")
                    } label: {
                        Image(systemName: "rectangle.portrait.and.arrow.right")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 12, height: 12)
                            .foregroundStyle(Color.white)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color.black.opacity(0.4)
                            ))
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.cautionPermit, lineWidth: 2)
                            )
                    }
                }
            }
            .padding()
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    ProfileRow()
}
