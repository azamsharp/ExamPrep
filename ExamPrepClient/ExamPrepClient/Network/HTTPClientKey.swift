//
//  HTTPClientKey.swift
//  ExamPrepClient
//
//  Created by Mohammad Azam on 9/15/23.
//

import Foundation
import SwiftUI

struct HTTPClientKey: EnvironmentKey {
    static let defaultValue = HTTPClient.shared
}

extension EnvironmentValues {
    var httpClient: HTTPClient {
        get { self[HTTPClientKey.self] }
        set { self[HTTPClientKey.self] = newValue }
    }
}

