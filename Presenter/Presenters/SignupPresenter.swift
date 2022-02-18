//
//  SignupPresenter.swift
//  Domain
//
//  Created by Manoel Filho on 17/02/22.
//

import Foundation

public struct SignupViewModel {
    
    public var confirmed: Bool?
    public var blocked: Bool?
    public var username: String?
    public var email: String?
    public var password: String?
    public var role: Int?
    
    public init(confirmed: Bool? = nil, blocked: Bool? = nil, username: String? = nil, email: String? = nil, password: String? = nil, role: Int? = nil){
        self.confirmed = confirmed
        self.blocked = blocked
        self.username = username
        self.email = email
        self.password = password
        self.role = role
    }
    
}

public class SignupPresenter {
    
    private let alertView: AlertView
    private let emailValidator: EmailValidator
    
    public init(alertView: AlertView, emailValidator: EmailValidator){
        self.alertView = alertView
        self.emailValidator = emailValidator
    }
    
    public func signUp(viewModel: SignupViewModel){
        if let message = validate(viewModel: viewModel) {
            alertView.showMessage(viewModel: AlertViewModel(title: "Falha", message: message))
        }
        
    }
    
    func validate(viewModel: SignupViewModel) -> String? {
        if viewModel.username == nil || viewModel.username!.isEmpty {
            return "O campo username é obrigatório"
        }
        if viewModel.email == nil || viewModel.email!.isEmpty {
            return "O campo email é obrigatório"
        }
        if viewModel.password == nil || viewModel.password!.isEmpty {
            return "O campo password é obrigatório"
        }
        _ = emailValidator.isValid(email: viewModel.email!)
        return nil
    }
}
