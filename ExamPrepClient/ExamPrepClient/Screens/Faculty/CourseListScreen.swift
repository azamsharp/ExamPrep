//
//  CourseListScreen.swift
//  ExamPrepClient
//
//  Created by Mohammad Azam on 9/22/23.
//

import SwiftUI

struct CourseListScreen: View {
    
    @Environment(\.showMessage) private var showMessage
    @Environment(Faculty.self) private var faculty
    
    @State private var isPresented: Bool = false
    
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
                    showMessage(.error(error))
                }
            }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Add course") {
                    isPresented = true
                }
            }
        }.sheet(isPresented: $isPresented, content: {
            NavigationStack {
                AddCourseScreen()
            }
        })
    }
}

#Preview {
    NavigationStack {
        CourseListScreen()
            .environment(Faculty(httpClient: HTTPClient.shared))
            .withMessageWrapper()
    }
}
