//
//  TopListHeader.swift
//  C-Tab
//
//  Created by Максим Лозебной on 24.04.2026.
//

import SwiftUI

enum TokenLists: String, Identifiable, CaseIterable {
    case top, trending
    
    var id: String { rawValue }
    
    var title: LocalizedStringKey {
        switch self {
        case .top: return "topListCoins.top.title"
        case .trending: return "topListCoins.trending.title"
        }
    }
}

// MARK: - TopListHeader

struct TopListHeader: View {
    
    // MARK: - Properties
    
    @Binding private var selectedList: TokenLists
    
    init(selectedList: Binding<TokenLists>) {
        self._selectedList = selectedList
    }

    // MARK: - Body
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: Metrics.columns(count: 1)) {
                ForEach(TokenLists.allCases) { list in
                    var isListSelected: Bool {
                        selectedList == list
                        ? true
                        : false
                    }
                    
                    Button {
                        selectedList = list
                    } label: {
                        Text(list.title)
                            .foregroundStyle(
                                !isListSelected
                                ? Color.primary
                                : Color.orangeNeon
                            )
                            .font(Font.body13.bold())
                            .padding(.horizontal, 8)
                    }
                    
                    .cellStyle(
                        position: .single,
                        isSelected: isListSelected
                    )
                }
            }
        }
        
        .padding(.bottom, 8)
    }
}

#Preview {
    TabListView()
}
