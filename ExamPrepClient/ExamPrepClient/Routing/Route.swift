//
//  Route.swift
//  ExamPrepClient
//
//  Created by Mohammad Azam on 9/15/23.
//

import Foundation
import SwiftUI

enum Route: Hashable {
    case register
    case login
    case facultyDashboard
    case studentDashboard
}

struct NavigateEnvironmentKey: EnvironmentKey {
    static var defaultValue: (Route) -> Void = { _ in }
}

extension EnvironmentValues {
    var navigate: (Route) -> Void {
        get { self[NavigateEnvironmentKey.self] }
        set { self[NavigateEnvironmentKey.self] = newValue }
    }
}
