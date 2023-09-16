//
//  RegistrationScreen.swift
//  ExamPrepClient
//
//  Created by Mohammad Azam on 9/11/23.
//

import SwiftUI

struct RegistrationScreen: View {
    
    @Environment(\.showMessage) private var showMessage
    @Environment(\.navigate) private var navigate
    @Environment(Account.self) private var account
    
    @State private var email: String = "azamsharp@gmail.com"
    @State private var password: String = "password123"
    @State private var selectedRole: Role = .student
    
    private var isFormValid: Bool {
        return !email.isEmptyOrWhitespace && !password.isEmptyOrWhitespace && email.isEmail
    }
    
    private func register() async {
       
        do {
            let registrationResponse = try await account.register(email: email, password: password)
            if registrationResponse.success {
                navigate(.dashboard)
            } else {
                if let message = registrationResponse.message {
                    showMessage(.info(message))
                }
            }
            
        } catch {
            showMessage(.error(error, MessagesConstants.errorRegistration))
        }
    }
    
    var body: some View {
        Form {
            Picker("Role", selection: $selectedRole) {
                ForEach(Role.allCases) { role in
                    Text(role.title)
                        .tag(role)
                }
            }.pickerStyle(.segmented)
            TextField("Email", text: $email)
            SecureField("Password", text: $password)
            
            Button(action: {
                
                Task {
                    await register()
                }
                
            }, label: {
                Text("Register")
                    .frame(maxWidth: .infinity)
            }).buttonStyle(.borderedProminent)
            .disabled(!isFormValid)
            
        }.navigationTitle("Registration")
            
    }
}

struct RegistrationContainerScreen: View {
    var body: some View {
        RegistrationScreen()
            .environment(Account(httpClient: HTTPClient.shared))
    }
}

#Preview {
    
    NavigationStack {
        RegistrationContainerScreen()
    }
}
