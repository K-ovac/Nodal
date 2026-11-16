//
//  TabView.swift
//  C-Tab
//
//  Created by Максим Лозебной on 21.04.2026.
//
import SwiftUI

//MARK: - TabList

struct TabListView: View {
    
    //MARK: - Properties
    
    @State private var selected: Int = 0
    
    //MARK: - Body
    
    var body: some View {
        TabView(selection: $selected) {
            HomeView()
                .tag(0)
                .tabItem {
                    VStack {
                        Image("vertical.equalize")
                            .renderingMode(.template)
                            .foregroundStyle(Color.orangeNeon)
                        Text("tabList.markets.title")
                            .font(Font.tabCapsule)
                    }
                    
                }
            
            WatchlistView()
                .tag(1)
                .tabItem {
                    VStack {
                        Image("star")
                            .renderingMode(.template)
                            .foregroundStyle(Color.orangeNeon)
                        Text("tabList.watchlist.title")
                            .font(Font.tabCapsule)
                    }
                    
                }
            
            Text("tabList.settings.title")
                .tag(2)
                .tabItem {
                    VStack {
                        Image("signGuard")
                            .renderingMode(.template)
                            .foregroundStyle(Color.orangeNeon)
                        Text("tabList.signGuard.title")
                            .font(Font.tabCapsule)
                    }
                    
                }
            
            ProfileView()
                .tag(3)
                .tabItem {
                    VStack {
                        Image("person")
                            .renderingMode(.template)
                            .foregroundStyle(Color.orangeNeon)
                        Text("tabList.profile.title")
                            .font(Font.tabCapsule)
                    }
                    
                }
        }
        .tint(.orangeNeon)
        .toolbarBackground(Color.linearGradient)
    }
}
