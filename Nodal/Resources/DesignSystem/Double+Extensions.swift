//
//  Double+Extensions.swift
//  C-Tab
//
//  Created by Максим Лозебной on 25.04.2026.
//

import SwiftUI

extension Double {
    var percentChangeColor: Color {
        self >= 0
        ? Color.enclaveSafe
        : Color.drainerAlert
    }
    
    var percentBorderColor: Color {
        self >= 0
        ? Color.enclaveSafe
        : Color.drainerAlert
    }
    
    var percentBackgroundColor: Color {
        self >= 0
        ? Color.enclaveSafe.opacity(0.25)
        : Color.drainerAlert.opacity(0.25)
    }
    
    func formattedPrice(currency: String) -> String {
        let absValue = abs(self)
        
        guard absValue > 0 else {
            return self.formatted(
                .currency(code: currency)
                .precision(.fractionLength(2)))
        }
        
        if absValue >= 1.0 {
            return self.formatted(
                .currency(code: currency)
                .precision(.fractionLength(2)))
        } else if absValue >= 0.01 {
            return self.formatted(
                .currency(code: currency)
                .precision(.fractionLength(2...4)))
        } else {
            return self.formatted(
                .currency(code: currency)
                .precision(.significantDigits(2...4)))
        }
    }
    
    func formattedCompactCurrency(currency: String, isCurrency: Bool = true) -> String {
        return self.formatted(
            .currency(code: currency)
            .notation(.compactName)
            .precision(.fractionLength(0...2)))
    }
    
    func formattedPercentage(isChange: Bool = true) -> String {
        return (self / 100).formatted(
            .percent
                .sign(strategy: isChange
                      ? .always()
                      : .never)
                .precision(.fractionLength(2)))
    }
    
    func formattedCompactValue() -> String {
        self.formatted(.number
            .notation(.compactName))
    }
}
