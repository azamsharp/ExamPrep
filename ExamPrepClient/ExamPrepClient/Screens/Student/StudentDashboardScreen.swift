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
                StudentCourseListScreen()
                    .navigationTitle("Dashboard")
                   
            }
            .tabItem {
            Label("Home", systemImage: "house")
            }
            
            Text("Grades")
                .tabItem {
                    Label("Grades", systemImage: "chart.bar.xaxis.ascending")
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
