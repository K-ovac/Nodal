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
    
    //MARK: - Body
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    profileCard
                    settingsSection
                    linksSection
                }
            }
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
            .padding(.horizontal)
            .padding(.top)
    }
    
    private var settingsSection: some View {
        VStack(alignment: .leading) {
            Text("APP PREFERENCES")
                .font(Font.secondary14.bold())
                .foregroundStyle(Color.gray)
                .padding(.top)
            
            ForEach(viewModel.profileSettings) { setting in
                NavigationLink {
                    destinationView(
                        for: setting.destination,
                        title: setting.title
                    )
                } label: {
                    VStack {
                        SettingRow(
                            iconName: setting.iconName,
                            title: setting.title,
                            value: setting.value
                        )
                    }
                    
                }
            }
            .foregroundStyle(.primary)
            .padding()
            .background(Color.gray.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
            )
        }
        .padding(.horizontal)
    }
    
    //MARK: - Links Section
    
    private var linksSection: some View {
        
        
        VStack(alignment: .leading) {
            Text("LEGAL & SUPPORT")
                .font(Font.secondary14.bold())
                .foregroundStyle(Color.gray)
                .padding(.top)
            
            ForEach(viewModel.profileLinks) { link in
                SettingRow(
                    iconName: link.iconName,
                    title: LocalizedStringKey(link.title),
                    value: nil
                )
                .clipShape(Rectangle())
                .onTapGesture {
                    selectedLink = link
                }
                .sheet(item: $selectedLink) { link in
                    if let url = URL(string: link.link) {
                        SafariView(url: url)
                    }
                }
            }
            .foregroundStyle(.primary)
            .padding()
            .background(Color.gray.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
            )
        }
        .padding(.horizontal)
    }
}

#Preview {
    ProfileView()
}
