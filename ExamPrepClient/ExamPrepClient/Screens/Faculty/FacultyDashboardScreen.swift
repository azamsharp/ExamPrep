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
        Text("Faculty Dashboard")
    }
}

#Preview {
    FacultyDashboardScreen()
        .environment(Faculty(httpClient: HTTPClient.shared))
}
