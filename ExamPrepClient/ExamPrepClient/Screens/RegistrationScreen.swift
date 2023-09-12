//
//  RegistrationScreen.swift
//  ExamPrepClient
//
//  Created by Mohammad Azam on 9/11/23.
//

import SwiftUI

enum Role: Int, CaseIterable, Identifiable {
    case faculty = 1
    case student = 2
    
    var id: Int {
        return self.rawValue
    }
}

extension Role {
    var title: String {
        switch self {
            case .faculty:
                return "Faculty"
            case .student:
                return "Student"
        }
    }
}

struct RegistrationScreen: View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var selectedRole: Role = .student
    
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
                // action
            }, label: {
                Text("Register")
                    .frame(maxWidth: .infinity)
            }).buttonStyle(.borderedProminent)
            
        }.navigationTitle("Registration")
            
    }
}

#Preview {
    NavigationStack {
        RegistrationScreen()
    }
}
