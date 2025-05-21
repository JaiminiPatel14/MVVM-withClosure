import Foundation

// MARK: - Network Errors
enum NetworkError: LocalizedError {
    case invalidURL
    case invalidResponse
    case decodingFailed(String)
    case serverError(Int)
    case noData
    case unauthorized
    case custom(String)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .invalidResponse:
            return "Invalid Response"
        case .decodingFailed(let message):
            return "Decoding failed: \(message)"
        case .serverError(let code):
            return "Server error with code: \(code)"
        case .noData:
            return "No data received"
        case .unauthorized:
            return "Unauthorized access"
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
            throw NetworkError.invalidURL
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
                throw NetworkError.invalidResponse
            }
            
            switch httpResponse.statusCode {
            case 200...299:
                do {
                    return try JSONDecoder().decode(T.self, from: data)
                } catch {
                    throw NetworkError.decodingFailed(error.localizedDescription)
                }
            case 401:
                throw NetworkError.unauthorized
            default:
                throw NetworkError.serverError(httpResponse.statusCode)
            }
        } catch let error as NetworkError {
            throw error
        } catch {
            throw NetworkError.custom(error.localizedDescription)
        }
    }
} 
