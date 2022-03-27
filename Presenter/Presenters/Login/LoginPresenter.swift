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
    private let loadingView: LoadingView
    
    public init(validation: Validation, alertView: AlertView, authentication: Authentication, loadingView: LoadingView){
        self.validation = validation
        self.alertView = alertView
        self.authentication = authentication
        self.loadingView = loadingView
    }
    
    public func login(viewModel: LoginRequest){
       
        if let message = validation.validate(data: viewModel.toJson()) {
        
            alertView.showMessage(viewModel: AlertViewModel(title: "Falha", message: message))
        
        } else {
            
            loadingView.display(viewModel: LoadingViewModel(isLoading: true))
            
            authentication.authenticate(authenticationModel: viewModel.toAuthenticationModel()) { [weak self] result in
            
                guard let self = self else { return }
                
                self.loadingView.display(viewModel: LoadingViewModel(isLoading: false))
                
                switch result {
                    
                    case .success:
                        self.alertView.showMessage(viewModel: AlertViewModel(title: "Sucesso", message: "Login realizado com sucesso"))
                    
                    case .failure(let error):
                        switch error {
                            case .expiredSession:
                                self.alertView.showMessage(viewModel: AlertViewModel(title: "Erro", message: "Email e/ou senha inválido(s)"))
                            default:
                                self.alertView.showMessage(viewModel: AlertViewModel(title: "Erro", message: "Algo inesperado aconteceu. Tente em alguns instantes"))
                        }
                    
                    
                }
                
            }
        }
    }
    
}
