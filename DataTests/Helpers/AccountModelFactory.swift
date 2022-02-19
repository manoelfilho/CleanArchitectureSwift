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
    return AddAccountModel(confirmed: true, blocked: false, username: "any", email: "email@email.com", password: "secret", role: 2)
}

//simula um AccountModel
func makeAccountModel() -> AccountModel {
    return AccountModel(id: 1, username: "any", email: "email@email.com", provider: "local", confirmed: true, blocked: false, createdAt: "data", updatedAt: "data")
}
