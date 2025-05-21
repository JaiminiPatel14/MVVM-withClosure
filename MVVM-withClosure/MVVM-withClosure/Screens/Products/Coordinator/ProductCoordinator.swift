//
//  ProductCoordinator.swift
//  MVVM-withClosure
//
//  Created by Jaimini Shah on 20/05/25.
//

import UIKit
import Foundation

class ProductCoordinator: BaseCoordinator {
    override func start() {
        let productListVC = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "ProductListVC") as! ProductListVC
        productListVC.coordinator = self
        navigationController.pushViewController(productListVC, animated: true)
    }
    
    func showProductDetail(product: ProductModel) {
        // Implement product detail navigation
    }
}
