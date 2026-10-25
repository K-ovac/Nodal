//
//  RequestConstants.swift
//  C-Tab
//
//  Created by Максим Лозебной on 24.04.2026.
//

import Foundation

enum RequestConstants {
    
    static let baseURL = ""
    #warning("enter your api key")
    static let apiKey = ""
    static let apiHeader = ""
}

enum AppEnviropment {
    static let baseURL: String {
        return Bundle.mail.infoDictionary?["API_BASE_URL"] as? String
    }
    
    static let apiKey: String {
        return Bundle.mail.infoDictionary?["API_KEY"] as? String
    }
    
    static let apiHeader: String {
        return Bundle.mail.infoDictionary?["API_HEADER"] as? String
    }
}
