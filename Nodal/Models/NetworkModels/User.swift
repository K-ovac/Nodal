//
//  User.swift
//  Nodal
//
//  Created by Максим Лозебной on 15.11.2026.
//

struct User: Codable {
    let username: String
    let email: String
    let avatarUrl: String?
    let watchlist: [WatchlistCoins]
}

struct WatchlistCoins: Codable {
    let coinId: String
}

extension User {
    static let placeholder = User(
        username: "username",
        email: "user@example.com",
        avatarUrl: nil,
        watchlist: [])
}
