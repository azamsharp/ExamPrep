//
//  CourseListScreen.swift
//  ExamPrepClient
//
//  Created by Mohammad Azam on 9/22/23.
//

import SwiftUI

struct CourseListScreen: View {
    
    @Environment(Faculty.self) private var faculty
    
    var body: some View {
        List(faculty.courses) { course in
            VStack(alignment: .leading) {
                Text(course.name)
                    .font(.headline)
                Text(course.description)
                    .font(.caption2)
            }
        }
        .navigationTitle("Courses")
        .task {
                do {
                    try await faculty.loadCourses()
                } catch {
                    print(error.localizedDescription)
                }
            }
    }
}

#Preview {
    NavigationStack {
        CourseListScreen()
            .environment(Faculty(httpClient: HTTPClient.shared))
    }
}
