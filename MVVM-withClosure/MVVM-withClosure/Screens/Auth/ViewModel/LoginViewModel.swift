//
//  LoginViewModel.swift
//  MVVM-withClosure
//
//  Created by Jaimini Shah on 19/05/25.
//

import Foundation

// Protocol for authentication related ViewModels
protocol AuthViewModelProtocol: ViewModelProtocol {
    func login(username: String, password: String)
}
final class LoginViewModel: AuthViewModelProtocol {
    
    // MARK: - Properties
    private let networkService: NetworkServiceProtocol
    private let validationService: ValidationServiceProtocol
    var eventHandler: ((Event) -> Void)?
    private var loginData: LoginModel?
    
    // MARK: - Initialization
    init(networkService: NetworkServiceProtocol = NetworkService.shared,
         validationService: ValidationServiceProtocol = ValidationService.shared) {
        self.networkService = networkService
        self.validationService = validationService
    }
    
    // MARK: - Public Methods
    func login(username: String, password: String) {
        // Validate inputs
        eventHandler?(.loading)
        Task {
            do {
                let loginAPI = try await networkService.request(model: LoginModel.self, EndPointItem.login(username: username, password: password))
                self.loginData = loginAPI
                await MainActor.run {
                    self.eventHandler?(.stopLoading)
                    self.eventHandler?(.loginSuccess)
                }
            } catch {
                await MainActor.run {
                    self.eventHandler?(.stopLoading)
                    if let networkError = error as? NetworkServiceError {
                        self.eventHandler?(.showError(networkError))
                    } else {
                        self.eventHandler?(.showError(.custom(error.localizedDescription)))
                    }
                }
            }
        }
    }
}

// MARK: - Event Types
extension LoginViewModel {
    enum Event {
        case showError(NetworkServiceError)
        case validationError(String)
        case loading
        case stopLoading
        case loginSuccess
        case logout
    }
}


