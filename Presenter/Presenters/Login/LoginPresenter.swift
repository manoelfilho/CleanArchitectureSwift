//
//  SignupPresenter.swift
//  Domain
//
//  Created by Manoel Filho on 17/02/22.
//

import Foundation
import Domain
import XCTest

public class LoginPresenter {
    
    private let validation: Validation
    private let alertView: AlertView
    private let authentication: Authentication
    
    public init(validation: Validation, alertView: AlertView, authentication: Authentication){
        self.validation = validation
        self.alertView = alertView
        self.authentication = authentication
    }
    
    public func login(viewModel: LoginViewModel){
        if let message = validation.validate(data: viewModel.toJson()) {
            alertView.showMessage(viewModel: AlertViewModel(title: "Falha", message: message))
        } else {
            authentication.authenticate(authenticationModel: viewModel.toAuthenticationModel()){ _ in }
        }
    }
    
}
