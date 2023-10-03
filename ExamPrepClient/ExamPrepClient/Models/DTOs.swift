//
//  SuccessResponse.swift
//  ExamPrepClient
//
//  Created by Mohammad Azam on 9/15/23.
//

import Foundation


struct StudentCourseEnrollResponse: Codable {
    let success: Bool
    let message: String?
    let enrollment: Enrollment?
}

struct Enrollment: Codable {
    let id: Int
    let enrollmentDate: Date
    let course: Course
}

struct CourseCreateResponse: Codable {
    let success: Bool
    let course: Course?
    let message: String?
}

struct Course: Codable, Identifiable {
    let id: Int?
    let name: String
    let description: String 
    let courseCode: String
    let enrollmentCount: Int? 
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
