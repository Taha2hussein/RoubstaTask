
import Foundation
import UIKit
class MainNavigator: Navigator {
    var coordinator: Coordinator
    
    enum Destination {
        case HomeViewController
        case itemDetails(repo: UserElement)
    }
    
    required init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }

    func viewController(for destination: Destination, coordinator: Coordinator)-> UIViewController {
        switch destination {
        case .HomeViewController:
            
            let homeRepo = HomeRepositry()
            let homeUseCase = HomeUseCase(homeRepo: homeRepo)
            let viewModel = HomeViewModel(homeUseCase: homeUseCase)
            let view = HomeViewController(viewModel: viewModel, coordinator: coordinator)
            return view
            
        case .itemDetails(let repo):
            let homeDetailViewModel = HomeDetailViewModel(githubRepo: repo)
            let view = HomeDetailViewController(viewModel: homeDetailViewModel, coordinator: coordinator)
            return view
        }
    }
}
