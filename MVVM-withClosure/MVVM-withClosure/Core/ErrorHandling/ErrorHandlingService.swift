import Foundation

// MARK: - App Error
enum AppError: LocalizedError {
    case network(NetworkError)
    case validation(String)
    case authentication(String)
    case unknown(String)
    
    var errorDescription: String? {
        switch self {
        case .network(let error):
            return error.localizedDescription
        case .validation(let message):
            return message
        case .authentication(let message):
            return message
        case .unknown(let message):
            return message
        }
    }
}

// MARK: - Error Handling Service
protocol ErrorHandlingServiceProtocol {
    func handle(_ error: Error) -> AppError
    func handleNetworkError(_ error: NetworkError) -> AppError
    func handleValidationError(_ message: String) -> AppError
    func handleAuthenticationError(_ message: String) -> AppError
}

final class ErrorHandlingService: ErrorHandlingServiceProtocol {
    static let shared = ErrorHandlingService()
    private init() {}
    
    func handle(_ error: Error) -> AppError {
        switch error {
        case let networkError as NetworkError:
            return handleNetworkError(networkError)
        case let appError as AppError:
            return appError
        default:
            return .unknown(error.localizedDescription)
        }
    }
    
    func handleNetworkError(_ error: NetworkError) -> AppError {
        return .network(error)
    }
    
    func handleValidationError(_ message: String) -> AppError {
        return .validation(message)
    }
    
    func handleAuthenticationError(_ message: String) -> AppError {
        return .authentication(message)
    }
} 