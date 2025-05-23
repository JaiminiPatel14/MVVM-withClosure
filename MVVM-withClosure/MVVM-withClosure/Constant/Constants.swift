import Foundation

enum Constants {
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