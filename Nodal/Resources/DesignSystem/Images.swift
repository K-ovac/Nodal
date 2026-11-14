//
//  Images.swift
//  Nodal
//
//  Created by Максим Лозебной on 14.11.2026.
//

enum Avatars {
    static let ids: Int = 8
    
    static var title: [String] {
        (1...ids).compactMap {
            "avatar_\($0)"
        }
    }
}
