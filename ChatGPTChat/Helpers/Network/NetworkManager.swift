//
//  NetworkManager.swift
//  ChatGPTChat
//
//  Created by Raj S on 28/01/24.
//

import Foundation


// MARK: - NetworkManaging
protocol NetworkManaging {
    func fetch<T: Decodable>(
        path: String,
        method: NetworkRequest.Method,
        body: NetworkRequest.BodyParams
    ) async throws -> T
}

// MARK: - URLSessionNetworkManager
final class URLSessionNetworkManager: NetworkManaging {
    
    @Inject
    var config: Config
    
    func fetch<T: Decodable>(
        path: String,
        method: NetworkRequest.Method,
        body: NetworkRequest.BodyParams
    ) async throws -> T {
        guard let url = URL(string: config.apiBasePath + "/" + path) else {
            throw NetworkError.invalidUrl
        }
        
        var request = URLRequest(url: url)
        request.setValue("Bearer \(config.appToken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = method.rawValue
        
        let jsonData = try JSONSerialization.data(withJSONObject: body, options: [])
        request.httpBody = jsonData
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }
        
        let decodedData = try JSONDecoder().decode(T.self, from: data)
        return decodedData
    }
}

// MARK: - NetworkError
enum NetworkError: LocalizedError {
    case invalidUrl
    case invalidResponse
    
    var errorDescription: String? {
        switch self {
        case .invalidUrl:
            return NSLocalizedString("Invalid Url", comment: "")
        case .invalidResponse:
            return NSLocalizedString("Invalid Response", comment: "")
        }
    }
}

// MARK: - NetworkRequest
struct NetworkRequest {
    
    enum Method: String {
        case post = "POST"
        case get = "GET"
    }
    
    typealias BodyParams = [String: Any]
}


