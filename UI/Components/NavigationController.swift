import Foundation
import UIKit

public final class NavigationController: UINavigationController {
    
    private var currentViewController: UIViewController?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    public convenience init(){
        self.init(nibName: nil, bundle: nil)
    }
    
    private func setup(){
        navigationBar.barTintColor = UIColor.white
        navigationBar.tintColor = UIColor.gray
        navigationBar.titleTextAttributes = [.foregroundColor: UIColor.gray]
        //navigationBar.isTranslucent = false
    }
    
    public func setRootViewController(_ viewController: UIViewController){
        setViewControllers([viewController], animated: true)
        self.currentViewController = viewController
        hideBackButtonText()
    }
    
    public func hideBackButtonText(){
        currentViewController?.navigationItem.backBarButtonItem = UIBarButtonItem(title: nil, style: .plain, target: nil, action: nil) //remove o texto da seta do topo do navigation e deixa somente o icone da seta
    }
    
    public func pushViewController(_ viewController: UIViewController) {
        pushViewController(viewController, animated: true)
    }
    
}
