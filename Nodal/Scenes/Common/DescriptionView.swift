//
//  DescriptionView.swift
//  C-Tab
//
//  Created by Максим Лозебной on 15.09.2026.
//

import SwiftUI

//MARK: - DescriptionView

struct DescriptionView: View {
    
    //MARK: - Properties
    
    private let title: LocalizedStringKey
    private let text: LocalizedStringKey
    private let onClose: () -> Void
    
    //MARK: - Init
    
    init(
        title: LocalizedStringKey,
        text: LocalizedStringKey,
        onClose: @escaping () -> Void
    ) {
        self.title = title
        self.text = text
        self.onClose = onClose
    }
    
    //MARK: - Body
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .foregroundStyle(.primary)
                .font(.title2)
                .padding(.bottom)
            
            Text(text)
                .foregroundStyle(.primary)
                .font(.body)
                .padding(.bottom)
            
            //MARK: - Close View Button
            
            Button {
                onClose()
            } label: {
                Text("description.closeButton.title")
                    .font(.body.bold())
                    .padding(.horizontal)
                    .padding(.vertical, 8)
            }
            .foregroundStyle(.primary)
            .background(.secondary.opacity(0.1))
            .clipShape(.buttonBorder)
            .frame(maxWidth: .infinity, alignment: .center)
        }
        .multilineTextAlignment(.leading)
        .frame(maxWidth: .infinity, alignment: .topLeading)
        
        .padding()
    }
}
