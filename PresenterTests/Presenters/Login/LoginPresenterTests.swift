import XCTest
import Presenter

class LoginPresenterTests: XCTestCase{
    
    func test_login_should_call_validation_with_correct_values(){
        let validationSpy = ValidationSpy()
        let sut = makeSut(validationSpy: validationSpy)
        let viewModel = makeLoginViewModel()
        sut.login(viewModel: viewModel)
        XCTAssertTrue(NSDictionary(dictionary: validationSpy.data!).isEqual(to: viewModel.toJson()!))
    }
    
}

extension LoginPresenterTests {
    
    func makeSut(
        validationSpy: ValidationSpy = ValidationSpy(),
        file: StaticString = #filePath, line: UInt = #line) -> LoginPresenter {
            let sut = LoginPresenter(
                validation: validationSpy
            )
            checkMemoryLeak(for: sut, file: file, line: line)
            return sut
    }
    
}
