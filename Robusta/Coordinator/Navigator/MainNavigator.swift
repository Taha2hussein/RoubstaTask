
import Foundation
import UIKit
class MainNavigator: Navigator {
    var coordinator: Coordinator
    
    enum Destination {
        case HomeViewController
        case itemDetails
    }
    
    required init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }

    func viewController(for destination: Destination, coordinator: Coordinator) -> UIViewController {
        switch destination {
        case .HomeViewController:
            let homeRepo = HomeRepositry()
            let homeUseCase = HomeUseCase(homeRepo: homeRepo)
            let viewModel = HomeViewModel(homeUseCase: homeUseCase)
            let view = HomeViewController(viewModel: viewModel, coordinator: coordinator)
            return view
        case .itemDetails:
//            let homeDetailViewModel = HomeDetailViewModel(product: product)
//            let view = HomeDetailsViewController(viewModel: homeDetailViewModel, coordinator: coordinator)
            let view = UIViewController()

            return view
        }
    }
}
