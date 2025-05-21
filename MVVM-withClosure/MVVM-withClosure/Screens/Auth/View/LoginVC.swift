//
//  LoginVC.swift
//  MVVM-withClosure
//
//  Created by Jaimini Shah on 19/05/25.
//

import UIKit

class LoginVC: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var lblUsername: CustomTextField!
    @IBOutlet weak var lblPass: CustomTextField!
    
    // MARK: - Properties
    private let viewModel: LoginViewModel
    private let errorHandler: ErrorHandlingServiceProtocol
    weak var coordinator: AuthCoordinator?

    // MARK: - Initialization
    required init?(coder: NSCoder) {
        self.viewModel = LoginViewModel()
        self.errorHandler = ErrorHandlingService.shared
        super.init(coder: coder)
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
    }
    
    // MARK: - Private Methods
    private func setupUI() {
        lblUsername.placeholder = "Username"
        lblPass.placeholder = "Password"
        lblPass.isSecureTextEntry = true
        
        // Add keyboard handling
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    private func setupBindings() {
        viewModel.eventHandler = { [weak self] event in
            guard let self = self else { return }
            switch event {
            case .loading:
                self.showLoading(message: "Logging in...")
            case .stopLoading:
                self.hideLoading()
            case .loginSuccess:
                self.hideLoading()
                self.coordinator?.showProductList()
            case .showError(let error):
                self.hideLoading()
                let appError = self.errorHandler.handle(error)
                self.showAlert(message: appError.localizedDescription)
            case .validationError(let message):
                self.hideLoading()
                let appError = self.errorHandler.handleValidationError(message)
                self.showAlert(message: appError.localizedDescription)
            case .logout:
                self.hideLoading()
                self.coordinator?.logout()
            }
        }
    }
    
    // MARK: - Actions
    @IBAction func btnLoginAction(_ sender: Any) {
        guard let username = lblUsername.text, !username.isEmpty,
              let password = lblPass.text, !password.isEmpty else {
            let error = errorHandler.handleValidationError(Constants.ErrorMessages.invalidCredentials)
            showAlert(message: error.localizedDescription)
            return
        }
        viewModel.login(username: username, password: password)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}

// MARK: - UI Helpers
extension LoginVC {
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
