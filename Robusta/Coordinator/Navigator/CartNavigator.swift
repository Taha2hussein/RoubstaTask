

import Foundation
import UIKit

class CartNavigator: Navigator {
    var coordinator: Coordinator
    
    private let storyboard: AppStoryboard = .Cart
    
    enum Destination {
        case cart
    }
    
    required init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }

    func viewController(for destination: Destination, coordinator: Coordinator) -> UIViewController {
//        let viewConto = ViewController.createFromStoryboard(storyboard: .Cart, viewModel: nil , coordinator: coordinator)
        let viewConto = UIViewController()
        viewConto.view.backgroundColor = .red
        return UIViewController()

//        switch destination {
//        case .cart:
//            let viewModel = CartViewModel()
//            let view = CartViewController.createFromStoryboard(storyboard: .Cart, viewModel: viewModel, coordinator: coordinator)
//            return view
//        }
    }
}
