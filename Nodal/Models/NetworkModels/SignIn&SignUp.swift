//
//  SignIn&SignUp.swift
//  Nodal
//
//  Created by Максим Лозебной on 15.11.2026.
//

struct SignIn: Encodable {
    let email: String
    let password: String
}

struct SignUp: Encodable {
    let username: String
    let email: String
    let password: String
    let avatarUrl: String?
}
