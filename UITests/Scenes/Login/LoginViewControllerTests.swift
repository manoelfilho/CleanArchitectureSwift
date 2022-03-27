import XCTest
import UIKit
import Presenter
@testable import UI

class LoginViewControllerTests: XCTestCase {

    func test_loading_is_hidden_on_start(){
        XCTAssertEqual(makeSut().loadingIndicator?.isAnimating, false)
    }
    
    func test_sut_implements_loadingview(){
        XCTAssertNotNil(makeSut() as LoadingView)
    }
    
    func test_sut_implements_alertview(){
        XCTAssertNotNil(makeSut() as AlertView)
    }
    
    func test_login_button_calls_login_on_tap(){
        var loginViewModel: LoginRequest?
        let sut = makeSut(loginSpy: { loginViewModel = $0 })
        sut.loginButton?.simulateTap()
        
        let email = sut.emailTextField.text
        let password = sut.passwordTextField.text
        
        XCTAssertEqual(loginViewModel, LoginRequest(email: email, password: password))
    }

}

extension LoginViewControllerTests {
    func makeSut(loginSpy: ((LoginRequest) -> Void)? = nil, file: StaticString = #filePath, line: UInt = #line) -> LoginViewController {
        let sut = LoginViewController.instantiate()
        sut.login = loginSpy
        sut.loadViewIfNeeded()
        checkMemoryLeak(for: sut, file: file, line: line)
        return sut
    }
}
