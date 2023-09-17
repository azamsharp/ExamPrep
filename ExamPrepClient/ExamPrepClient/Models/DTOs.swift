//
//  SuccessResponse.swift
//  ExamPrepClient
//
//  Created by Mohammad Azam on 9/15/23.
//

import Foundation

struct RegistrationRequest: Codable {
    let email: String
    let password: String
    let roleId: Int 
}

struct RegistrationResponse: Codable {
    let success: Bool 
    var message: String? = ""
}

struct LoginResponse: Codable {
    let success: Bool
    let message: String?
    let token: String?
    let exp: Double? 
}

struct Role: Codable, Identifiable , Hashable {
    let id: Int
    let name: String
}
