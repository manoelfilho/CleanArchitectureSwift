import XCTest
import UIKit
import Presenter
@testable import UI

class WelcomeViewControllerTests: XCTestCase {
    
    func test_login_button_calls_login_on_tap(){
        let (sut, buttonSpy) = makeSut()
        sut.loginButton?.simulateTap()
        XCTAssertEqual(buttonSpy.clicks, 1)
    }
    
    func test_signUp_button_calls_signUp_on_tap(){
        let (sut, signUpButton) = makeSut()
        sut.signUpButton?.simulateTap()
        XCTAssertEqual(signUpButton.clicks, 1)
    }

}

extension WelcomeViewControllerTests {
    func makeSut() -> (sut: WelcomeViewController, buttonSpy: ButtonSpy) {
        let buttonSpy = ButtonSpy()
        let sut = WelcomeViewController.instantiate()
        sut.authenticate = buttonSpy.onClick
        sut.signUp = buttonSpy.onClick
        sut.loadViewIfNeeded()
        checkMemoryLeak(for: sut)
        return (sut, buttonSpy)
    }
    
    class ButtonSpy {
        var clicks = 0
        func onClick(){
            self.clicks += 1
        }
    }
}
