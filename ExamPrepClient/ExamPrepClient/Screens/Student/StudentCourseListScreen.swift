//
//  StudentCourseListScreen.swift
//  ExamPrepClient
//
//  Created by Mohammad Azam on 9/25/23.
//

import SwiftUI

struct StudentCourseListScreen: View {
    
    @State private var isPresented: Bool = false
    
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    let courses: [String] = ["Math 100", "Math 101", "Linear Algebre 220", "Science 300"]
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.showMessage) private var showMessage
    @Environment(Student.self) private var student
    
    @State private var courseCode: String = ""
    @State private var enrolling: Bool = false
    
    private func enroll() async {
        do {
            try await student.enroll(courseCode: courseCode)
        } catch {
            showMessage(.error(error))
        }
    }
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, content: {
                ForEach(courses, id: \.self) { course in
                    Text(course)
                        .padding()
                        .frame(width: 150, height: 100)
                        .background(.orange)
                        .clipShape(RoundedRectangle(cornerRadius: 16.0, style: .continuous))
                        .foregroundStyle(.white)
                }
                
            })
        }.toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Enroll") {
                    isPresented = true
                }
            }
        }.sheet(isPresented: $isPresented, content: {
            VStack {
                Text("Enroll in a new course")
                    .font(.title3)
                TextField("Course code", text: $courseCode)
                    .textFieldStyle(.roundedBorder)
                    .presentationDetents([.fraction(0.25)])
                    .textInputAutocapitalization(.characters)
                    .padding()
                HStack {
                    Button("Cancel") {
                        isPresented = false
                    }
                    Button("Enroll") {
                        enrolling = true
                    }.task(id: enrolling) {
                        if enrolling {
                            await enroll()
                            enrolling = false
                            dismiss() 
                        }
                    }
                }
            }
        })
        .navigationTitle("My courses")
    }
}

#Preview {
    NavigationStack {
        StudentCourseListScreen()
            .environment(Student(httpClient: HTTPClient.shared))
            .withMessageWrapper()
        
    }
}

