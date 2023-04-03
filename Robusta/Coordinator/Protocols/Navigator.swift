
import UIKit

enum NavigatorTypes {
    case push
    case present
    case presentWithNavigation
    case root
}

protocol Navigator {
    associatedtype Destination
    func viewController(for destination: Destination, coordinator: Coordinator) -> UIViewController
    init(coordinator: Coordinator)
    var coordinator: Coordinator { get }
    func navigate(from view: UIViewController, to destination: Destination, with navigationType: NavigatorTypes)
}

extension Navigator {
    func navigate(from view: UIViewController,
                  to destination: Destination,
                  with navigationType: NavigatorTypes = .push) {
        let viewController = self.viewController(for: destination, coordinator: self.coordinator)
        switch navigationType {
        case .push:
            view.navigationController?.pushViewController(viewController, animated: true)
        case .present:
            viewController.modalPresentationStyle = .fullScreen
            view.present(viewController, animated: true, completion: nil)
        case .presentWithNavigation:
            let newVC = self.viewController(for: destination, coordinator: coordinator.subCoordinator)
            coordinator.navigationController?.setViewControllers([newVC], animated: true)
            coordinator.navigationController?.present(coordinator.navigationController!, animated: true, completion: nil)
        case .root:
            coordinator.navigationController?.setViewControllers([viewController], animated: true)
        }
    }
}
