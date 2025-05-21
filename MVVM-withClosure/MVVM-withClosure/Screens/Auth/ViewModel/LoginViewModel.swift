//
//  LoginViewModel.swift
//  MVVM-withClosure
//
//  Created by Jaimini Shah on 19/05/25.
//

import Foundation

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
//        guard validationService.validateUsername(username) else {
//            eventHandler?(.validationError("Invalid username format"))
//            return
//        }
//        
//        guard validationService.validatePassword(password) else {
//            eventHandler?(.validationError("Password must be at least 8 characters with 1 uppercase, 1 lowercase, and 1 number"))
//            return
//        }
        
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
                    self.eventHandler?(.showError(error))
                }
            }
        }
    }
}

// MARK: - Event Types
extension LoginViewModel {
    enum Event {
        case showError(Error)
        case validationError(String)
        case loading
        case stopLoading
        case loginSuccess
        case logout
    }
}


