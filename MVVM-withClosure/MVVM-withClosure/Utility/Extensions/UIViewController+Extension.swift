//
//  UIViewController+Extension.swift
//  MVVM-withClosure
//
//  Created by Jaimini Shah on 23/05/25.
//

import UIKit

extension UIViewController {
    func showError(_ error: NetworkServiceError) {
        let alert = UIAlertController(
            title: error.userFacingTitle,
            message: error.userFacingMessage,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    func showSuccess(title: String, message: String) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
