//
//  StudentDashboardScreen.swift
//  ExamPrepClient
//
//  Created by Mohammad Azam on 9/25/23.
//

import SwiftUI

struct StudentDashboardScreen: View {
    var body: some View {
        TabView {
            NavigationStack {
                StudentMenuView()
                    .navigationTitle("Dashboard")
                    .navigationDestination(for: StudentRoutes.self) { route in
                        switch route {
                            case .courses:
                                StudentCourseListScreen()
                            case .enroll:
                                EnrollCourseScreen()
                        }
                    }
                   
            }
            .tabItem {
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
    StudentDashboardScreen()
}
