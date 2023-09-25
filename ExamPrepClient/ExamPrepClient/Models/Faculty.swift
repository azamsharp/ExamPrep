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
    
    // create course
    func createCourse(name: String, description: String) async throws {
        
        let data = ["name": name, "description": description]
        let body = try JSONEncoder().encode(data)
        let resource = Resource(url: APIConstants.endpointURL(for: .faculty(.courses)), method: .post(body), modelType: CourseCreateResponse.self)
        
        let response = try await httpClient.load(resource)
        if response.success {
            if let course = response.course {
                courses.append(course)
            }
        } else {
            throw NetworkError.serverError(response.message ?? MessageConstants.unableToProcessRequest)
        }
    }
    
    // get all courses
    func loadCourses() async throws {
        let resource = Resource(url: APIConstants.endpointURL(for: .faculty(.courses)), modelType: [Course].self)
        courses = try await httpClient.load(resource)
    }
    
}
