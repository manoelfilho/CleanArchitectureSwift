//
//  PresentationLayerTests.swift
//  PresentationLayerTests
//
//  Created by Manoel Filho on 16/02/22.
//

import XCTest
import Presenter

class SignupPresenterTests: XCTestCase {

    func test_signUp_should_show_message_error_if_username_is_not_provided(){
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertViewSpy:alertViewSpy)
        let signUpViewModel = SignupViewModel(
            confirmed: true,
            blocked: false,
            //username: "name",
            email: "email@email.com",
            password: "password",
            role: 1
        )
        sut.signUp(viewModel: signUpViewModel)
        XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Falha", message: "O campo username é obrigatório"))
    }
    
    func test_signUp_should_show_message_error_if_email_is_not_provided(){
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertViewSpy:alertViewSpy)
        let signUpViewModel = SignupViewModel(
            confirmed: true,
            blocked: false,
            username: "name",
            //email: "email@email.com",
            password: "password",
            role: 1
        )
        sut.signUp(viewModel: signUpViewModel)
        XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Falha", message: "O campo email é obrigatório"))
    }
    
    
    func test_signUp_should_show_message_error_if_password_is_not_provided(){
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertViewSpy:alertViewSpy)
        let signUpViewModel = SignupViewModel(
            confirmed: true,
            blocked: false,
            username: "name",
            email: "email@email.com",
            //password: "password",
            role: 1
        )
        sut.signUp(viewModel: signUpViewModel)
        XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Falha", message: "O campo password é obrigatório"))
    }
    
    func test_signUp_should_call_email_validator_with_correct_email(){
        let alertViewSpy = AlertViewSpy()
        let emailValidatorSpy = EmailValidatorSpy()
        let sut = makeSut(alertViewSpy:alertViewSpy, emailValidator: emailValidatorSpy)
        let signUpViewModel = SignupViewModel(
            confirmed: true,
            blocked: false,
            username: "name",
            email: "email@email.com",
            password: "password",
            role: 1
        )
        sut.signUp(viewModel: signUpViewModel)
        XCTAssertEqual(emailValidatorSpy.email, signUpViewModel.email)
    }
    
    func test_signUp_should_show_error_message_if_invalid_email_is_provided(){
        let alertViewSpy = AlertViewSpy()
        let emailValidatorSpy = EmailValidatorSpy()
        let sut = makeSut(alertViewSpy:alertViewSpy, emailValidator: emailValidatorSpy)
        let signUpViewModel = SignupViewModel(
            confirmed: true,
            blocked: false,
            username: "name",
            email: "email@email.com",
            password: "password",
            role: 1
        )
        emailValidatorSpy.isvalid = false
        sut.signUp(viewModel: signUpViewModel)
        XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Falha", message: "O email informado está inválido"))
    }

}

extension SignupPresenterTests {
    
    func makeSut( alertViewSpy: AlertViewSpy = AlertViewSpy(), emailValidator: EmailValidatorSpy = EmailValidatorSpy() ) -> SignupPresenter {
        let sut = SignupPresenter(alertView: alertViewSpy, emailValidator: emailValidator)
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
        
    }
    
}
