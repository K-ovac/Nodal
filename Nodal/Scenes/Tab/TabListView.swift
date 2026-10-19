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
                    Image(systemName: "house")
                }
            Text("tabList.portfolio.title")
                .tag(1)
                .tabItem {
                    Image(systemName: "folder.fill")
                }
            Text("tabList.watchlist.title")
                .tag(2)
                .tabItem {
                    Image(systemName: "star")
                }
            Text("tabList.settings.title")
                .tag(3)
                .tabItem {
                    Image(systemName: "gear")
                }
        }
    }
}

#Preview {
    TabListView()
}
