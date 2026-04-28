//
//  WebView.swift
//  kehillah.today-ios-swiftui
//
//  Created by Justin B on 8/22/23.
//

import SwiftUI

struct WebView: View {
    @ObservedObject var vm: BaseWebViewVM
    
    var body: some View {
        SwiftUIWebView(viewModel: vm)
            .onAppear(perform: vm.loadWebPage)
            .alert(vm.panelTitle,
                   isPresented: $vm.showPanel,
                   actions: {
                switch vm.panelType {
                case .alert:
                    Button("Close") {
                        vm.alertCompletionHandler()
                    }
                case .confirm:
                    Button("Ok") {
                        vm.confirmCompletionHandler(true)
                    }
                    Button("Cancel") {
                        vm.confirmCompletionHandler(false)
                    }
                case .prompt:
                    TextField(text: $vm.promptInput) {}
                    Button("Ok") {
                        vm.promptCompletionHandler(vm.promptInput)
                    }
                    Button("Cancel") {
                        vm.promptCompletionHandler(nil)
                    }
                default:
                    Button("Close") {}
                }
            }, message: {
                Text(vm.panelMessage)
            })
    }
}

struct WebView_Previews: PreviewProvider {
    static var previews: some View {
        // Hi! The HTML file passed in here does NOT change which file the app loads!
        // This code was written a while ago to make an attempt to hook up the code
        // more naturally with Swift so I could add more features, but I never got
        // around to doing that.
        
        // If you are trying to change the HTML source file for the app, change the
        // path found within the 'vm' variable in Sub Views/MainPage.swift!
        WebView(vm: LocalWebViewVM(webResource: "NOTindex.html"))
    }
}
