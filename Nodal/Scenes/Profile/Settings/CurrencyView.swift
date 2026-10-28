//
//  CurrencyView.swift
//  C-Tab
//
//  Created by Максим Лозебной on 06.06.2026.
//

import SwiftUI

//TODO: - переработать

struct CurrencyView: View {
    @Environment(\.dismiss) var dismiss
    @AppStorage(Keys.currency.value)
    private var selectedCurrency: CurrencyPrice = .usd
    private let title: LocalizedStringKey
    
    init(title: LocalizedStringKey) {
        self.title = title
    }
    
    var body: some View {
        List {
            currencySection
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
        .toolbar {
            leadingToolBar
            trailingToolBar
        }
    }
}

extension CurrencyView {
    private var leadingToolBar: some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            Text(title)
                .padding(.horizontal, 8)
                .foregroundStyle(Color.primary)
                .font(Font.header20)
                .fixedSize(horizontal: true, vertical: false)
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
    
    private var currencySection: some View {
        LazyVStack(spacing: 4) {
            ForEach(CurrencyPrice.allCases) { currency in
                HStack {
                    Image(systemName: currency.icon)
                    Text(currency.title)
                        .foregroundStyle(Color.primary)
                        .font(Font.body18)
                    
                    Spacer()
                    
                    if selectedCurrency == currency {
                        Image(systemName: "checkmark")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 10, height: 10)
                            .foregroundStyle(Color.black)
                        
                            .padding(8)
                            .background(Color.gradient)
                            .clipShape(.circle)
                    }
                }
                .stylePreset()
                .onTapGesture {
                    withAnimation {
                        selectedCurrency = currency
                    }
                }
            }
        }
    }
}
