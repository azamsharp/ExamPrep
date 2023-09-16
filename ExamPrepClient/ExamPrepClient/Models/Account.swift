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
    
    private var httpClient: HTTPClient
    
    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }
    
    func register(email: String, password: String) async throws -> RegistrationResponse {
        
        let registrationData = ["email": email, "password": password]
        let body = try JSONEncoder().encode(registrationData)
        
        let resource = Resource(url: APIConstants.endpointURL(for: .register), method: .post(body), modelType: RegistrationResponse.self)
        return try await httpClient.load(resource)
    }
    
}
