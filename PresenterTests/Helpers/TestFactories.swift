//
//  TestFactories.swift
//  PresenterTests
//
//  Created by Manoel Filho on 19/02/22.
//

import Foundation
import Presenter

func makeRequiredAlertViewModel(fieldText: String) -> AlertViewModel {
    return AlertViewModel(title: "Falha", message: fieldText)
}

func makeErrorAlertViewModel(fieldText: String) -> AlertViewModel {
    return AlertViewModel(title: "Erro", message: fieldText)
}

func makeSuccessAlertViewModel(fieldText: String) -> AlertViewModel {
    return AlertViewModel(title: "Sucesso", message: fieldText)
}

func makeSignUpViewModel(
    confirmed: Bool? = true,
    blocked: Bool? = false,
    username: String? = "any",
    email: String? = "email@email.com",
    password: String? = "secret",
    role: Int? = 2) -> SignupViewModel {
    
    return SignupViewModel(
        confirmed: confirmed,
        blocked: blocked,
        username: username,
        email: email,
        password: password,
        role: role
    )
        
}
