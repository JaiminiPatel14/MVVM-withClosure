import Foundation

protocol ValidationServiceProtocol {
    func validateEmail(_ email: String) -> Bool
    func validatePassword(_ password: String) -> Bool
    func validateUsername(_ username: String) -> Bool
}

final class ValidationService: ValidationServiceProtocol {
    static let shared = ValidationService()
    private init() {}
    
    func validateEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    func validatePassword(_ password: String) -> Bool {
        // At least 8 characters, 1 uppercase, 1 lowercase, 1 number
        let passwordRegex = "^(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{8,}$"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordPredicate.evaluate(with: password)
    }
    
    func validateUsername(_ username: String) -> Bool {
        // At least 3 characters, alphanumeric and underscore only
        let usernameRegex = "^[a-zA-Z0-9_]{3,}$"
        let usernamePredicate = NSPredicate(format: "SELF MATCHES %@", usernameRegex)
        return usernamePredicate.evaluate(with: username)
    }
} 