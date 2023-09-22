//
//  FacultyMenuView.swift
//  ExamPrepClient
//
//  Created by Mohammad Azam on 9/20/23.
//

import SwiftUI

enum FacultyRoutes: Int, Hashable, CaseIterable, Identifiable {
    
    case courses
    case students
    case exams
    
    var id: Int {
        rawValue
    }
}

extension FacultyRoutes {
    
    var title: String {
        switch self {
            case .courses:
                return "Courses"
            case .students:
                return "Students"
            case .exams:
                return "Exams"
        }
    }
    
    var icon: String {
        switch self {
            case .courses:
                return "brain.head.profile"
            case .students:
                return "graduationcap.fill"
            case .exams:
                return "testtube.2"
        }
    }
}

struct FacultyMenuView: View {
    
    var body: some View {
        VStack {
            List {
                ForEach(FacultyRoutes.allCases) { item in
                    NavigationLink(value: item) {
                        HStack {
                            Image(systemName: item.icon)
                            Text(item.title)
                        }
                    }
                }
            }
        }
        
    }
}

#Preview {
    FacultyMenuView()
}
