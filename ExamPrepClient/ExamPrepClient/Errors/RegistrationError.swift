//
//  RegistrationError.swift
//  ExamPrepClient
//
//  Created by Mohammad Azam on 9/15/23.
//

import Foundation

enum RegistrationError: LocalizedError {
    
    case emailAlreadyRegistered
    
    var errorDescription: String? {
        switch self {
            case .emailAlreadyRegistered:
                return "Email is already registered."
        }
    }
}
