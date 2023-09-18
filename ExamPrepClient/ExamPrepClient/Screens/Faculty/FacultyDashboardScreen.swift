//
//  FacultyDashboard.swift
//  ExamPrepClient
//
//  Created by Mohammad Azam on 9/17/23.
//

import SwiftUI

struct FacultyDashboardScreen: View {
    
    @Environment(Faculty.self) private var faculty 
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    FacultyDashboardScreen()
        .environment(Faculty(httpClient: HTTPClient.shared))
}
