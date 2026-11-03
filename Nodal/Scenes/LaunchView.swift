//
//  LaunchView.swift
//  Nodal
//
//  Created by Максим Лозебной on 03.11.2026.
//

import SwiftUI

struct LaunchView: View {
    
    @Binding var isReady: Bool
    
    var body: some View {
        ZStack {
            Color.radialGradient
                .ignoresSafeArea()
            
            Image("nodalIcon")
                .resizable()
                .scaledToFill()
                .frame(width: 160, height: 160)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                withAnimation(.easeInOut(duration: 0.4)) {
                    isReady.toggle()
                }
            }
        }
    }
}
