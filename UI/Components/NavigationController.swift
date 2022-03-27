import Foundation
import UIKit

public final class NavigationController: UINavigationController {
    
    public override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup(){
        navigationBar.barTintColor = UIColor.white
        navigationBar.tintColor = UIColor.white
        navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        //navigationBar.isTranslucent = false
    }
    
}
