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
                    .environment(Account(httpClient: HTTPClient.shared))
                    .environment(\.navigate) { route in
                        routes.append(route)
                    }
                    .environment(\.showMessage) { messageType in
                        messageWrapper = MessageWrapper(messageType: messageType)
                    }
                    .navigationDestination(for: Route.self) { route in
                        switch route {
                            case .login:
                                Text("Login")
                            case .register:
                                Text("Register")
                            case .dashboard:
                                Text("Dashboard")
                        }
                    }
            }
            .overlay(alignment: .bottom) {
                if let messageWrapper {
                    MessageView(messageWrapper: messageWrapper)
                }
            }
            /*
            .sheet(item: $messageWrapper) { messageWrapper in
                VStack {
                    Spacer()
                    MessageView(messageWrapper: messageWrapper)
                        .presentationDetents([.medium])
                        .presentationBackgroundInteraction(.enabled(upThrough: .medium))
                }
            }.scrollContentBackground(.hidden)
             */
               
        }
    }
}
