//
//  StudentMenuView.swift
//  ExamPrepClient
//
//  Created by Mohammad Azam on 9/26/23.
//

import SwiftUI

enum StudentRoutes: Int, Hashable, CaseIterable, Identifiable {
    
    case courses
    case enroll
    
    var id: Int {
        rawValue
    }
}

extension StudentRoutes {
    
    var title: String {
        switch self {
            case .courses:
                return "Courses"
            case .enroll:
                return "Enroll"
        }
    }
    
    var icon: String {
        switch self {
            case .courses:
                return "brain.head.profile"
            case .enroll:
                return "graduationcap.fill"
        }
    }
}

struct StudentMenuView: View {
    var body: some View {
        VStack {
            List {
                ForEach(StudentRoutes.allCases) { item in
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
    StudentMenuView()
}
