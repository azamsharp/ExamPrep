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
            TabView {
                NavigationStack {
                    FacultyMenuView()
                        .navigationTitle("Dashboard")
                        .navigationDestination(for: FacultyRoutes.self) { item in
                            switch item {
                                case .courses:
                                    CourseListScreen() 
                                case .exams:
                                    Text("Add Exams")
                                case .students:
                                    Text("Students")
                                    
                            }
                        }
                }.tabItem {
                    Label("Home", systemImage: "house")
                }
              
                Text("Inbox")
                    .tabItem {
                        Label("Inbox", systemImage: "tray.fill")
                    }
                Text("Settings")
                    .tabItem {
                        Label("Settings", systemImage: "gearshape.fill")
                    }
                
            }
    }
}

#Preview {
        FacultyDashboardScreen()
            .environment(Faculty(httpClient: HTTPClient.shared))
}
