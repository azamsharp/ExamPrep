//
//  AddCourseScreen.swift
//  ExamPrepClient
//
//  Created by Mohammad Azam on 9/24/23.
//

import SwiftUI

struct AddCourseScreen: View {
    
    @Environment(\.showMessage) private var showMessage
    @Environment(\.dismiss) private var dismiss
    @Environment(Faculty.self) private var faculty
    
    @State private var name: String = ""
    @State private var description: String = ""
    
    @State private var saving: Bool = false
    
    private var isFormValid: Bool {
        !name.isEmptyOrWhitespace && !description.isEmptyOrWhitespace
    }
    
    private func createCourse() async {
        do {
            try await faculty.createCourse(name: name, description: description)
        } catch {
            showMessage(.error(error))
        }
    }
    
    var body: some View {
        Form {
            TextField("Name", text: $name)
            TextField("Description", text: $description)
            Button("Save") {
               saving = true
            }.disabled(!isFormValid)
        }
        .task(id: saving, {
            if saving {
                await createCourse()
                saving = false
                dismiss()
            }
        })
        .navigationTitle("Add course")
        .overlay {
            if saving {
                ProgressView()
            }
        }
    }
}

#Preview {
    NavigationStack {
        AddCourseScreen()
            .environment(Faculty(httpClient: HTTPClient.shared))
            .withMessageWrapper()
    }
}
