//
//  LinkConstants.swift
//  C-Tab
//
//  Created by Максим Лозебной on 09.06.2026.
//

import UIKit

enum LinksConstants {
    private static let appStoreID = "1600000000"
    
    static let rateOurApp = "https://apple.com/"
    
    static let privacyPolicy = "https://google.com/"
    
    static let openSettings = URL.make(UIApplication.openSettingsURLString)
}

extension URL {
    static func make(_ url: String) -> URL {
        if let url = URL(string: url) {
            return url
        } else {
            fatalError("Incorrect URL" + url)
        }
    }
}
