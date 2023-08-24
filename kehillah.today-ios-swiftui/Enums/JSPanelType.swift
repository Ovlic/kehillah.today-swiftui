//
//  JSPanelType.swift
//  kehillah.today-ios-swiftui
//
//  Created by Ovlic B on 8/22/23.
//

// From https://medium.com/@yeeedward/messaging-between-wkwebview-and-native-application-in-swiftui-e985f0bfacf

import Foundation

enum JSPanelType {
    case alert
    case confirm
    case prompt
    
    var description: String {
        switch self {
        case .alert:
            return "Alert"
        case .confirm:
            return "Confirm"
        case .prompt:
            return "Prompt"
        }
    }
}
