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
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                settingsSection
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                linksSection
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
            }
            
            .background(Color.background)
            .listStyle(.plain)
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
                Text("Profile & Settings")
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
                    Text("Edit")
                        .foregroundStyle(Color.primary)
                        .font(Font.header15)
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
    }
    
    private var settingsSection: some View {
        LazyVStack(alignment: .leading, spacing: 4) {
            Text("APP PREFERENCES")
                .font(Font.secondary14.bold())
                .foregroundStyle(Color.gray)
            
            ForEach(viewModel.profileSettings) { setting in
                SettingRow(
                    iconName: setting.iconName,
                    title: setting.title,
                    value: setting.value
                )
                .stylePreset()
                .onTapGesture {
                    selectedSetting = setting
                }
            }
        }
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
        LazyVStack(alignment: .leading, spacing: 4) {
            Text("LEGAL & SUPPORT")
                .font(Font.secondary14.bold())
                .foregroundStyle(Color.gray)
            
            ForEach(viewModel.profileLinks) { link in
                SettingRow(
                    iconName: link.iconName,
                    title: LocalizedStringKey(link.title),
                    value: nil
                )
                .stylePreset()
                .onTapGesture {
                    selectedLink = link
                }
            }
            
        }
        .sheet(item: $selectedLink) { link in
            if let url = URL(string: link.link) {
                SafariView(url: url)
            }
        }
    }
}

#Preview {
    TabListView()
}
