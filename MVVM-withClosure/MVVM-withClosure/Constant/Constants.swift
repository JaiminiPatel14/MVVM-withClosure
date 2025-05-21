import Foundation

enum Constants {
    // MARK: - API
    enum API {
        static let baseURL = "https://fakestoreapi.com/"
        static let timeout: TimeInterval = 30
    }
    
    // MARK: - UI
    enum UI {
        static let cornerRadius: CGFloat = 16
        static let defaultPadding: CGFloat = 16
        static let animationDuration: TimeInterval = 0.3
    }
    
    // MARK: - Cell Identifiers
    enum CellIdentifiers {
        static let productCell = "ProductTVC"
    }
    
    // MARK: - Storyboard Names
    enum Storyboard {
        static let main = "Main"
    }
    
    // MARK: - View Controller Identifiers
    enum ViewController {
        static let login = "LoginVC"
        static let productList = "ProductListVC"
    }
    
    // MARK: - Error Messages
    enum ErrorMessages {
        static let invalidCredentials = "Invalid username or password"
        static let networkError = "Network error occurred"
        static let unknownError = "An unknown error occurred"
    }
} 