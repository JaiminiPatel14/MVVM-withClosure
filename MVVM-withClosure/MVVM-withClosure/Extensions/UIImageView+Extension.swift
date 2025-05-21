//
//  UIImageView+Extension.swift
//  MVVM-withClosure
//
//  Created by Jaimini Shah on 17/05/25.
//

import UIKit
import Kingfisher
import Foundation

extension UIImageView {
    func setImage(with url: String?, placeholder: UIImage? = nil) {
        guard let url = URL.init(string: url ?? "") else {
            return
        }
        self.kf.setImage(with: url) { result in
            switch result {
            case .success(_): break
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
}
