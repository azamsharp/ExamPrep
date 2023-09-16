//
//  Constants.swift
//  ExamPrepClient
//
//  Created by Mohammad Azam on 9/15/23.
//

import Foundation

struct APIConstants {
    
    static let baseURL = "http://localhost:8080"
    
    enum APIEndpoint {
        case register
        
        var path: String {
            switch self {
                case .register:
                    return "/api/register"
            }
        }
    }
    
    static func endpointURL(for endpoint: APIEndpoint) -> URL {
        let endpointPath = endpoint.path
        return URL(string: baseURL + endpointPath)!
    }
    
}
