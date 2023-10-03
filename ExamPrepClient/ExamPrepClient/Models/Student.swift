//
//  Student.swift
//  ExamPrepClient
//
//  Created by Mohammad Azam on 9/26/23.
//

import Foundation
import Observation

@Observable
class Student {
    
    var httpClient: HTTPClient
    var enrollments: [Enrollment] = []
    
    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }
    
    func enroll(courseCode: String) async throws {
        
        let data = [JSON.Keys.courseCode: courseCode]
        
        let body = try JSONEncoder().encode(data)
        let resource = Resource(url: APIConstants.endpointURL(for: .student(.enroll)), method: .post(body), modelType: StudentCourseEnrollResponse.self)
        let response = try await httpClient.load(resource)
        if response.success {
            if let enrollment = response.enrollment {
                enrollments.append(enrollment)
            }
        } else {
            throw NetworkError.serverError(response.message ?? MessageConstants.unableToProcessRequest)
        }
    }
}
