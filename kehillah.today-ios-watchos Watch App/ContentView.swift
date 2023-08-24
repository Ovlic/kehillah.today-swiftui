//
//  ContentView.swift
//  kehillah.today-ios-watchos Watch App
//
//  Created by Ovlic B on 12/15/22.
//


import SwiftUI
import WebKit

struct ContentView: View {
    var body: some View {
        SwiftUIWebView()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .edgesIgnoringSafeArea(.all)

    }
}
