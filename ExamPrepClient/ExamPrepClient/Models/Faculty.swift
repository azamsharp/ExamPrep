//
//  Faculty.swift
//  ExamPrepClient
//
//  Created by Mohammad Azam on 9/17/23.
//

import Foundation
import Observation

// aggregate root to handle all Faculty operations
@Observable
class Faculty {
    
    var httpClient: HTTPClient
    var courses: [Course] = [] 
    
    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }
    
    // get all courses
    func loadCourses() async throws {
        let resource = Resource(url: APIConstants.endpointURL(for: .faculty(.courses)), modelType: CourseResponse.self)
        do {
            let response = try await httpClient.load(resource)
            if response.success {
                courses = response.courses ?? []
            } else {
                throw NetworkError.serverError(response.message ?? "")
            }
        } catch {
            throw error
        }
    }
    
}
