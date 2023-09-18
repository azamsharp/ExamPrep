//
//  HomeScreen.swift
//  ExamPrepClient
//
//  Created by Mohammad Azam on 9/17/23.
//

import SwiftUI

struct HomeScreen: View {
    
    @State private var selection: Selection = .register
    
    private enum Selection {
        case login
        case register
    }
    
    var body: some View {
        VStack {
            switch selection {
            case .login:
                LoginScreen()
            case .register:
                RegistrationScreen()
            }
            
            Button(selection == .register ? "Login": "Register") {
                withAnimation {
                    selection = selection == .register ? .login: .register
                }
            }
            
        }
    }
}

struct HomeScreenContainerScreen: View {
    
    @State private var routes: [Route] = []
    @State private var messageWrapper: MessageWrapper?
    
    var body: some View {
        NavigationStack(path: $routes) {
            HomeScreen()
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

#Preview {
    HomeScreenContainerScreen()
}
