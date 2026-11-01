//
//  BackButtonView.swift
//  Nodal
//
//  Created by Максим Лозебной on 01.11.2026.
//

import SwiftUI

struct BackButtonView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        Button {
            dismiss()
        } label: {
            HStack {
                Image(systemName: "chevron.left")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 8, height: 8)
                Text("coinDetails.backButton.title")
                    .foregroundStyle(Color.primary)
                    .font(Font.body13.bold())
                    .fixedSize(horizontal: true, vertical: false)
            }
        }
    }
}
