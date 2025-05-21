//
//  APIManager.swift
//  MVVM-withClosure
//
//  Created by Jaimini Shah on 17/05/25.
//

import Foundation

enum DataError: Error {
    case invalidURL
    case invalidResponse
    case decodingFailed(String)
    case message(String)
}
extension DataError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .invalidResponse:
            return "Invalid Response"
        case .decodingFailed(let message):
            return "Decoding failed: \(message)"
        case .message(let message):
            return message
        }
    }
}
typealias responseHandler<T: Codable> = (Result<T, DataError>) -> Void
final class APIManager {
    static let shared = APIManager()
    private init() {}
    
    func request<T: Codable>(model: T.Type, endPointType: EndPointType) async throws -> T{
        guard let url = endPointType.url else {
            throw DataError.invalidURL
        }
        var request = URLRequest(url: url)
        request.httpMethod = endPointType.httpMethod.rawValue
        if let headers = endPointType.headers {
            for (key, value) in headers {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        if let parameters = endPointType.parameters {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
        }
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse else {
            throw DataError.invalidResponse
        }
        if httpResponse.statusCode == 401 {
            throw DataError.decodingFailed("html response")
        }
        return try JSONDecoder().decode(model, from: data)
    }
}
