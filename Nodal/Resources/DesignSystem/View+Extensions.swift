//
//  View+Extensions.swift
//  Nodal
//
//  Created by Максим Лозебной on 28.10.2026.
//

import SwiftUI

enum CellPosition {
    case first, middle, last, single
}

extension View {
    func cellStyle<Item:Equatable>(
        for item: Item,
        in items: [Item],
        isSelected: Bool = false,
        outerRadius: CGFloat = 16,
        innerRadius: CGFloat = 0
    ) -> some View {
        let position: CellPosition = {
            guard items.count > 1 else { return .single }
            if item == items.first {
                return .first
            } else if item == items.last {
                return .last
            } else {
                return .middle
            }
        }()
        
        return self.stylePreset(
            position: position,
            isSelected: isSelected,
            outerRadius: outerRadius,
            innerRadius: innerRadius
        )
    }
    
    func cellStyle(
        position: CellPosition,
        outerRadius: CGFloat = 16,
        innerRadius: CGFloat = 0
    ) -> some View {
        self.stylePreset(
            position: position,
            outerRadius: outerRadius,
            innerRadius: innerRadius
        )
    }
    
    private func stylePreset(
        position: CellPosition,
        isSelected: Bool = false,
        outerRadius: CGFloat = 16,
        innerRadius: CGFloat = 0
    ) -> some View {
        let radii: RectangleCornerRadii = {
            switch position {
            case .first:
                return .init(
                    topLeading: outerRadius,
                    bottomLeading: innerRadius,
                    bottomTrailing: innerRadius,
                    topTrailing: outerRadius
                )
            case .middle:
                return .init(
                    topLeading: innerRadius,
                    bottomLeading: innerRadius,
                    bottomTrailing: innerRadius,
                    topTrailing: innerRadius
                )
            case .last:
                return .init(
                    topLeading: innerRadius,
                    bottomLeading: outerRadius,
                    bottomTrailing: outerRadius,
                    topTrailing: innerRadius
                )
            case .single:
                return .init(
                    topLeading: outerRadius,
                    bottomLeading: outerRadius,
                    bottomTrailing: outerRadius,
                    topTrailing: outerRadius
                )
            }
        }()
        
        let shape = UnevenRoundedRectangle(
            cornerRadii: radii,
            style: .continuous
        )
        
        return self
            .foregroundStyle(.primary)
            .padding(8)
            .background(Color.navigation)
            .clipShape(shape)
            .overlay(
                shape
                    .strokeBorder(
                        isSelected
                        ? Color.orangeNeon.opacity(0.6)
                        : Color.gray.opacity(0.25),
                        lineWidth: 0.5
                    )
            )
    }
}
