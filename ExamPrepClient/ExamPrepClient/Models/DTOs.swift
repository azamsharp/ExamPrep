//
//  SuccessResponse.swift
//  ExamPrepClient
//
//  Created by Mohammad Azam on 9/15/23.
//

import Foundation

struct Course: Codable {
    let id: Int
    let name: String
    let classCode: String 
}

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
    let role: Role?
    
    private enum CodingKeys: String, CodingKey {
        case success
        case message
        case token
        case exp
        case role = "roleId"
    }
}


enum Role: Int, Codable, Identifiable {
    case student = 1
    case faculty = 2
    
    var id: Int {
        rawValue
    }
    
    var name: String {
        switch self {
            case .student:
                return "Student"
            case .faculty:
                return "Faculty"
        }
    }
}

/*
struct Role: Codable, Identifiable , Hashable {
    let id: Int
    let name: String
}

extension Role {
    
    var isFaculty: Bool {
        name == "Faculty"
    }
} */
