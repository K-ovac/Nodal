//
//  AuthServiceProtocol.swift
//  Nodal
//
//  Created by Максим Лозебной on 16.11.2026.
//

protocol AuthServiceProtocol {
    func signIn(dto: SignIn) async throws -> User
    func signUp(dto: SignUp) async throws -> User
    func fetchUser() async throws -> User
    func signOut()
}
