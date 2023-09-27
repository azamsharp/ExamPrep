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
    var enrolledCourses: [Course] = []
    
    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }
    
}
