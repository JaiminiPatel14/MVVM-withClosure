//
//  AuthCoordinator.swift
//  MVVM-withClosure
//
//  Created by Jaimini Shah on 20/05/25.
//

import Foundation
import UIKit

// MARK: - Auth Coordinator
class AuthCoordinator: BaseCoordinator {
    override func start() {
        let loginVC = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        loginVC.coordinator = self
        navigationController.setViewControllers([loginVC], animated: false)
    }
    
    func showProductList() {
        let productCoordinator = ProductCoordinator(navigationController: navigationController)
        addChildCoordinator(productCoordinator)
        productCoordinator.start()
    }
    
    func logout() {
        navigationController.popToRootViewController(animated: true)
    }
}
