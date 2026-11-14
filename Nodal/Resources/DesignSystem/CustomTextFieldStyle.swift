//
//  CustomTextFieldStyle.swift
//  Nodal
//
//  Created by Максим Лозебной on 14.11.2026.
//

import SwiftUI

struct CustomTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .cellStyle(position: .single)
    }
}
