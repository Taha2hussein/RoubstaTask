
import UIKit

protocol Coordinator {
    var Main: MainNavigator { get }
    var navigationController: UINavigationController? { get }
    func dismiss()
    var subCoordinator: Coordinator { get }
}

class AppCoordinator: Coordinator {
    let window: UIWindow
    var isSub: Bool

    lazy var Main: MainNavigator = {
        return .init(coordinator: self)
    }()

  
    
    lazy var subCoordinator: Coordinator = {
        return AppCoordinator(window: window, isSub: true)
    }()
    
    lazy var subNavigationController = {
        return UINavigationController()
    }()

    var navigationController: UINavigationController? {
        if(isSub){
            return subNavigationController
        } else {
            if let navigationController = self as? UINavigationController {
                return navigationController
            }
            return nil
        }
    }
    
    init(window: UIWindow = UIWindow(), isSub: Bool = false) {
        self.window = window
        self.isSub = isSub
        self.window.backgroundColor = .white
    }
    
    func start() {
        let navigation = UINavigationController(rootViewController: rootViewController)
        window.rootViewController = navigation
        window.makeKeyAndVisible()
    }
    
    func dismiss() {
        self.navigationController?.popViewController(animated: true)
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    var rootViewController: UIViewController {
        let rootViewContoller = Main.viewController(for: .HomeViewController, coordinator: self)
        return rootViewContoller
    }
}
