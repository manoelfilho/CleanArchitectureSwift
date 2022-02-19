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
        let signUpViewModel = makeSignUpViewModel(username: nil)
        sut.signUp(viewModel: signUpViewModel)
        XCTAssertEqual(alertViewSpy.viewModel, makeRequiredAlertViewModel(fieldText: "O campo username é obrigatório"))
    }
    
    func test_signUp_should_show_message_error_if_email_is_not_provided(){
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertViewSpy:alertViewSpy)
        let signUpViewModel = makeSignUpViewModel(email: nil)
        sut.signUp(viewModel: signUpViewModel)
        XCTAssertEqual(alertViewSpy.viewModel, makeRequiredAlertViewModel(fieldText: "O campo email é obrigatório"))
    }
    
    
    func test_signUp_should_show_message_error_if_password_is_not_provided(){
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertViewSpy:alertViewSpy)
        let signUpViewModel = makeSignUpViewModel(password: nil)
        sut.signUp(viewModel: signUpViewModel)
        XCTAssertEqual(alertViewSpy.viewModel, makeRequiredAlertViewModel(fieldText: "O campo password é obrigatório"))
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
        let signUpViewModel = makeSignUpViewModel()
        emailValidatorSpy.simulateInvalidEmail()
        sut.signUp(viewModel: signUpViewModel)
        XCTAssertEqual(alertViewSpy.viewModel, makeRequiredAlertViewModel(fieldText: "O email informado está inválido"))
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
        let signUpViewModel = makeSignUpViewModel()
        sut.signUp(viewModel: signUpViewModel)
        addAccountSpy.completeWithError(.unexpected)
        XCTAssertEqual(alertViewSpy.viewModel, makeErrorAlertViewModel(fieldText: "Algo inesperado aconteceu. Tente em alguns instantes"))
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
    
    func makeSut( alertViewSpy: AlertViewSpy = AlertViewSpy(), emailValidator: EmailValidatorSpy = EmailValidatorSpy(), addAccount: AddAccountSpy = AddAccountSpy() ) -> SignupPresenter {
        let sut = SignupPresenter(alertView: alertViewSpy, emailValidator: emailValidator, addAccount: addAccount)
        return sut
    }
    
    class AlertViewSpy: AlertView {
        var viewModel: AlertViewModel?
        func showMessage(viewModel: AlertViewModel) {
            self.viewModel = viewModel
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
