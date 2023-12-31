//
//  HTTPClient.swift
//  GroceryApp
//
//  Created by Mohammad Azam on 5/7/23.
//

import Foundation

enum NetworkError: Error {
    case badRequest
    case serverError(String)
    case decodingError(Error)
    case invalidResponse
    case invalidURL
}

extension NetworkError: LocalizedError {
    
    var errorDescription: String? {
        switch self {
            case .badRequest:
                return NSLocalizedString("Unable to perform request", comment: "badRequestError")
            case .serverError(let errorMessage):
                return NSLocalizedString(errorMessage, comment: "serverError")
            case .decodingError:
                return NSLocalizedString("Unable to decode successfully.", comment: "decodingError")
            case .invalidResponse:
                return NSLocalizedString("Invalid response", comment: "invalidResponse")
            case .invalidURL:
                return NSLocalizedString("Invalid URL", comment: "invalidURL")
          //  case .httpError(_):
           //     return NSLocalizedString("Bad request", comment: "badRequest")
        }
    }
    
}

enum HTTPMethod {
    case get([URLQueryItem])
    case post(Data?)
    case delete
    
    var name: String {
        switch self {
            case .get:
                return "GET"
            case .post:
                return "POST"
            case .delete:
                return "DELETE"
        }
    }
}

struct Resource<T: Codable> {
    let url: URL
    var method: HTTPMethod = .get([])
    var modelType: T.Type
}

// eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjcsImV4cCI6MTcwMDYwNTY2MiwiaWF0IjoxNjk1NDIxNjYyfQ.uHp_M9lLINWuGC-VdCToGgIHK4O-bpa1jsIS4TDJofc

struct HTTPClient {
    
    static let shared = HTTPClient()
    private let session: URLSession
    
    private init() {
        let configuration = URLSessionConfiguration.default
        // for instructor
        configuration.httpAdditionalHeaders = ["Content-Type": "application/json", "Authorization": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjcsImV4cCI6MTcwMDYwNTY2MiwiaWF0IjoxNjk1NDIxNjYyfQ.uHp_M9lLINWuGC-VdCToGgIHK4O-bpa1jsIS4TDJofc"]
        
        // for student
        //configuration.httpAdditionalHeaders = ["Content-Type": "application/json", "Authorization": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjE1LCJleHAiOjE3MDA4ODA5NzcsImlhdCI6MTY5NTY5Njk3N30.YCImwLef0NGSE3z35IcN-FDApWHP4jrjuRPDK4dQHSM"]
        
        self.session = URLSession(configuration: configuration)
    }
    
    func load<T: Codable>(_ resource: Resource<T>) async throws -> T {
        
        var request = URLRequest(url: resource.url)
        
        switch resource.method {
            case .get(let queryItems):
                var components = URLComponents(url: resource.url, resolvingAgainstBaseURL: false)
                components?.queryItems = queryItems
                guard let url = components?.url else {
                        throw NetworkError.badRequest
                }
                
                request = URLRequest(url: url)
                
            case .post(let data):
                request.httpMethod = resource.method.name
                request.httpBody = data
            
            case .delete:
                request.httpMethod = resource.method.name
        }
        
        let (data, response) = try await session.data(for: request)
        
        guard let _ = response as? HTTPURLResponse else {
                throw NetworkError.invalidResponse
        }
        
        /*
        guard (200..<300).contains(httpResponse.statusCode) else {
            throw NetworkError.httpError(httpResponse.statusCode)
        } */
        
        do {
            let result = try JSONDecoder().decode(resource.modelType, from: data)
            return result
        } catch {
            throw NetworkError.decodingError(error)
        }
    }
    
}
