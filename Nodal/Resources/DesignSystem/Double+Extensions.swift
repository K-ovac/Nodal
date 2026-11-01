//
//  Double+Extensions.swift
//  C-Tab
//
//  Created by Максим Лозебной on 25.04.2026.
//

import SwiftUI

extension Double {
    var percentChangeColor: Color {
        self >= 0 ? Color.enclaveSafe : Color.drainerAlert
    }
    
    var percentBorderColor: Color {
        self >= 0 ? Color.enclaveSafe : Color.drainerAlert
    }
    
    var percentBackgroundColor: Color {
        self >= 0 ? Color.enclaveSafe.opacity(0.25) : Color.drainerAlert.opacity(0.25)
    }
    
    var percentChange: String {
        String(
            format: "%.2f%%",
            self
        )
    }
    
    var statValue: String {
        self
            .formatted(
                .number
                    .notation(.compactName)
            )
    }
}
