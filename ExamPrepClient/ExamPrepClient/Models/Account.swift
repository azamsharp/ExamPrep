//
//  Account.swift
//  ExamPrepClient
//
//  Created by Mohammad Azam on 9/15/23.
//

import Foundation
import Observation

enum LoginError: LocalizedError {
    
    case invalidCredentials
    
    var errorDescription: String? {
        switch self {
            case .invalidCredentials:
                return "Invalid credentials."
        }
    }
}

@Observable
class Account {
    
    var role: Role = .student
    private var httpClient: HTTPClient
    
    var isLoggedIn: Bool = false
    
    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }
    
    func loadRoles() async throws -> [Role] {
        let resource = Resource(url: APIConstants.endpointURL(for: .roles), modelType: [Role].self)
        return try await httpClient.load(resource)
    }
    
    /*
    enum JSON: String, Codable {
        case email
        case password
        
        var key: String {
            switch self {
                case .email:
                    return "email"
                case .password:
                    return "password"
            }
        }
    } */
    
    struct JSON {
        struct Keys {
            static let email = "email"
            static let password = "password"
        }
    }
    
    struct LoginRequest: Codable {
        let email: String
        let password: String
    }
    
    
    func login(email: String, password: String) async throws  {
       
        //let loginData = ["email": email, "password": password]
        // encode login data
        // perform HTTP POST request
        
        let loginData = LoginRequest(email: email, password: password)
        // encode login data
        // perform HTTP POST request
        
        
        //let loginData = [JSON.Keys.email: email, JSON.Keys.password: password]
        // encode login data
        // perform HTTP POST request
        
        let body = try JSONEncoder().encode(loginData)
        
        let resource = Resource(url: APIConstants.endpointURL(for: .login), method: .post(body), modelType: LoginResponse.self)
        do {
            let response = try await httpClient.load(resource)
            if response.success {
                // get the token
                if let token = response.token, let exp = response.exp, let role = response.role {
                    // save the token in user defaults
                    UserDefaults.standard.setValue(token, forKey: "jwt")
                    UserDefaults.standard.setValue(exp, forKey: "exp")
                    self.role = role
                    self.isLoggedIn = true 
                }
            } else {
                print(response.message ?? "")
                throw LoginError.invalidCredentials
            }
            
        } catch {
            throw error
        }
    }
    
    func register(email: String, password: String, role: Role) async throws -> RegistrationResponse  {
        
        let registrationRequest = RegistrationRequest(email: email, password: password, roleId: role.id)
        let body = try JSONEncoder().encode(registrationRequest)
        let resource = Resource(url: APIConstants.endpointURL(for: .register), method: .post(body), modelType: RegistrationResponse.self)
        return try await httpClient.load(resource)
    }
    
}
