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
    @State private var account = Account(httpClient: HTTPClient.shared)
    @State private var faculty = Faculty(httpClient: HTTPClient.shared)
    
    var body: some Scene {
        WindowGroup {
            //NavigationStack(path: $routes) {
                HomeScreen()
              //      .environment(\.navigate) { route in
               //         routes.append(route)
               //     }
                    .environment(\.showMessage) { messageType in
                        messageWrapper = MessageWrapper(messageType: messageType)
                    }
//                    .withRouting()
  //          }
            .environment(account)
            .environment(faculty)
            .overlay(alignment: .bottom) {
                if messageWrapper != nil {
                    MessageView(messageWrapper: $messageWrapper)
                }
            }
        }
    }
}
