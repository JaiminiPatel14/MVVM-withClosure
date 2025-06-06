import Foundation

// Base protocol for all ViewModels
protocol ViewModelProtocol {
    associatedtype Event
    var eventHandler: ((Event) -> Void)? { get set }
}
