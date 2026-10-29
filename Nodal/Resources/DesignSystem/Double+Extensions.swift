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
        self >= 0 ? Color.solarGold : Color.drainerAlert
    }
    
    var percentBackgroundColor: Color {
        self >= 0 ? Color.solarGold.opacity(0.2) : Color.drainerAlert.opacity(0.2)
    }
}
