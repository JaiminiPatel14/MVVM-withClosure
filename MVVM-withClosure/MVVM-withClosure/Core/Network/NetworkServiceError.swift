//
//  NetworkServiceError.swift
//  MVVM-withClosure
//
//  Created by Jaimini Shah on 06/06/25.
//

// MARK: - Network Service Error
enum NetworkServiceError: Error {
    case invalidURL
    case invalidResponse
    case decodingFailed(String)
    case serverError(Int)
    case noData
    case unauthorized
    case custom(String)
    
    var userFacingTitle: String {
        switch self {
        case .invalidURL, .invalidResponse, .decodingFailed:
            return "Connection Error"
        case .serverError:
            return "Server Error"
        case .noData:
            return "Data Error"
        case .unauthorized:
            return "Authentication Error"
        case .custom:
            return "Error"
        }
    }
    
    var userFacingMessage: String {
        switch self {
        case .invalidURL:
            return "The server address is invalid. Please try again later."
        case .invalidResponse:
            return "Received an invalid response from the server. Please try again."
        case .decodingFailed(let message):
            return "Unable to process server response: \(message)"
        case .serverError(let code):
            return "Server error (Code: \(code)). Please try again later."
        case .noData:
            return "No data received from the server. Please try again."
        case .unauthorized:
            return "Your session has expired. Please log in again."
        case .custom(let message):
            return message
        }
    }
}
