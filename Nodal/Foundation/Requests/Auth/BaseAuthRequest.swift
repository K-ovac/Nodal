//
//  UserRequest.swift
//  Nodal
//
//  Created by Максим Лозебной on 15.11.2026.
//

import Foundation

struct SignInRequest: NetworkRequest {
    let dto: SignIn
    
    var endpoint: URL? {
        URL(string: AppEnviropment.baseURL + "/api/users")
    }
    
    var httpMethod: HttpMethod { .post }
    var body: Data? {
        try? JSONEncoder().encode(dto)
    }
}

struct SignUpRequest: NetworkRequest {
    let dto: SignUp
    
    var endpoint: URL? {
        URL(string: AppEnviropment.baseURL + "/api/users")
    }
    
    var httpMethod: HttpMethod { .post }
    var body: Data? {
        try? JSONEncoder().encode(dto)
    }
}

struct UserRequest: NetworkRequest {
    let token: String
    
    var endpoint: URL? {
        URL(string: AppEnviropment.baseURL + "/api/users/me")
    }
    
    var httpMethod: HttpMethod { .get }
    var headers: [String : String] {
        ["Authorization" : token]
    }
}
