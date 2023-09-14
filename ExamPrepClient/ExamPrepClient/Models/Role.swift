//
//  Role.swift
//  ExamPrepClient
//
//  Created by Mohammad Azam on 9/12/23.
//

import Foundation

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
