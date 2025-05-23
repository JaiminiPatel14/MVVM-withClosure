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
    weak var coordinator: AuthCoordinator?

    // MARK: - Initialization
    required init?(coder: NSCoder) {
        self.viewModel = LoginViewModel()
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
                self.showError(error)
            case .validationError(let message):
                self.hideLoading()
                self.showError(.custom(message))
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
            self.showError(.custom(Constants.ErrorMessages.invalidCredentials))
            return
        }
        viewModel.login(username: username, password: password)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}
