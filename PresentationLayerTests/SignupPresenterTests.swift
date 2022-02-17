//
//  PresentationLayerTests.swift
//  PresentationLayerTests
//
//  Created by Manoel Filho on 16/02/22.
//

import XCTest

class SignupPresenter {
    
    private let alertView: AlertView
    
    init(alertView: AlertView){
        self.alertView = alertView
    }
    
    func signUp(viewModel: SignupViewModel){
        if viewModel.username == nil || viewModel.username!.isEmpty {
            alertView.showMessage(viewModel: AlertViewModel(title: "title", message: "O campo username é obrigatório"))
        }
    }
}

protocol AlertView {
    func showMessage(viewModel: AlertViewModel)
}

struct AlertViewModel: Equatable {
    var title: String
    var message: String
}

struct SignupViewModel {
    var confirmed: Bool?
    var blocked: Bool?
    var username: String?
    var email: String?
    var password: String?
    var role: Int?
}

class SignupPresenterTests: XCTestCase {

    func test_signUp_should_show_message_error_if_username_is_not_provided(){
        let alertViewSpy = AlertViewSpy()
        let sut = SignupPresenter(alertView: alertViewSpy)
        let signUpViewModel = SignupViewModel(
            confirmed: true,
            blocked: false,
            //username: "name",
            email: "email@email.com",
            password: "password",
            role: 1
        )
        sut.signUp(viewModel: signUpViewModel)
        XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "title", message: "O campo username é obrigatório"))
    }

}

extension SignupPresenterTests {
    
    class AlertViewSpy: AlertView {
        var viewModel: AlertViewModel?
        func showMessage(viewModel: AlertViewModel) {
            self.viewModel = viewModel
        }
        
    }
    
}