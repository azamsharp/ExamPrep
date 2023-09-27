//
//  EnrollCourseScreen.swift
//  ExamPrepClient
//
//  Created by Mohammad Azam on 9/25/23.
//

import SwiftUI

struct EnrollCourseScreen: View {
    
    @Environment(\.showMessage) private var showMessage
    @Environment(\.httpClient) private var httpClient
    @State private var search: String = ""
    
    @State private var availableCourses: [Course] = []
    @State private var filteredCourses: [Course] = []
    
    private func loadAvailableCourses() async {
        let resource = Resource(url: APIConstants.endpointURL(for: .availableCourses), modelType: [Course].self)
        
        do {
            availableCourses = try await httpClient.load(resource)
        } catch {
            showMessage(.error(error))
        }
    }
    
    var body: some View {
        List(filteredCourses) { course in
            VStack(alignment: .leading) {
                Text(course.name)
                    .font(.headline)
                Text(course.description)
            }
        }
        .searchable(text: $search)
        .onChange(of: search, {
            filteredCourses = search.isEmpty ? availableCourses: availableCourses.filter { $0.name.localizedStandardContains(search) }
        })
        .task {
            await loadAvailableCourses()
            filteredCourses = availableCourses
        }.navigationTitle("Enroll")
    }
}

#Preview {
    NavigationStack {
        EnrollCourseScreen()
            .environment(\.httpClient, HTTPClient.shared)
            .withMessageWrapper()
    }
}
