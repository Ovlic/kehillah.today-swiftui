//
//  LocalWebViewVM.swift
//  kehillah.today-ios-swiftui
//
//  Created by Ovlic B on 8/22/23.
//

// From https://medium.com/@yeeedward/messaging-between-wkwebview-and-native-application-in-swiftui-e985f0bfacf

import Foundation

class LocalWebViewVM: BaseWebViewVM {
    private func processWebResource(webResource: String) -> (inDirectory: String,
                                                             fileName: String,
                                                             fileExtension: String) {
        var wr = webResource
        
        if #available(iOS 16.0, *) {
            if wr.starts(with: /\//) {
                // Remove leading "/"
                wr.remove(at: wr.startIndex)
            }
        } else {
            // Fallback on earlier versions
            if !wr.caseInsensitiveHasPrefix("///") {
                // Remove leading "/"
                wr.remove(at: wr.startIndex)
            }
        }
        
//        if #available(iOS 16.0, *) {
//            if !wr.starts(with: /Web\//) {
//                // Prepend "Web/"
//                wr = "Web/" + wr
//            }
//        } else {
//            // Fallback on earlier versions
//            if !wr.caseInsensitiveHasPrefix("///") {
//                // Prepend "Web/"
//                wr = "Web/" + wr
//            }
//        }
        
        // Extract path, file name, and file extension. NSString provides
        // easier solution
        let nswr = NSString(string: wr)

        let pathName = nswr.deletingLastPathComponent
        let fileExtension = nswr.pathExtension
        //if #available(iOS 16.0, *) {
        //    let fileName = nswr.lastPathComponent.replacing(".\(fileExtension)", with: "")
        //} else {
            // Fallback on earlier versions
            let fileName = nswr.lastPathComponent.replacingOccurrences(of: ".\(fileExtension)", with: "")
        //}
        
        return (inDirectory: pathName,
                fileName: fileName,
                fileExtension: fileExtension)
    }

    override func loadWebPage() {
        if let webResource = webResource {
            let (inDirectory,
                 fileName,
                 fileExtension) = processWebResource(webResource: webResource)

            guard let filePath = Bundle.main.path(forResource: fileName,
                                                  ofType: fileExtension,
                                                  inDirectory: inDirectory) else {
                print(webResource)
                print("Bad path")
                print(fileName)
                print(fileExtension)
                print(inDirectory)
                return
            }

            print(filePath)
            let url = URL(fileURLWithPath: Bundle.main.path(forResource: fileName, ofType: fileExtension)!)

            webView.loadFileURL(url, allowingReadAccessTo: url)
        }
    }
}

extension String {
    func caseInsensitiveHasPrefix(_ prefix: String) -> Bool {
        return lowercased().hasPrefix(prefix.lowercased())
    }
}
