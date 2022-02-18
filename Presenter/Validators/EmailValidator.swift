//
//  EmailValidator.swift
//  Presenter
//
//  Created by Manoel Filho on 17/02/22.
//

import Foundation

public protocol EmailValidator {
    func isValid(email: String) -> Bool
}
