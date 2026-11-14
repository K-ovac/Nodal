//
//  View+Extensions.swift
//  Nodal
//
//  Created by Максим Лозебной on 28.10.2026.
//

import SwiftUI

// MARK: - Cell Position

enum CellPosition {
    case first, middle, last, single
}

// Extension View

extension View {
    
    @ViewBuilder
    func applyLiquidGlassEffect() -> some View {
        if #available(iOS 26.0, *) {
            self.buttonStyle(.glass)
        } else {
            self
        }
    }
    
    func listRowPreset() -> some View {
        self
            .listRowSeparator(.hidden)
            .listRowBackground(Color.clear)
            .listRowInsets(EdgeInsets(
                top: 0,
                leading: 16,
                bottom: 0,
                trailing: 16))
    }
    
    func selectItem(isSelected: Bool, color: Color) -> some View {
        self
            .padding(.horizontal, 8)
            .padding(.top, 12)
            .padding(.bottom, 4)
            .background(
                isSelected
                ? color.opacity(0.15)
                : .clear)
            .overlay(
                Metrics.shapeCr16
                    .strokeBorder(
                        isSelected
                        ? color
                        : .clear,
                        lineWidth: 1))
            .clipShape(Metrics.shapeCr16)
    }
    
    func cellStyle<Item:Equatable>(
        for item: Item,
        in items: [Item],
        isSelected: Bool = false,
        outerRadius: CGFloat = 16,
        innerRadius: CGFloat = 0,
        padding: CGFloat = 8
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
            innerRadius: innerRadius,
            padding: padding
        )
    }
    
    func cellStyle(
        position: CellPosition,
        isSelected: Bool = false,
        outerRadius: CGFloat = 16,
        innerRadius: CGFloat = 0,
        padding: CGFloat = 8
    ) -> some View {
        self.stylePreset(
            position: position,
            isSelected: isSelected,
            outerRadius: outerRadius,
            innerRadius: innerRadius,
            padding: padding
        )
    }
    
    private func stylePreset(
        position: CellPosition,
        isSelected: Bool = false,
        outerRadius: CGFloat = 16,
        innerRadius: CGFloat = 0,
        padding: CGFloat = 8
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
            .padding(padding)
            .background(Color.card)
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
