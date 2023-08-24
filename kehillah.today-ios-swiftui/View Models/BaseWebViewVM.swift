//
//  BaseWebViewVM.swift
//  kehillah.today-ios-swiftui
//
//  Created by Ovlic B on 8/22/23.
//

// From https://medium.com/@yeeedward/messaging-between-wkwebview-and-native-application-in-swiftui-e985f0bfacf

import Foundation
import WebKit

class BaseWebViewVM: ObservableObject {
    @Published var webResource: String?
    var webView: WKWebView

    // MARK: - Properties for Javascript alert, confirm, and prompt dialog boxes
    @Published var showPanel: Bool = false
    var panelTitle: String = ""
    var panelType: JSPanelType? = nil
    
    var panelMessage: String = ""
        
    // Alert properties
    var alertCompletionHandler: () -> Void = {}

    // Confirm properties
    var confirmCompletionHandler: (Bool) -> Void = { _ in }

    // Prompt properties
    var promptInput: String = ""
    var promptCompletionHandler: (String?) -> Void = { _ in }
    
    // Message from web view
    @Published var messageFromWV: String = ""
    
    // Inject message listener
    var injectMessageListener: Bool = false

    init(webResource: String? = nil) {
        self.webResource = webResource
        
        self.webView = WKWebView(frame: .zero,
                                 configuration: WKWebViewConfiguration())
        
if #available(iOS 16.4, *) {
    #if DEBUG
        self.webView.isInspectable = true
    #endif
} else {
    // Fallback on earlier versions
    }
}
    
    func loadWebPage() {
        if let webResource = webResource {
            guard let url = URL(string: webResource) else {
                print("Bad URL")
                return
            }

            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
    
    /// Populate and activate alert dialog box
    /// - Parameters:
    ///   - message: Alert message
    ///   - completionHandler: Completion handler
    func webPanel(message: String,
                  alertCompletionHandler completionHandler: @escaping () -> Void) {
        self.panelTitle = JSPanelType.alert.description // "Alert"
        self.panelMessage = message
        self.alertCompletionHandler = completionHandler
        self.panelType = .alert
        self.showPanel = true
        print("\(panelTitle): \(panelMessage)")
    }

    func webPanel(message: String,
                  confirmCompletionHandler completionHandler: @escaping (Bool) -> Void) {
        self.panelTitle = JSPanelType.confirm.description
        self.panelMessage = message
        self.confirmCompletionHandler = completionHandler
        self.panelType = .confirm
        self.showPanel = true
    }
    
    func webPanel(message: String,
                  promptCompletionHandler completionHandler: @escaping (String?) -> Void,
                  defaultText: String? = nil) {
        self.panelTitle = JSPanelType.prompt.description
        self.panelMessage = message
        self.promptInput = defaultText ?? ""
        self.promptCompletionHandler = completionHandler
        self.panelType = .prompt
        self.showPanel = true
    }

    // MARK: - Functions for messaging
    
    func messageFrom(fromHandler: String, message: Any) {
        print("MessageFrom")
        if fromHandler == "DarkMode" {
            if message as! String == "false" {
                UserDefaults.standard.set(false, forKey: "DarkMode")
                print("Dark mode off")
                
            } else if message as! String == "true" {
                UserDefaults.standard.set(true, forKey: "DarkMode")
                print("Dark mode on")
                
            }
            self.messageFromWV = String(describing: message)

        } else {
            self.panelTitle = JSPanelType.alert.description // "Alert"
            self.panelMessage = String(describing: message)
            self.alertCompletionHandler = {}
            self.panelType = .alert
            self.showPanel = true
            self.messageFromWV = String(describing: message)
            print("\(panelTitle): \(panelMessage)")
        }
    }

        func messageFromWithReply(fromHandler: String, message: Any) throws -> String {
            self.messageFromWV = String(describing: message)
            print("Hiii")
            
            var returnValue: String = "Good"
            
            /*
             * This function can throw the follow exceptions:
             *
             * - WebViewErrors.GenericError
             * - WebViewErrors.ErrorWithValue(value: 99)
             */
            
            if fromHandler == "getData" {
                UserDefaults.standard.set(true, forKey: "DarkMode")
                returnValue = "{ data: \"It is good!\" }"
            } else if fromHandler == "getData2" {
                UserDefaults.standard.set(false, forKey: "DarkMode")
                returnValue = "{ data: \"It is good part 2!\" }"
                
            } else if fromHandler == "DarkMode" {
                if message as! String == "false" {
                    UserDefaults.standard.set(false, forKey: "DarkMode")
                    returnValue = "Set dark mode off!"
                } else if message as! String == "true" {
                    UserDefaults.standard.set(true, forKey: "DarkMode")
                    returnValue = "Set dark mode on!"
                }
            }
        
        return returnValue
    }
    
    func messageTo(message: String) {
        let escapedMessage = message.replacingOccurrences(of: "\"", with: "\\\"")
        
        let js = "window.postMessage(\"\(escapedMessage)\", \"*\")"
        self.webView.evaluateJavaScript(js) { (result, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}
