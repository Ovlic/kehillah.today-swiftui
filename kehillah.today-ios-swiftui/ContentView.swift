//
//  ContentView.swift
//  kehillah.today-ios-swiftui
//
//  Created by Justin B on 9/7/22.
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
