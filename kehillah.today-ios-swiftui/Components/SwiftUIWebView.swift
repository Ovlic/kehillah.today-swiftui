//
//  SwiftUIWebView.swift
//  kehillah.today-ios-swiftui
//
//  Created by Justin B on 9/7/22.
//
//
//import SwiftUI
//import WebKit
//
//struct SwiftUIWebView: UIViewRepresentable {
//    typealias UIViewType = WKWebView
//
//    //let webView: WKWebView
////    init() {
////        webView = WKWebView(frame: .zero)
////
////        //webView.load(URLRequest(url: URL(fileURLWithPath: Bundle.main.path(forResource: /*"kehillah_today", ofType: "html"*/"newhtmlsite", ofType:"html")!)))
////
////        webView.load(URLRequest(url: URL(fileURLWithPath: Bundle.main.path(forResource: /*"kehillah_today", ofType: "html"*/"testingrn", ofType:"html")!)))
////
////        //webView.load(URLRequest(url: URL(fileURLWithPath: Bundle.main.path(forResource: "kehillah_today", ofType: "html")!)))
////
////    }
//    var vm: BaseWebViewVM
//
//    // Initialize with a view-model
//        init(viewModel: BaseWebViewVM) {
//            self.vm = viewModel
//        }
//
//    func makeUIView(context: Context) -> WKWebView {
//            return vm.webView
//        }
//
//        func updateUIView(_ uiView: WKWebView, context: Context) {
//        }
//
//        func makeCoordinator() -> Coordinator {
//            return Coordinator(viewModel: vm)
//        }
//
////    func makeUIView(context: Context)-> WKWebView {
////        webView
////    }
////    func updateUIView(_ uiView: WKWebView, context: Context) {
////    }
//}
//
//extension SwiftUIWebView {
//    class Coordinator: NSObject {
//        var viewModel: BaseWebViewVM
//
//        init(viewModel: BaseWebViewVM) {
//            self.viewModel = viewModel
//        }
//    }
//}


import SwiftUI
import WebKit

private func uiColorFromHex(_ hex: UInt32, alpha: CGFloat = 1.0) -> UIColor {
    let r = CGFloat((hex >> 16) & 0xFF) / 255.0
    let g = CGFloat((hex >> 8) & 0xFF) / 255.0
    let b = CGFloat(hex & 0xFF) / 255.0
    return UIColor(red: r, green: g, blue: b, alpha: alpha)
}
private func overscrollColor() -> UIColor {
    let isDark = UserDefaults.standard.bool(forKey: "DarkMode")

    let lightLavender = uiColorFromHex(0xEEEEFF)   // #EEEEFF
    let darkMirrored  = uiColorFromHex(0x111100)   // approx inverse of #EEEEFF

    return isDark ? darkMirrored : lightLavender
}


//private func setOverscrollBackground(_ webView: WKWebView) {
private func setOverscrollBackground(_ webView: WKWebView, color: UIColor) {

    /*
    let lavender = uiColorFromHex(0xEEEEFF)   // rgb(238,238,255)

    webView.isOpaque = false
    webView.backgroundColor = lavender
    webView.scrollView.backgroundColor = lavender
    
    // WKWebView has internal subviews that can show through during bounce.
    // Force them to match too.
    for subview in webView.scrollView.subviews {
        subview.backgroundColor = lavender
    }*/
//    let lavender = uiColorFromHex(0xEEEEFF)
//
//    func paint(_ view: UIView) {
//        view.backgroundColor = lavender
//        view.subviews.forEach(paint)
//    }
//
//    webView.isOpaque = false
//    paint(webView)
//    paint(webView.scrollView)
//        let isDark = UserDefaults.standard.bool(forKey: "DarkMode")
//
//        let lightLavender = uiColorFromHex(0xEEEEFF)   // rgb(238,238,255)
//        let darkMirrored  = uiColorFromHex(0x111100)   // approx inverse of #EEEEFF
//
//        let bg = isDark ? darkMirrored : lightLavender
//
//        func paint(_ view: UIView) {
//            view.backgroundColor = bg
//            view.subviews.forEach(paint)
//        }
//
//        webView.isOpaque = false
//        paint(webView)
//        paint(webView.scrollView)
        webView.isOpaque = false
        webView.backgroundColor = color

        let scrollView = webView.scrollView
        scrollView.backgroundColor = color

        // Paint scroll container subviews (covers rubber-band gaps)
        for subview in scrollView.subviews {
            subview.backgroundColor = color
        }
    }



struct SwiftUIWebView: UIViewRepresentable {
    typealias UIViewType = WKWebView
    
    var vm: BaseWebViewVM
    init(viewModel: BaseWebViewVM) {
        self.vm = viewModel
    }
    
    func makeUIView(context: Context) -> WKWebView {
        let userContentController = vm.webView
            .configuration
            .userContentController
        
        // Clear all message handlers, if any
        userContentController.removeAllScriptMessageHandlers()

        // Message handler without reply
        userContentController.add(context.coordinator,
                                  name: "fromWebPage")

        // Message handlers with reply
        userContentController.addScriptMessageHandler(context.coordinator,
                                                      contentWorld: WKContentWorld.page,
                                                      name: "getData")
        // Message handlers with reply
        userContentController.addScriptMessageHandler(context.coordinator,
                                                      contentWorld: WKContentWorld.page,
                                                      name: "getData2")
        
        // Message handlers without reply
        userContentController.add(context.coordinator, name: "DarkMode")
        
        if vm.injectMessageListener {
            injectJS(userContentController)
        }

        // Handle alert
        vm.webView.uiDelegate = context.coordinator
        // Critical: stop iOS from pushing content below the top safe area
        vm.webView.scrollView.contentInsetAdjustmentBehavior = .never
        vm.webView.scrollView.contentInset = .zero
        vm.webView.scrollView.scrollIndicatorInsets = .zero
        setOverscrollBackground(vm.webView, color: overscrollColor())


        
        return vm.webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        setOverscrollBackground(uiView, color: overscrollColor())
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(viewModel: vm)
    }
    
    func injectJS(_ userContentController: WKUserContentController) {
        // Define message event listener.
        //
        // Note that there is no need to include the <script> HTML element
        let msgEventListener = """
window.addEventListener("message", (event) => {
    // Sanitize incoming message
    var content = event.data.replace(/</g, "&lt;").replace(/>/g, "&gt;")
    document.getElementById("message").innerHTML = content
})
"""

        // Inject event listener
        userContentController.addUserScript(WKUserScript(source: msgEventListener,
                                                         injectionTime: .atDocumentEnd,
                                                         forMainFrameOnly: false))
    }
}


extension SwiftUIWebView {
    class Coordinator: NSObject, WKUIDelegate,
                        WKScriptMessageHandler,
                        WKScriptMessageHandlerWithReply {
        var viewModel: BaseWebViewVM
        
        init(viewModel: BaseWebViewVM) {
            self.viewModel = viewModel
        }
        
        // MARK: - WKUIDelegate webView() functions
        func webView(_ webView: WKWebView,
                     runJavaScriptAlertPanelWithMessage message: String,
                     initiatedByFrame frame: WKFrameInfo,
                     completionHandler: @escaping () -> Void) {
            viewModel.webPanel(message: message,
                               alertCompletionHandler: completionHandler)
        }
        
        func webView(_ webView: WKWebView,
                     runJavaScriptConfirmPanelWithMessage message: String,
                     initiatedByFrame frame: WKFrameInfo,
                     completionHandler: @escaping (Bool) -> Void) {
            viewModel.webPanel(message: message,
                               confirmCompletionHandler: completionHandler)
        }
        
        func webView(_ webView: WKWebView,
                     runJavaScriptTextInputPanelWithPrompt prompt: String,
                     defaultText: String?,
                     initiatedByFrame frame: WKFrameInfo,
                     completionHandler: @escaping (String?) -> Void) {
            viewModel.webPanel(message: prompt,
                               promptCompletionHandler: completionHandler,
                               defaultText: defaultText)
        }

        // MARK: - WKScriptMessageHandler delegate function
        func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
            self.viewModel.messageFrom(fromHandler: message.name,
                                       message: message.body)
        }

        func userContentController(_ userContentController: WKUserContentController,
                                   didReceive message: WKScriptMessage,
                                   replyHandler: @escaping (Any?, String?) -> Void) {
            do {
                let returnValue = try self.viewModel.messageFromWithReply(fromHandler: message.name,
                                                                          message: message.body)
                
                replyHandler(returnValue, nil)
            } catch WebViewErrors.GenericError {
                replyHandler(nil, "A generic error")
            } catch WebViewErrors.ErrorWithValue(let value) {
                replyHandler(nil, "Error with value: \(value)")
            } catch {
                replyHandler(nil, error.localizedDescription)
            }
        }
    }
}
struct SwiftUIWebView_Previews: PreviewProvider {
    static let vm = LocalWebViewVM(webResource: "index.html")
    
    static var previews: some View {
        SwiftUIWebView(viewModel: vm)
            .onAppear(perform: vm.loadWebPage)
    }
}
