//
//  WithRouting.swift
//  ExamPrepClient
//
//  Created by Mohammad Azam on 9/16/23.
//

import Foundation
import SwiftUI

struct WithRouting: ViewModifier {
    
    func body(content: Content) -> some View {
        content.navigationDestination(for: Route.self) { route in
            switch route {
                case .login:
                    LoginScreen()
                case .register:
                    RegistrationScreen()
                case .dashboard:
                    Text("Dashboard")
            }
        }
    }
}
