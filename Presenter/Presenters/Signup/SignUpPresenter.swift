//
//  SignupPresenter.swift
//  Domain
//
//  Created by Manoel Filho on 17/02/22.
//

import Foundation
import Domain
import XCTest

public class SignUpPresenter {
    
    private let alertView: AlertView
    private let validation: Validation
    private let addAccount: AddAccount
    private let loadingView: LoadingView
    
    public init(alertView: AlertView, validation: Validation, addAccount: AddAccount, loadingView: LoadingView){
        self.alertView = alertView
        self.validation = validation
        self.addAccount = addAccount
        self.loadingView = loadingView
    }
    
    public func signUp(viewModel: SignUpRequest){
        
        if let message = validation.validate(data: viewModel.toJson()) {
        
            alertView.showMessage(viewModel: AlertViewModel(title: "Falha", message: message))
        
        } else {
                        
            loadingView.display(viewModel: LoadingViewModel(isLoading: true))
            
            addAccount.add(addAccountModel: viewModel.toAddAccountModel()) { [weak self] result in
            
                guard let self = self else { return }
                
                self.loadingView.display(viewModel: LoadingViewModel(isLoading: false))
                
                switch result {
                    
                    case .success:
                        self.alertView.showMessage(viewModel: AlertViewModel(title: "Sucesso", message: "Conta criada com sucesso"))
                    
                    case .failure(let error):
                        switch error {
                            case .emailInUse:
                                self.alertView.showMessage(viewModel: AlertViewModel(title: "Erro", message: "Este email já está em uso"))
                            default:
                                self.alertView.showMessage(viewModel: AlertViewModel(title: "Erro", message: "Algo inesperado aconteceu. Tente em alguns instantes"))
                        }
                    
                    
                }
                
            }
        }
        
    }
    

}
