import UIKit

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get set }
    var parentCoordinator: Coordinator? { get set }
    var childCoordinators: [Coordinator] { get set }
    
    func start()
    func finish()
}
// MARK: - Base Coordinator
class BaseCoordinator: Coordinator {
    var navigationController: UINavigationController
    weak var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.navigationController.navigationBar.isHidden = true
    }
    
    func start() {
        // Override in subclasses
    }
    
    func finish() {
        parentCoordinator?.childCoordinators.removeAll { $0 === self }
    }
    
    // Helper method to add child coordinator
    func addChildCoordinator(_ coordinator: Coordinator) {
        coordinator.parentCoordinator = self
        childCoordinators.append(coordinator)
    }
}
// MARK: - App Coordinator
class AppCoordinator: BaseCoordinator {
    override func start() {
        let authCoordinator = AuthCoordinator(navigationController: navigationController)
        addChildCoordinator(authCoordinator)
        authCoordinator.start()
    }
}
