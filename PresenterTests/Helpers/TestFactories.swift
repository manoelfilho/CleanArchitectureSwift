//
//  TestFactories.swift
//  PresenterTests
//
//  Created by Manoel Filho on 19/02/22.
//

import Foundation
import Presenter

func makeSignUpViewModel(
    confirmed: Bool? = true,
    blocked: Bool? = false,
    username: String? = "any",
    email: String? = "email@email.com",
    password: String? = "secret",
    role: Int? = 1,
    provider: String? = "local") -> SignUpViewModel {
    
    return SignUpViewModel(
        confirmed: confirmed,
        blocked: blocked,
        username: username,
        email: email,
        password: password,
        role: role,
        provider: provider
    )
        
}

func makeLoginViewModel( email: String? = "email@email.com", password: String? = "secret") -> LoginViewModel {
    return LoginViewModel( email: email, password: password)
}
