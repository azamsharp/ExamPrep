//
//  RegistrationScreen.swift
//  ExamPrepClient
//
//  Created by Mohammad Azam on 9/11/23.
//

import SwiftUI

struct LoginScreen: View {
    
    @Environment(\.showMessage) private var showMessage
    @Environment(\.navigate) private var navigate
    @Environment(Account.self) private var account
    
    @State private var email: String = "azamsharp@gmail.com"
    @State private var password: String = "password123"
    
    private var isFormValid: Bool {
        return !email.isEmptyOrWhitespace && !password.isEmptyOrWhitespace && email.isEmail
    }
    
    private func login() async {
       
        do {
            try await account.login(email: email, password: password)
            
            if account.isLoggedIn {
                switch account.role {
                    case .faculty:
                        navigate(.facultyDashboard)
                    case .student:
                        navigate(.studentDashboard)
                }
            } else {
                showMessage(.info(account.message))
            }
            
        } catch {
            showMessage(.error(error, MessageConstants.unableToProcessRequest))
        }
    }
    
    var body: some View {
        Form {
            
            TextField("Email", text: $email)
                .textInputAutocapitalization(.never)
            SecureField("Password", text: $password)
            
            Button(action: {
                
                Task {
                    await login()
                }
                
            }, label: {
                Text("Login")
                    .frame(maxWidth: .infinity)
            }).buttonStyle(.borderedProminent)
            .disabled(!isFormValid)
            
        }.navigationTitle("Login")
            
    }
}

struct LoginContainerScreen: View {
    var body: some View {
        LoginScreen()
            .environment(Account(httpClient: HTTPClient.shared))
    }
}

#Preview {
    NavigationStack {
        LoginContainerScreen()
    }
}
