//
//  ProfileViewModel.swift
//  C-Tab
//
//  Created by Максим Лозебной on 04.06.2026.
//

import SwiftUI
import Combine

// MARK: - ProfileViewModel

@MainActor
final class ProfileViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published private(set) var profile: Profile?
    @Published private(set) var profileSettings: [ProfileSetting] = []
    @Published private(set) var profileLinks: [ProfileLink] = []
    
    private var storage = UserDefaultsService.shared
    
    var selectedCurrency: String {
        get { storage.currentCurrency }
    }
    var selectedTheme: String {
        get { storage.currentTheme }
    }
    
    var selectedLanguage: Language {
        Language(rawValue: storage.currentLanguage) ?? .en
    }
    
    // MARK: - GetProfile
    
    func getProfile() async {
        profile = Profile(
            avatar: "person.circle.fill",
            username: "@username",
            email: "email@mail.com"
        )
        
        profileSettings = [
            ProfileSetting(
                title: "profile.currency.title",
                iconName: "dollarsign.circle",
                value: selectedCurrency,
                destination: .currency
            ),
            ProfileSetting(
                title: "profile.appTheme.title",
                iconName: "lightbulb.min",
                value: selectedTheme,
                destination: .appTheme
            ),
            ProfileSetting(
                title: "profile.language.title",
                iconName: "translate",
                value: selectedLanguage.title,
                destination: .language),
        ]
        
        profileLinks = [
            ProfileLink(
                title: "profile.privacyPolicy.title",
                iconName: "document",
                link: LinksConstants.privacyPolicy
            ),
            ProfileLink(
                title: "profile.rateOurApp.title",
                iconName: "hand.thumbsup",
                link: LinksConstants.rateOurApp
            )
        ]
    }
}
