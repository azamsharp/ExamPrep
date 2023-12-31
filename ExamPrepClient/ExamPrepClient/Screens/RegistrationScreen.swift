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
    @State private var selectedRole: Role? = nil
    @State private var registering: Bool = false
    @State private var roles: [Role] = []
    
    private var isFormValid: Bool {
        return !email.isEmptyOrWhitespace && !password.isEmptyOrWhitespace && email.isEmail
    }
    
    private func loadRoles() async {
        do {
            roles = try await account.loadRoles()
        } catch {
            showMessage(.error(error))
        }
    }
    
    private func register() async {
        do {
            
            guard let role = selectedRole else { return }
            
            let response = try await account.register(email: email, password: password, role: role)
            if response.success {
                navigate(.login)
            } else {
                showMessage(.info(response.message))
            }
        } catch {
            showMessage(.error(error))
        }
    }
    
    var body: some View {
        Form {
            
            Picker("Role", selection: $selectedRole) {
                ForEach(roles) { role in
                    Text(role.name)
                        .tag(Optional(role))
                }
            }.pickerStyle(.segmented)
            
            TextField("Email", text: $email)
            SecureField("Password", text: $password)
            
            Button(action: {
                registering = true
            }, label: {
                Text("Register")
                    .frame(maxWidth: .infinity)
            }).buttonStyle(.borderedProminent)
            .disabled(!isFormValid)
            .task(id: registering) {
                if registering {
                    await register()
                    registering = false
                }
            }
            
        }.navigationTitle("Registration")
            .task {
                await loadRoles()
                selectedRole = roles.first { $0.name == "Student" }
            }
    }
}

struct RegistrationContainerScreen: View {
    
    @State private var routes: [Route] = []
    
    var body: some View {
        NavigationStack(path: $routes) {
            RegistrationScreen()
                .environment(\.navigate) { route in
                    routes.append(route)
                }
                .withRouting()
        }.environment(Account(httpClient: HTTPClient.shared))
    }
}

#Preview {
    RegistrationContainerScreen()
}
