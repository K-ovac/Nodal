//
//  RequestConstants.swift
//  C-Tab
//
//  Created by Максим Лозебной on 24.04.2026.
//

import Foundation

enum AppEnviropment {
    static var baseURL: String {
        return "https://" + (Bundle.main.infoDictionary?["API_BASE_URL"] as? String ?? "")
    }
    
    static var apiKey: String {
        return Bundle.main.infoDictionary?["API_KEY"] as? String ?? ""
    }
    
    static var apiHeader: String {
        return Bundle.main.infoDictionary?["API_HEADER"] as? String ?? ""
    }
}
