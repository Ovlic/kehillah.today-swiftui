//
//  SwiftUIWebView.swift
//  kehillah.today-ios-watchos Watch App
//
//  Created by Ovlic B on 12/15/22.
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
