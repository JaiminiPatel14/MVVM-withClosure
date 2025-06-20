//
//  ProductViewModel.swift
//  MVVM-withClosure
//
//  Created by Jaimini Shah on 19/05/25.
//

import Foundation

// Protocol for product related ViewModels
protocol ProductViewModelProtocol: ViewModelProtocol {
    func fetchProducts()
}

final class ProductViewModel: ProductViewModelProtocol {
    // MARK: - Properties
    private let networkService: NetworkServiceProtocol
    var eventHandler: ((Event) -> Void)?
    
    private var productList: [ProductModel] = []
    // Public Read-Only
    var products: [ProductModel] {
        productList
    }
    
    // MARK: - Initialization
    init(networkService: NetworkServiceProtocol = NetworkService.shared) {
        self.networkService = networkService
    }
    
    // MARK: - Public Methods
    func fetchProducts() {
        eventHandler?(.loading)
        Task {
            do {
                let products = try await networkService.request(model: [ProductModel].self, EndPointItem.products)
                self.productList = products
                await MainActor.run {
                    self.eventHandler?(.dataLoaded)
                }
            } catch {
                await MainActor.run {
                    if let networkError = error as? NetworkServiceError {
                        self.eventHandler?(.showError(networkError))
                    } else {
                        self.eventHandler?(.showError(.custom(error.localizedDescription)))
                    }
                }
            }
        }
    }
    
    func getProduct(at index: Int) -> ProductModel? {
        guard index >= 0 && index < productList.count else { return nil }
        return productList[index]
    }
}

// MARK: - Event Types
extension ProductViewModel {
    enum Event {
        case showError(NetworkServiceError)
        case loading
        case stopLoading
        case dataLoaded
    }
}
