//
//  ContentView.swift
//  kehillah.today-ios-swiftui
//
//  Created by Justin B on 9/7/22.
//

import SwiftUI
import WebKit
//
struct ContentView: View {
    var body: some View {
        MainPage()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .edgesIgnoringSafeArea(.all)

    }
}

//struct ContentView: View {
//    let title1 = "Internet Web Page"
//    let title2 = "Local Web Page"
//    let title3 = "Javascript Dialogs"
//    let title4 = "Message from Web View"
//    let title5 = "Message to Web View"
//
//    var body: some View {
//        VStack {
//            if #available(iOS 16.0, *) {
//                NavigationStack {
//                    List {
//                        NavigationLink(title1,
//                                       destination: InternetWebPage().navigationTitle(title1))
//                        .background(.teal)
//                        NavigationLink(title2,
//                                       destination: LocalWebPage().navigationTitle(title2))
//                        .background(.teal)
//                        NavigationLink(title3,
//                                       destination: JavascriptDialogs().navigationTitle(title3))
//                        .background(.teal)
//                        NavigationLink(title4,
//                                       destination: MessageFromWebView().navigationTitle(title4))
//                        .background(.teal)
//                        NavigationLink(title5,
//                                       destination: MessageToWebView().navigationTitle(title5))
//                        .background(.teal)
//                        NavigationLink(destination: MessageToWebView(withJSInjection: true).navigationTitle(title5)) {
//                            VStack(alignment: .leading) {
//                                Text(title5)
//                                Text("wih Javascript injection")
//                                    .foregroundColor(.gray)
//                                    .font(.system(size: 14))
//                            }
//                        }
//                        .background(.teal)
//                    }
//                    .navigationTitle("Web View Demos")
//                    .navigationBarTitleDisplayMode(.inline)
//                    .background(.teal)
//                }
//            } else {
//                // Fallback on earlier versions
//            }
//        }
//        .frame(maxWidth: .infinity, maxHeight: .infinity)
//            .background(.teal)
//    }
//}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
