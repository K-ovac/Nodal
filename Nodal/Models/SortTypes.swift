//
//  SortTypes.swift
//  C-Tab
//
//  Created by Максим Лозебной on 11.06.2026.
//

import Foundation

enum SortTypes {
    case marketCap
    case price
    case percentChange
}

enum SortDirection {
    case ascending
    case descending
    
    mutating func toggle() {
        self = self == .ascending ? .descending : .ascending
    }
}
