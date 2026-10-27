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
    
    @State private var selected: Int = 1
    
    //MARK: - Body
    
    var body: some View {
        TabView(selection: $selected) {
            HomeView()
                .tag(0)
                .tabItem {
                    VStack {
                        Image(systemName: "lines.measurement.horizontal.aligned.bottom")
                        Text("Market")
                    }
                    
                }
            ProfileView()
                .tag(1)
                .tabItem {
                    VStack {
                        Image(systemName: "person")
                        Text("Profile")
                    }
                    
                }
            Text("tabList.watchlist.title")
                .tag(2)
                .tabItem {
                    VStack {
                        Image(systemName: "star")
                        Text("Watchlist")
                    }
                    
                }
            Text("tabList.settings.title")
                .tag(3)
                .tabItem {
                    VStack {
                        Image(systemName: "gear")
                        Text("Settings")
                    }
                    
                }
        }
        .tint(.orangeNeon)
        .toolbarBackground(Color.gradient)
    }
}

#Preview {
    TabListView()
}
