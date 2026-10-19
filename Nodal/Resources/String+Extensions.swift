//
//  String+Extensions.swift
//  C-Tab
//
//  Created by Максим Лозебной on 10.06.2026.
//

import Foundation

extension String {
    static func make(for value: Double, isPrice: Bool) -> String {
        return isPrice ? "$" + String(format: "%.2f", value) : String(format: "%.2f", value)
    }
    
    static func makeCompact(for value: Double) -> String {
        let formatted = value.formatted(.number.notation(.compactName))
        
        return "$" + String(formatted)
    }
}
