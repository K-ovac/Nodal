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
    
    @Published private(set) var profileSettings: [ProfileSetting] = []
    @Published private(set) var profileLinks: [ProfileLink] = []
    
    @Published var user: User?
    @Published var isAuthorized: Bool = false
    @Published var isAuthPresented: Bool = false
    @Published var profileCardState: ViewState = .initial
    
    private var storage = UserDefaultsService.shared
    private let keychainStorage: AuthTokenStorageProtocol
    private let authService: AuthServiceProtocol

    
    var selectedCurrency: String {
        get { storage.currentCurrency }
    }
    var selectedTheme: String {
        get { storage.currentTheme }
    }
    
    var selectedLanguage: Language {
        Language(rawValue: storage.currentLanguage) ?? .en
    }
    
    init(
        authService: AuthServiceProtocol,
        keychainStorage: AuthTokenStorageProtocol) {
            self.authService = authService
            self.keychainStorage = keychainStorage
            self.isAuthorized = keychainStorage.hasToken
        }
     
    func signOut() {
        authService.signOut()
        isAuthorized = false
        user = nil
    }
    
    func signIn() {
        isAuthorized = true
        Task {
            await getProfile()
        }
    }
    
    func onAuthSuccess() {
        isAuthorized = true
        isAuthPresented = false
        Task {
            await getProfile()
        }
    }
    
    // MARK: - GetProfile
    
    func getProfile() async {
        guard isAuthorized else {
            user = nil
            profileCardState = .initial
            return
        }
        
        profileCardState = .loading
        
        do {
            let user = try await authService.fetchUser()
            self.user = user
            
            profileCardState = .loaded
        } catch {
            signOut()
            profileCardState = .failure(error)
        }
    }
    
    func getSettings() async {
        profileSettings = [
            ProfileSetting(
                title: "profile.currency.title",
                iconName: "currency",
                value: selectedCurrency,
                color: Color.solarGold,
                destination: .currency
            ),
            ProfileSetting(
                title: "profile.language.title",
                iconName: "language",
                value: selectedLanguage.title,
                color: Color.drainerAlert,
                destination: .language),
            ProfileSetting(
                title: "profile.appTheme.title",
                iconName: "palette",
                value: selectedTheme,
                color: Color.cautionPermit,
                destination: .appTheme
            ),
            
        ]
        
        profileLinks = [
            ProfileLink(
                title: "profile.privacyPolicy.title",
                iconName: "description",
                link: LinksConstants.privacyPolicy,
                color: Color.enclaveSafe
            ),
            ProfileLink(
                title: "profile.rateOurApp.title",
                iconName: "medal",
                link: LinksConstants.rateOurApp,
                color: Color.solarGold
            )
        ]
    }
}
