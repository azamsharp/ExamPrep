//
//  FacultyDashboard.swift
//  ExamPrepClient
//
//  Created by Mohammad Azam on 9/17/23.
//

import SwiftUI

struct FacultyDashboardScreen: View {
    
    @Environment(\.showMessage) private var showMessage
    @Environment(Faculty.self) private var faculty
    @State private var isPresented: Bool = false
    
    var body: some View {
        
        NavigationStack {
            List(faculty.courses) { course in
                NavigationLink {
                    CourseDetailScreen(course: course)
                } label: {
                    FacultyCourseView(course: course)
                }
            }
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
            .navigationTitle("Dashboard")
        }
    }
}

struct FacultyCourseView: View {
    
    let course: Course
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(course.name)
                    .font(.title3)
                    .fontWeight(.bold)
                Text(course.description)
                    .font(.caption2)
                Text(course.courseCode)
                    .font(.headline)
                    .foregroundStyle(.gray)
                if let enrollmentCount = course.enrollmentCount, enrollmentCount > 0 {
                    Text("^[\(enrollmentCount) Student](inflect: true)")
                        .font(.caption2)
                }
            }
            
        }
    }
}


#Preview {
    FacultyDashboardScreen()
        .environment(Faculty(httpClient: HTTPClient.shared))
        .withMessageWrapper()
}
