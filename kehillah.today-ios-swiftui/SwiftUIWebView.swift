//
//  SwiftUIWebView.swift
//  kehillah.today-ios-swiftui
//
//  Created by Justin B on 9/7/22.
//

import SwiftUI
import WebKit

struct SwiftUIWebView: UIViewRepresentable {
    typealias UIViewType = WKWebView
    
    let webView: WKWebView
    
    init() {
        webView = WKWebView(frame: .zero)
        webView.load(URLRequest(url: URL(fileURLWithPath: Bundle.main.path(forResource: "kehillah_today", ofType: "html")!)))
    }
    
    func makeUIView(context: Context) -> WKWebView {
        webView
    }
    func updateUIView(_ uiView: WKWebView, context: Context) {
    }
}
