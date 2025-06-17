import Foundation
import UIKit

@objc class TabBarController: UITabBarController {
    
    //MARK: Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupConfiguration()
    }
    
    func setupConfiguration() {
        delegate = self
    }

    @objc func set(selectedIndex index : Int) {
        _ = self.tabBarController(self, shouldSelect: self.viewControllers![index])
    }
}

@objc extension TabBarController: UITabBarControllerDelegate  {
    @objc func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        guard let fromView = selectedViewController?.view, let toView = viewController.view else { return false }
        if fromView != toView {
            UIView.transition(from: fromView, to: toView, duration: 0.3, options: [.transitionCrossDissolve], completion: { (true) in
            })
            self.selectedViewController = viewController
        }
        return true
    }
}
