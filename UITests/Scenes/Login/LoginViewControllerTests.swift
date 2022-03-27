import XCTest
import UIKit
import Presenter
@testable import UI

class LoginViewControllerTests: XCTestCase {

    func test_loading_is_hidden_on_start(){
        XCTAssertEqual(makeSut().loadingIndicator?.isAnimating, false)
    }

}

extension LoginViewControllerTests {
    func makeSut() -> LoginController {
        let sut = LoginController.instantiate()
        sut.loadViewIfNeeded()
        return sut
    }
}
