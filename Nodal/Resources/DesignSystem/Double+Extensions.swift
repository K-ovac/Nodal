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
}
