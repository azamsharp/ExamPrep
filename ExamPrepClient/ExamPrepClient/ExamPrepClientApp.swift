//
//  ExamPrepClientApp.swift
//  ExamPrepClient
//
//  Created by Mohammad Azam on 9/11/23.
//

import SwiftUI


@main
struct ExamPrepClientApp: App {
    
    @State private var messageWrapper: MessageWrapper?
    @State private var routes: [Route] = []
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $routes) {
                RegistrationScreen()
                    .environment(\.navigate) { route in
                        routes.append(route)
                    }
                    .environment(\.showMessage) { messageType in
                        messageWrapper = MessageWrapper(messageType: messageType)
                    }
                    .withRouting()
            }
            .environment(Account(httpClient: HTTPClient.shared))
            .overlay(alignment: .bottom) {
                if messageWrapper != nil {
                    MessageView(messageWrapper: $messageWrapper)
                }
            }
        }
    }
}
