import XCTest
import UIKit
import Presenter
@testable import UI

public final class WelcomeRouter {
    
    private let nav: NavigationController
    private let loginFactory: () -> LoginViewController
    private let signUpFactory: () -> SignUpViewController
    
    public init(nav: NavigationController,
                loginFactory: @escaping () -> LoginViewController,
                signUpFactory: @escaping () -> SignUpViewController){
        self.nav = nav
        self.loginFactory = loginFactory
        self.signUpFactory = signUpFactory
    }
    
    public func goToLogin(){
        nav.pushViewController(loginFactory(), animated: true)
    }
    
    public func goToSignup(){
        nav.pushViewController(signUpFactory(), animated: true)
    }
}

class WelcomeRouterTests: XCTestCase {
    
    func test_goToLogin_calls_nav_with_correct_vc(){
        let (sut, nav) = makeSut()
        sut.goToLogin()
        XCTAssertEqual(nav.viewControllers.count, 1)
        XCTAssertTrue(nav.viewControllers[0] is LoginViewController)
    }
    
    func test_goToSignup_calls_nav_with_correct_vc(){
        let (sut, nav) = makeSut()
        sut.goToSignup()
        XCTAssertEqual(nav.viewControllers.count, 1)
        XCTAssertTrue(nav.viewControllers[0] is SignUpViewController)
    }

    
}

extension WelcomeRouterTests {
    func makeSut() -> (sut: WelcomeRouter, nav: NavigationController) {
        let loginFactorySpy = LoginFactorySpy()
        let signUpFactorySpy = SignUpFactorySpy()
        let nav = NavigationController()
        let sut = WelcomeRouter(nav: nav, loginFactory: loginFactorySpy.makeLogin, signUpFactory: signUpFactorySpy.makeSignUp)
        return (sut, nav)
    }
}

extension WelcomeRouterTests {
    class LoginFactorySpy {
        func makeLogin() -> LoginViewController {
            return LoginViewController.instantiate()
        }
    }
    
    class SignUpFactorySpy {
        func makeSignUp() -> SignUpViewController {
            return SignUpViewController.instantiate()
        }
    }
}
