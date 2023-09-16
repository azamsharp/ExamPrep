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
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                RegistrationScreen()
                    .environment(Account(httpClient: HTTPClient.shared))
                    .environment(\.showMessage) { messageType in
                        messageWrapper = MessageWrapper(messageType: messageType)
                    }
            }.sheet(item: $messageWrapper) { messageWrapper in
                    MessageView(messageWrapper: messageWrapper)
                    .presentationDetents([.fraction(0.1)])
                    .presentationBackgroundInteraction(.enabled(upThrough: .fraction(0.1)))
                }.scrollContentBackground(.hidden)
        }
    }
}
