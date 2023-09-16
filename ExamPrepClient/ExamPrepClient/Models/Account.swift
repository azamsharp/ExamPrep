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
    
    var isLoggedIn: Bool = false
    var error: Error? = nil
    
    private var httpClient: HTTPClient
    
    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }
    
    func login(email: String, password: String) async throws -> LoginResponse {
        
        let loginData = ["email": email, "password": password]
        let body = try JSONEncoder().encode(loginData)
        
        let resource = Resource(url: APIConstants.endpointURL(for: .login), method: .post(body), modelType: LoginResponse.self)
        let response = try await httpClient.load(resource)
        
        if response.success {
            // get the token
            if let token = response.token, let exp = response.exp {
                // save the token in user defaults
                UserDefaults.standard.setValue(token, forKey: "jwt")
                UserDefaults.standard.setValue(exp, forKey: "exp")
                isLoggedIn = true
            }
        }
        
        return response
    }
    
    func register(email: String, password: String) async throws -> RegistrationResponse  {
        
        let registrationData = ["email": email, "password": password]
        
        let body = try JSONEncoder().encode(registrationData)
        let resource = Resource(url: APIConstants.endpointURL(for: .register), method: .post(body), modelType: RegistrationResponse.self)
        return try await httpClient.load(resource)
    }
    
}
