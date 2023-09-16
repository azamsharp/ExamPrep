//
//  ShowErrorKey.swift
//  ExamPrepClient
//
//  Created by Mohammad Azam on 9/15/23.
//

import Foundation
import SwiftUI 

enum MessageType {
    case error(Error, String)
    case info(String)
}

struct ShowMessageKey: EnvironmentKey {
    static var defaultValue: (MessageType) -> Void = { _ in }
}

extension EnvironmentValues {
    var showMessage: (MessageType) -> Void {
        get { self[ShowMessageKey.self] }
        set { self[ShowMessageKey.self] = newValue }
    }
}
