//
//  SafariView.swift
//  C-Tab
//
//  Created by Максим Лозебной on 13.09.2026.
//

import SwiftUI
import SafariServices

// MARK: - SafariView

struct SafariView: UIViewControllerRepresentable {
    let url: URL
    
    func makeUIViewController(context: Context) -> some UIViewController {
        SFSafariViewController(url: url)
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) { }
}
