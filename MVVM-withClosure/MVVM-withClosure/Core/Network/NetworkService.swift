import Foundation

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

// MARK: - Network Service Protocol
protocol NetworkServiceProtocol {
    func request<T: Decodable>(model: T.Type,_ endpoint: EndPointType) async throws -> T
}

// MARK: - Network Service Implementation
final class NetworkService: NetworkServiceProtocol {
    
    static let shared = NetworkService()
    private init() {}
    
    func request<T: Decodable>(model: T.Type,_ endpoint: EndPointType) async throws -> T {
        guard let url = endpoint.url else {
            throw NetworkServiceError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.httpMethod.rawValue
        
        // Add headers
        endpoint.headers?.forEach { request.setValue($1, forHTTPHeaderField: $0) }
        
        // Add body if needed
        if let parameters = endpoint.parameters {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters)
        }
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkServiceError.invalidResponse
            }
            switch httpResponse.statusCode {
            case 200...299:
                do {
                    return try JSONDecoder().decode(T.self, from: data)
                } catch {
                    throw NetworkServiceError.decodingFailed(error.localizedDescription)
                }
            case 401:
                throw NetworkServiceError.unauthorized
            default:
                throw NetworkServiceError.serverError(httpResponse.statusCode)
            }
        } catch let error as NetworkServiceError {
            throw error
        } catch {
            throw NetworkServiceError.custom(error.localizedDescription)
        }
    }
} 
