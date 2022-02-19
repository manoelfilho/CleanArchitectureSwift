//
//  SignupPresenter.swift
//  Domain
//
//  Created by Manoel Filho on 17/02/22.
//

import Foundation
import Domain
import XCTest

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
                    case .success:
                        self.alertView.showMessage(viewModel: AlertViewModel(title: "Sucesso", message: "Conta criada com sucesso"))
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
