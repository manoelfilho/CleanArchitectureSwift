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

}

extension LoginViewControllerTests {
    func makeSut() -> LoginController {
        let sut = LoginController.instantiate()
        sut.loadViewIfNeeded()
        return sut
    }
}
