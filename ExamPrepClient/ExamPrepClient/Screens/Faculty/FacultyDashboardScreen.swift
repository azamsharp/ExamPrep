//
//  FacultyDashboard.swift
//  ExamPrepClient
//
//  Created by Mohammad Azam on 9/17/23.
//

import SwiftUI

struct FacultyDashboardScreen: View {
    
    @Environment(\.navigate) private var navigate
    @Environment(Faculty.self) private var faculty
    
    @State private var facultyRoutes: [FacultyRoutes] = []
    
    var body: some View {
        
        NavigationStack {
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
            .navigationTitle("Dashboard")
            .navigationDestination(for: FacultyRoutes.self) { item in
                switch item {
                    case .courses:
                        CourseListScreen()
                    case .exams:
                        Text("Add Exams")
                    case .students:
                        Text("Students")
                    case .signout:
                        Text("Signout")
                }
            }
        }
    }
}

#Preview {
    FacultyDashboardScreen()
        .environment(Faculty(httpClient: HTTPClient.shared))
}
