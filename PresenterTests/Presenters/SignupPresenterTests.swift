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
        let (sut, alertViewSpy) = makeSut()
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
        let (sut, alertViewSpy) = makeSut()
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
        let (sut, alertViewSpy) = makeSut()
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

}

extension SignupPresenterTests {
    
    func makeSut() -> (sut: SignupPresenter, alertViewSpy: AlertViewSpy) {
        let alertViewSpy = AlertViewSpy()
        let sut = SignupPresenter(alertView: alertViewSpy)
        return (sut, alertViewSpy)
    }
    
    class AlertViewSpy: AlertView {
        var viewModel: AlertViewModel?
        func showMessage(viewModel: AlertViewModel) {
            self.viewModel = viewModel
        }
    }
    
}
