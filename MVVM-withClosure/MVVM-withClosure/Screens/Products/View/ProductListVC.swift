//
//  ProductListVC.swift
//  MVVM-withClosure
//
//  Created by Jaimini Shah on 19/05/25.
//

import UIKit

class ProductListVC: UIViewController {

    @IBOutlet weak var tblProduct: UITableView!
    
    private var productViewModel : ProductViewModel
    weak var coordinator: ProductCoordinator?

    required init?(coder: NSCoder) {
        self.productViewModel = ProductViewModel()
        super.init(coder: coder)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        bindData()
        eventHander()
    }
    func initUI(){
        tblProduct.register(UINib(nibName: "ProductTVC", bundle: nil), forCellReuseIdentifier: "ProductTVC")
        tblProduct.delegate = self
        tblProduct.dataSource = self
    }
    func bindData(){
        productViewModel.fetchProducts()
    }
    func eventHander(){
        productViewModel.eventHandler = { [weak self] event in
            switch event {
            case .dataLoaded:
                DispatchQueue.main.async { [weak self] in
                    self?.tblProduct.reloadData()
                }
            case .showError(let error):
                DispatchQueue.main.async { [weak self] in
                    self?.showAlert(message: error.localizedDescription)
                }
            case .loading:
                DispatchQueue.main.async { [weak self] in
                    self?.showLoading(message: "Loading products...")
                }
            case .stopLoading:
                DispatchQueue.main.async { [weak self] in
                    self?.hideLoading()
                }
            }
        }
    }

   

}
extension ProductListVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productViewModel.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductTVC") as? ProductTVC else {
            return UITableViewCell()
        }
        cell.product = productViewModel.products[indexPath.row]
        cell.layoutIfNeeded()
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
}
