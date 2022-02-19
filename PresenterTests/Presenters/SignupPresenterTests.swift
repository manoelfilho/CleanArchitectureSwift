//
//  PresentationLayerTests.swift
//  PresentationLayerTests
//
//  Created by Manoel Filho on 16/02/22.
//

import XCTest
import Presenter
import Domain
import Data

class SignupPresenterTests: XCTestCase {

    func test_signUp_should_show_message_error_if_username_is_not_provided(){
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertViewSpy:alertViewSpy)
        let exp = expectation(description: "waiting")
        alertViewSpy.observe { [weak self] viewModel in
            XCTAssertEqual(viewModel, self?.makeRequiredAlertViewModel(fieldText: "O campo username é obrigatório"))
            exp.fulfill()
        }
        sut.signUp(viewModel: makeSignUpViewModel(username: nil))
        wait(for: [exp], timeout: 1)
    }
    
    func test_signUp_should_show_message_error_if_email_is_not_provided(){
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertViewSpy:alertViewSpy)
        let exp = expectation(description: "waiting")
        alertViewSpy.observe { [weak self] viewModel in
            XCTAssertEqual(viewModel, self?.makeRequiredAlertViewModel(fieldText: "O campo email é obrigatório"))
            exp.fulfill()
        }
        sut.signUp(viewModel: makeSignUpViewModel(email: nil))
        wait(for: [exp], timeout: 1)
    }
    
    
    func test_signUp_should_show_message_error_if_password_is_not_provided(){
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertViewSpy:alertViewSpy)
        let exp = expectation(description: "waiting")
        alertViewSpy.observe { [weak self] viewModel in
            XCTAssertEqual(viewModel, self?.makeRequiredAlertViewModel(fieldText: "O campo password é obrigatório"))
            exp.fulfill()
        }
        sut.signUp(viewModel: makeSignUpViewModel(password: nil))
        wait(for: [exp], timeout: 1)
    }
    
    func test_signUp_should_call_email_validator_with_correct_email(){
        let alertViewSpy = AlertViewSpy()
        let emailValidatorSpy = EmailValidatorSpy()
        let sut = makeSut(alertViewSpy:alertViewSpy, emailValidator: emailValidatorSpy)
        let signUpViewModel = makeSignUpViewModel()
        sut.signUp(viewModel: signUpViewModel)
        XCTAssertEqual(emailValidatorSpy.email, signUpViewModel.email)
    }
    
    func test_signUp_should_show_error_message_if_invalid_email_is_provided(){
        let alertViewSpy = AlertViewSpy()
        let emailValidatorSpy = EmailValidatorSpy()
        let sut = makeSut(alertViewSpy:alertViewSpy, emailValidator: emailValidatorSpy)
        let exp = expectation(description: "waiting")
        alertViewSpy.observe { [weak self] viewModel in
            XCTAssertEqual(viewModel, self?.makeRequiredAlertViewModel(fieldText: "O email informado está inválido"))
            exp.fulfill()
        }
        emailValidatorSpy.simulateInvalidEmail()
        sut.signUp(viewModel: makeSignUpViewModel())
        wait(for: [exp], timeout: 1)
    }
    
    func test_signup_shoul_call_addAccount_with_correct_data(){
        let addAccountSpy = AddAccountSpy()
        let sut = makeSut(addAccount: addAccountSpy)
        sut.signUp(viewModel: makeSignUpViewModel())
        XCTAssertEqual(addAccountSpy.addAccountModel, makeAddAccountModel())
    }
    
    func test_signUp_should_show_error_message_if_addAccount_fails(){
        let alertViewSpy = AlertViewSpy()
        let addAccountSpy = AddAccountSpy()
        let sut = makeSut(alertViewSpy:alertViewSpy, addAccount: addAccountSpy)
        let exp = expectation(description: "waiting")
        alertViewSpy.observe { [weak self] viewModel in
            XCTAssertEqual(viewModel, self?.makeErrorAlertViewModel(fieldText: "Algo inesperado aconteceu. Tente em alguns instantes"))
            exp.fulfill()
        }
        sut.signUp(viewModel: makeSignUpViewModel())
        addAccountSpy.completeWithError(.unexpected)
        wait(for: [exp], timeout: 1)
    }
    
    func test_signUp_should_show_loading_before_and_after_call_add_account(){
        let loadingViewSpy = LoadingViewSpy()
        let addAccountSpy = AddAccountSpy()
        let sut = makeSut(addAccount: addAccountSpy, loadingViewSpy: loadingViewSpy)
       
        let exp = expectation(description: "waiting")
        loadingViewSpy.observe { viewModel in
            XCTAssertEqual(viewModel, LoadingViewModel(isLoading: true))
            exp.fulfill()
        }
        sut.signUp(viewModel: makeSignUpViewModel())
        
        wait(for: [exp], timeout: 1)
        
        let exp2 = expectation(description: "waiting")
        loadingViewSpy.observe { viewModel in
            XCTAssertEqual(viewModel, LoadingViewModel(isLoading: false))
            exp2.fulfill()
        }
        addAccountSpy.completeWithError(.unexpected)
        
        wait(for: [exp2], timeout: 1)
        
    }

}

extension SignupPresenterTests {
    
    class AddAccountSpy: AddAccount {
        
        var addAccountModel: AddAccountModel?
        var completion: ((Result<AccountModel, DomainError>)->Void)?
        
        func add(addAccountModel: AddAccountModel, completion: @escaping (Result<AccountModel, DomainError>) -> Void) {
            self.addAccountModel = addAccountModel
            self.completion = completion
        }
        func completeWithError(_ error: DomainError){
            completion?(.failure(error))
        }
        
    }
    
    func makeRequiredAlertViewModel(fieldText: String) -> AlertViewModel {
        return AlertViewModel(title: "Falha", message: fieldText)
    }
    
    func makeErrorAlertViewModel(fieldText: String) -> AlertViewModel {
        return AlertViewModel(title: "Erro", message: fieldText)
    }
    
    func makeSut(
        alertViewSpy: AlertViewSpy = AlertViewSpy(),
        emailValidator: EmailValidatorSpy = EmailValidatorSpy(),
        addAccount: AddAccountSpy = AddAccountSpy(),
        loadingViewSpy: LoadingViewSpy = LoadingViewSpy(),
        file: StaticString = #filePath, line: UInt = #line) -> SignupPresenter {
            
            let sut = SignupPresenter(alertView: alertViewSpy, emailValidator: emailValidator, addAccount: addAccount, loadingView: loadingViewSpy)
        checkMemoryLeak(for: sut, file: file, line: line)
        return sut
    }
    
    class AlertViewSpy: AlertView {
        var viewModel: AlertViewModel?
        var emit: ((AlertViewModel) -> Void)?
        func observe(completion: @escaping (AlertViewModel) -> Void){
            self.emit = completion
        }
        func showMessage(viewModel: AlertViewModel) {
            self.emit?(viewModel)
        }
    }
    
    class LoadingViewSpy: LoadingView {
        var emit: ((LoadingViewModel) -> Void)?
        func observe(completion: @escaping (LoadingViewModel) -> Void){
            self.emit = completion
        }
        func display(viewModel: LoadingViewModel) {
            self.emit?(viewModel)
        }
    }
    
    class EmailValidatorSpy: EmailValidator {
        
        var isvalid = true
        var email: String?
        
        func isValid(email: String) -> Bool {
            self.email = email
            return isvalid
        }
        
        func simulateInvalidEmail(){
            self.isvalid = false
        }
        
    }
    
    func makeSignUpViewModel(
        confirmed: Bool? = true,
        blocked: Bool? = false,
        username: String? = "any",
        email: String? = "email@email.com",
        password: String? = "secret",
        role: Int? = 2) -> SignupViewModel {
        
        return SignupViewModel(
            confirmed: confirmed,
            blocked: blocked,
            username: username,
            email: email,
            password: password,
            role: role
        )
            
    }
    
}
