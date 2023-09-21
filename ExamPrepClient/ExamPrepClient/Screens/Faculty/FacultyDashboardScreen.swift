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

        TabView {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
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
              
        } .navigationTitle("Dashboard")

    }
}

#Preview {
    NavigationStack {
        FacultyDashboardScreen()
            .environment(Faculty(httpClient: HTTPClient.shared))
    }
}
