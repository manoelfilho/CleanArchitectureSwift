//
//  AccountModelFactory.swift
//  DataTests
//
//  Created by Manoel Filho on 18/02/22.
//

import Foundation
import Domain

//Simula um AddAccountModel
func makeAddAccountModel() -> AddAccountModel {
    return AddAccountModel(confirmed: true, blocked: false, username: "any", email: "email@email.com", password: "secret", role: 1, provider: "local")
}

//simula um AccountModel
func makeAccountModel() -> AccountModel {
    return AccountModel(accessToken: "any_token")
}
