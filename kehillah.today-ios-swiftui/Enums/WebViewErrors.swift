//
//  WebViewErrors.swift
//  kehillah.today-ios-swiftui
//
//  Created by Ovlic B on 8/22/23.
//

import Foundation

enum WebViewErrors: Error {
    case ErrorWithValue(value: Int)
    case GenericError
}
