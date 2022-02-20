//
//  SignUpFactory.swift
//  Main
//
//  Created by Manoel Filho on 20/02/22.
//

import Foundation
import UI
import Presenter
import Validation
import Data
import Infra

class SignUpFactory {
    
    static func makeController() -> SignUpViewController {
        
        let controller = SignUpViewController.instantiate()
        
        let emailValidatorAdapter = EmailValidatorAdapter()
        
        let alamofireAdapter = AlamofireAdapter()
        
        let url = URL(string: "\(K.api_url)/users")!
        
        let remoteAddAccount = RemoteAddAccount(url: url, httpClient: alamofireAdapter)
        
        let presenter = SignUpPresenter(
            alertView: controller,
            emailValidator: emailValidatorAdapter,
            addAccount: remoteAddAccount,
            loadingView: controller
        )
        
        controller.signUp = presenter.signUp
        
        return controller
    }
    
}
