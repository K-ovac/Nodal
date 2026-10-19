//
//  CurrencyView.swift
//  C-Tab
//
//  Created by Максим Лозебной on 06.06.2026.
//

import SwiftUI

//TODO: - переработать

struct CurrencyView: View {
    @AppStorage(Keys.currency.value)
    private var selectedCurrency: CurrencyPrice = .usd
    
    let title: LocalizedStringKey
    
    var body: some View {
        List {
            ForEach(CurrencyPrice.allCases) { currency in
                HStack {
                    Image(systemName: currency.icon)
                    Text(currency.id)
                    
                    Spacer()
                    
                    if selectedCurrency == currency {
                        Image(systemName: "checkmark")
                            .foregroundStyle(.blue)
                    }
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    selectedCurrency = currency
                }
            }
        }
        .navigationTitle(title)
        .scrollDisabled(true)
    }
}
