
import Foundation
import UIKit

protocol Coordinator {
    var Main: MainNavigator { get }
    var Cart: CartNavigator { get }
    var navigationController: UINavigationController? { get }
    func dismiss()
    var subCoordinator: Coordinator { get }
}

class AppCoordinator: Coordinator {
    let window: UIWindow

    lazy var Main: MainNavigator = {
        return .init(coordinator: self)
    }()

    lazy var Cart: CartNavigator = {
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
            if let navigationController : UINavigationController? = UINavigationController() {
                return navigationController
            }
            return nil
        }
    }
    var isSub: Bool
    
    init(window: UIWindow = UIWindow(), isSub: Bool = false) {
        self.window = window
        self.isSub = isSub
        self.window.backgroundColor = .white
    }
    
    func start(){
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
    }
    
    func dismiss() {
        self.navigationController?.popViewController(animated: true)
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    var rootViewController: UIViewController {
        return Main.viewController(for: .HomeViewController, coordinator: self)
    }
}
