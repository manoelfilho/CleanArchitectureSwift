import XCTest
import Presenter
import Data

class LoginPresenterTests: XCTestCase{
    
    func test_login_should_call_validation_with_correct_values(){
        let validationSpy = ValidationSpy()
        let sut = makeSut(validation: validationSpy)
        let viewModel = makeLoginViewModel()
        sut.authenticate(viewModel: viewModel)
        XCTAssertTrue(NSDictionary(dictionary: validationSpy.data!).isEqual(to: viewModel.toJson()!))
    }
    
    func test_login_should_show_message_error_if_validation_fails(){
        let alertViewSpy = AlertViewSpy()
        let validationSpy = ValidationSpy()
        let sut = makeSut(alertView:alertViewSpy, validation: validationSpy)
        let exp = expectation(description: "waiting")
        alertViewSpy.observe { viewModel in
            XCTAssertEqual(viewModel, AlertViewModel(title: "Falha", message: "Erro"))
            exp.fulfill()
        }
        validationSpy.simulateError()
        sut.authenticate(viewModel: makeLoginViewModel())
        wait(for: [exp], timeout: 1)
    }
    
    func test_login_should_call_authentication_with_correct_data(){
        let authenticationSpy = AuthenticationSpy()
        let sut = makeSut(authentication: authenticationSpy)
        sut.authenticate(viewModel: makeLoginViewModel())
        XCTAssertEqual(authenticationSpy.authenticationModel, makeAuthenticationModel())
    }
    
    func test_login_should_show_generic_error_message_if_authentication_fails(){
        let alertViewSpy = AlertViewSpy()
        let authenticationSpy = AuthenticationSpy()
        let sut = makeSut(alertView: alertViewSpy, authentication: authenticationSpy)
        let exp = expectation(description: "waiting")
        alertViewSpy.observe { viewModel in
            XCTAssertEqual(viewModel, AlertViewModel(title: "Erro", message: "Algo inesperado aconteceu. Tente em alguns instantes"))
            exp.fulfill()
        }
        sut.authenticate(viewModel: makeLoginViewModel())
        authenticationSpy.completeWithError(.unexpected)
        wait(for: [exp], timeout: 1)
    }
    
}

extension LoginPresenterTests {
    
    func makeSut(
        alertView: AlertViewSpy = AlertViewSpy(),
        validation: ValidationSpy = ValidationSpy(),
        authentication: AuthenticationSpy = AuthenticationSpy(),
        loadingView: LoadingViewSpy = LoadingViewSpy(),
        file: StaticString = #filePath, line: UInt = #line) -> LoginPresenter {
            let sut = LoginPresenter(
                validation: validation,
                alertView: alertView,
                authentication: authentication,
                loadingView: loadingView
            )
            checkMemoryLeak(for: sut, file: file, line: line)
            return sut
    }
    
}
