//
//  CourseDetailScreen.swift
//  ExamPrepClient
//
//  Created by Mohammad Azam on 10/6/23.
//

import SwiftUI

struct CourseDetailScreen: View {
    
    let course: Course
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    CourseDetailScreen(course: Course(id: 1, name: "MATH 100", description: "Math", courseCode: "AAAA", enrollmentCount: 10))
}
