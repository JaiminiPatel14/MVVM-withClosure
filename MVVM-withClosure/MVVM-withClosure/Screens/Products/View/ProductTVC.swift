//
//  ProductTVC.swift
//  MVVM-withClosure
//
//  Created by Jaimini Shah on 19/05/25.
//

import UIKit

class ProductTVC: UITableViewCell {

    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var bgView: UIView!
    
    var product: ProductModel? {
        didSet {
            self.configure()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    private func setupUI() {
        imgProduct.layer.cornerRadius = 16
        bgView.layer.cornerRadius = 16
    }
    private func configure() {
        guard let product = self.product else { return }
        lblTitle.text = product.title
        lblDesc.text = product.description
        imgProduct.setImage(with: product.image)
    }
}
