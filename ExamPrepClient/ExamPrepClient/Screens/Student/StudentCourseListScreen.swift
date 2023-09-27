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
    
    @State private var courseCode: String = ""
    
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
                    Button("Save") {
                        
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
    }
}
 
