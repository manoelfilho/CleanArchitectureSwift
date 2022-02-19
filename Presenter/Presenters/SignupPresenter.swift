//
//  SignupPresenter.swift
//  Domain
//
//  Created by Manoel Filho on 17/02/22.
//

import Foundation
import Domain
import XCTest

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
    private let addAccount: AddAccount
    private let loadingView: LoadingView
    
    public init(alertView: AlertView, emailValidator: EmailValidator, addAccount: AddAccount, loadingView: LoadingView){
        self.alertView = alertView
        self.emailValidator = emailValidator
        self.addAccount = addAccount
        self.loadingView = loadingView
    }
    
    public func signUp(viewModel: SignupViewModel){
        
        if let message = validate(viewModel: viewModel) {
        
            alertView.showMessage(viewModel: AlertViewModel(title: "Falha", message: message))
        
        } else {
            
            let addAccountModel = AddAccountModel(confirmed: viewModel.confirmed!, blocked: viewModel.blocked!, username: viewModel.username!, email: viewModel.email!, password: viewModel.password!, role: viewModel.role!)
            
            loadingView.display(viewModel: LoadingViewModel(isLoading: true))
            
            addAccount.add(addAccountModel: addAccountModel) { [weak self] result in
            
                guard let self = self else { return }
                switch result {
                    case .failure:
                        self.alertView.showMessage(viewModel: AlertViewModel(title: "Erro", message: "Algo inesperado aconteceu. Tente em alguns instantes"))
                    case .success: break
                }
                self.loadingView.display(viewModel: LoadingViewModel(isLoading: false))
            }
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
        }else if !emailValidator.isValid(email: viewModel.email!) {
            return "O email informado está inválido"
        }
        return nil
    }
}
