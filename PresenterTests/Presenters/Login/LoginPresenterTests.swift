import XCTest
import Presenter
import Data

class LoginPresenterTests: XCTestCase{
    
    func test_login_should_call_validation_with_correct_values(){
        let validationSpy = ValidationSpy()
        let sut = makeSut(validationSpy: validationSpy)
        let viewModel = makeLoginViewModel()
        sut.login(viewModel: viewModel)
        XCTAssertTrue(NSDictionary(dictionary: validationSpy.data!).isEqual(to: viewModel.toJson()!))
    }
    
    func test_login_should_show_message_error_if_validation_fails(){
        let alertViewSpy = AlertViewSpy()
        let validationSpy = ValidationSpy()
        let sut = makeSut(alertView:alertViewSpy, validationSpy: validationSpy)
        let exp = expectation(description: "waiting")
        alertViewSpy.observe { viewModel in
            XCTAssertEqual(viewModel, AlertViewModel(title: "Falha", message: "Erro"))
            exp.fulfill()
        }
        validationSpy.simulateError()
        sut.login(viewModel: makeLoginViewModel())
        wait(for: [exp], timeout: 1)
    }
    
}

extension LoginPresenterTests {
    
    func makeSut(
        alertView: AlertViewSpy = AlertViewSpy(),
        validationSpy: ValidationSpy = ValidationSpy(),
        file: StaticString = #filePath, line: UInt = #line) -> LoginPresenter {
            let sut = LoginPresenter(
                validation: validationSpy,
                alertView: alertView
            )
            checkMemoryLeak(for: sut, file: file, line: line)
            return sut
    }
    
}
