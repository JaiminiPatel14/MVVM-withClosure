import Foundation

// Base protocol for all ViewModels
protocol ViewModelProtocol {
    associatedtype Event
    var eventHandler: ((Event) -> Void)? { get set }
}

// Protocol for authentication related ViewModels
protocol AuthViewModelProtocol: ViewModelProtocol {
    func login(username: String, password: String)
}

// Protocol for product related ViewModels
protocol ProductViewModelProtocol: ViewModelProtocol {
    func fetchProducts()
} 
