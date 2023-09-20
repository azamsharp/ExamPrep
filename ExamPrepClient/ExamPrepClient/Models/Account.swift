//
//  Account.swift
//  ExamPrepClient
//
//  Created by Mohammad Azam on 9/15/23.
//

import Foundation
import Observation

@Observable
class Account {
    
    var role: Role = .student
    var message: String = ""
    private var httpClient: HTTPClient
    
    var isLoggedIn: Bool {
        UserDefaults.standard.string(forKey: "jwt") != nil
    }
    
    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }
    
    func loadRoles() async throws -> [Role] {
        let resource = Resource(url: APIConstants.endpointURL(for: .roles), modelType: [Role].self)
        return try await httpClient.load(resource)
    }
    
    func login(email: String, password: String) async throws  {
        
        let loginData = ["email": email, "password": password]
        let body = try JSONEncoder().encode(loginData)
        
        let resource = Resource(url: APIConstants.endpointURL(for: .login), method: .post(body), modelType: LoginResponse.self)
        let response = try await httpClient.load(resource)
        
        if response.success {
            // get the token
            if let token = response.token, let exp = response.exp, let role = response.role {
                // save the token in user defaults
                UserDefaults.standard.setValue(token, forKey: "jwt")
                UserDefaults.standard.setValue(exp, forKey: "exp")
                self.role = role
            }
        } else {
            message = response.message ?? ""
        }
        
    }
    
    func register(email: String, password: String, role: Role) async throws -> RegistrationResponse  {
        
        let registrationRequest = RegistrationRequest(email: email, password: password, roleId: role.id)
        let body = try JSONEncoder().encode(registrationRequest)
        let resource = Resource(url: APIConstants.endpointURL(for: .register), method: .post(body), modelType: RegistrationResponse.self)
        return try await httpClient.load(resource)
    }
    
}
