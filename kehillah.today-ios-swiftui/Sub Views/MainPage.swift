//
//  MainPage.swift
//  kehillah.today-ios-swiftui
//
//  Created by Ovlic B on 8/22/23.
//

import SwiftUI

struct MainPage: View {
    @ObservedObject var vm = LocalWebViewVM(webResource: "kehillah_today.html")
    
    //@ViewBuilder
    var body: some View {
        //if UserDefaults.standard.bool(forKey: "DarkMode") == true {
            VStack {
                WebView(vm: vm)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .edgesIgnoringSafeArea(.all)
            .background(Color("Background"))
            .hueRotation(.degrees(UserDefaults.standard.bool(forKey: "DarkMode") == true ? 180 : 0))
            .if(UserDefaults.standard.bool(forKey: "DarkMode") == true) { view in
                view.colorInvert()
            }
            .preferredColorScheme(UserDefaults.standard.bool(forKey: "DarkMode") == true ? .dark : .light)
            
        
            
//        } else {
//            VStack {
//                WebView(vm: vm)
//            }
//            .frame(maxWidth: .infinity, maxHeight: .infinity)
//            .edgesIgnoringSafeArea(.all)
//            .hueRotation(.degrees(UserDefaults.standard.bool(forKey: "DarkMode") == true ? 180 : 0))
//        }
    }
}

struct MainPage_Previews: PreviewProvider {
    static var previews: some View {
        MainPage()
    }
}

extension View {
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}
