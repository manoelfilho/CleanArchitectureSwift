import XCTest
import UIKit
import Presenter
@testable import UI

public final class WelcomeRouter {
    
    private let nav: NavigationController
    private let loginFactory: () -> LoginViewController
    
    public init(nav: NavigationController, loginFactory: @escaping () -> LoginViewController){
        self.nav = nav
        self.loginFactory = loginFactory
    }
    
    public func goToLogin(){
        nav.pushViewController(loginFactory(), animated: true)
    }
}

class WelcomeRouterTests: XCTestCase {
    
    func test_goToLogin_calls_nav_with_correct_vc(){
        let loginFactorySpy = LoginFactorySpy()
        let nav = NavigationController()
        let sut = WelcomeRouter(nav: nav, loginFactory: loginFactorySpy.makeLogin)
        sut.goToLogin()
        XCTAssertEqual(nav.viewControllers.count, 1)
        XCTAssertTrue(nav.viewControllers[0] is LoginViewController)
    }

    class LoginFactorySpy {
        func makeLogin() -> LoginViewController {
            return LoginViewController.instantiate()
        }
    }
}
