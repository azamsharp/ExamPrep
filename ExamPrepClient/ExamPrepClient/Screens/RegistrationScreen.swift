//
//  RegistrationScreen.swift
//  ExamPrepClient
//
//  Created by Mohammad Azam on 9/11/23.
//

import SwiftUI

struct RegistrationScreen: View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var selectedRole: Role = .student
    
    private var isFormValid: Bool {
        return !email.isEmptyOrWhitespace && !password.isEmptyOrWhitespace && email.isEmail
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
            TextField("Password", text: $password)
            
            Button(action: {
                
                // perform action
                
                
            }, label: {
                Text("Register")
                    .frame(maxWidth: .infinity)
            }).buttonStyle(.borderedProminent)
            .disabled(!isFormValid)
            
        }.navigationTitle("Registration")
            
    }
}

#Preview {
    NavigationStack {
        RegistrationScreen()
    }
}
