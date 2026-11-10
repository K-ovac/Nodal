//
//  ProfileView.swift
//  C-Tab
//
//  Created by Максим Лозебной on 23.04.2026.
//

import SwiftUI

//MARK: - Profile View

struct ProfileView: View {
    
    //MARK: - Properties
    
    @StateObject private var viewModel = ProfileViewModel()
    @State private var selectedLink: ProfileLink?
    @State private var selectedSetting: ProfileSetting?
    
    //MARK: - Body
    
    var body: some View {
        NavigationStack {
            List {
                profileCard
                    .listRowPreset()
                settingsSection
                    .listRowPreset()
                linksSection
                    .listRowPreset()
            }
            .listStyle(.plain)
            .background(Color.background)
            
            .toolbar {
                leadingToolbar
                trailingToolbar
            }
        }
        .task {
            await viewModel.getProfile()
        }
    }
}

//MARK: - Extension ProfileView

extension ProfileView {
    
    private var leadingToolbar: some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            HStack {
                Image(systemName: "gearshape")
                    .foregroundStyle(Color.solarGold)
                Text("profile.title")
                    .foregroundStyle(Color.primary)
                    .font(Font.header20)
                    .fixedSize(horizontal: true, vertical: false)
            }
            .padding(.horizontal, 8)
        }
    }
    
    private var trailingToolbar: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Button {
                //                        dismiss()
            } label: {
                HStack {
                    Image(systemName: "pencil.line")
                        .frame(width: 20, height: 20)
                    Text("profile.editButton.title")
                        .foregroundStyle(Color.primary)
                        .font(Font.body13.bold())
                        .fixedSize(horizontal: true, vertical: false)
                }
                
            }
        }
    }
    
    //MARK: - Private Destination method
    
    @ViewBuilder
    private func destinationView(for destination: SettingsDestination, title: LocalizedStringKey) -> some View {
        switch destination {
        case .currency:
            CurrencyView(title: title)
        case .appTheme:
            AppThemeView(title: title)
        case .language:
            LanguageView(title: title)
        }
    }
    
    //MARK: - Settings Section
    
    private var profileCard: some View {
        ProfileRow()
            .clipShape(
                RoundedRectangle(cornerRadius: 16)
            )
            .padding(.bottom)
    }
    
    private var settingsSection: some View {
        LazyVStack(alignment: .leading, spacing: 1) {
            Text("profile.settings.title")
                .font(Font.body15.bold())
                .foregroundStyle(Color.gray)
                .padding(.bottom, 4)
            
            ForEach(viewModel.profileSettings) { setting in
                SettingRow(
                    iconName: setting.iconName,
                    title: setting.title,
                    value: setting.value,
                    color: setting.color
                )
                .cellStyle(for: setting, in: viewModel.profileSettings)
                .onTapGesture {
                    selectedSetting = setting
                }
            }
        }
        .padding(.bottom)
        
        .sheet(item: $selectedSetting) { setting in
            NavigationStack {
                destinationView(for: setting.destination, title: setting.title)
                    .presentationDetents([.medium, .large])
                    .background(Color.navigation)
            }
        }
    }
    
    //MARK: - Links Section
    
    private var linksSection: some View {
        LazyVStack(alignment: .leading, spacing: 1) {
            Text("profile.links.title")
                .font(Font.body15.bold())
                .foregroundStyle(Color.gray)
                .padding(.bottom, 4)
            
            ForEach(viewModel.profileLinks) { link in
                SettingRow(
                    iconName: link.iconName,
                    title: LocalizedStringKey(link.title),
                    value: nil,
                    color: link.color
                )
                .cellStyle(for: link, in: viewModel.profileLinks)
                .onTapGesture {
                    selectedLink = link
                }
            }
            
        }
        .padding(.bottom)
        
        .sheet(item: $selectedLink) { link in
            if let url = URL(string: link.link) {
                SafariView(url: url)
            }
        }
    }
}
