//
//  TopListHeader.swift
//  C-Tab
//
//  Created by Максим Лозебной on 24.04.2026.
//

import SwiftUI

// MARK: - TopListHeader

struct TopListHeader: View {
    
    // MARK: - Properties
    
    @Binding var rankCtrypto: RankCrypto
    @Binding var priceChange: PriceChange
    
    let actionSort: (SortTypes) -> Void
    let currentSort: SortTypes?
    let sortDirection: SortDirection

    // MARK: - Body
    
    var body: some View {
        VStack(spacing: 10) {
            HStack {
                
                // MARK: - Rank Crypto
                
                ZStack {
                    RoundedRectangle(cornerRadius: 6)
                        .foregroundStyle(.gray)
                        .opacity(0.3)
                    Picker("topList.header.byRank.title", selection: $rankCtrypto) {
                        ForEach(RankCrypto.allCases) { rank in
                            Text(rank.id).tag(rank)
                        }
                    }
                }
                
                // MARK: - Price Change
                
                ZStack {
                    RoundedRectangle(cornerRadius: 6)
                        .foregroundStyle(.gray)
                        .opacity(0.3)
                    
                    Picker("topList.header.priceChange.title", selection: $priceChange) {
                        ForEach(PriceChange.allCases) { change in
                            Text(change.id).tag(change)
                        }
                    }
                }
            } .frame(height: 35)
                .foregroundStyle(.primary)
            
            HStack {
                
                // MARK: - Sort by M. Cap Rank
                
                Button {
                    actionSort(.marketCap)
                } label: {
                    Text("topList.header.mCap.title")
                        .font(.system(size: 11, weight: .regular))
                    sortImage(for: .marketCap)
                }
                
                Spacer()
                
                HStack(spacing: 10) {
                    
                    // MARK: - Sort by Price
                    
                    Button {
                        actionSort(.price)
                    } label: {
                        Text("topList.header.price.title")
                            .font(.system(size: 11, weight: .regular))
                        sortImage(for: .price)
                    }
                    
                    // MARK: - Sort by Percent Change
                    
                    Button {
                        actionSort(.percentChange)
                    } label: {
                        Text("topList.header.percentageChange24h.title")
                            .font(.system(size: 11, weight: .regular))
                        sortImage(for: .percentChange)
                    } .padding(.leading, 20)
                }
            }.foregroundStyle(.primary)
        }
    }
}

// MARK: - Extension TopListHeader

extension TopListHeader {
    
    // MARK: - Private Method Sirt Image
    
    private func sortImage(for type: SortTypes) -> some View {
        Image(
            systemName: currentSort == type
            ? (sortDirection == .descending ? "chevron.down" : "chevron.up") 
            : "chevron.down"
        )
        .resizable()
        .frame(width: 8, height: 6)
        .foregroundStyle(currentSort == type ? .blue : .secondary)
    }
}
