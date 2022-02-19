//
//  EmailvalidatorSpy.swift
//  PresenterTests
//
//  Created by Manoel Filho on 19/02/22.
//

import Foundation
import Presenter

class EmailValidatorSpy: EmailValidator {
    
    var isvalid = true
    var email: String?
    
    func isValid(email: String) -> Bool {
        self.email = email
        return isvalid
    }
    
    func simulateInvalidEmail(){
        self.isvalid = false
    }
    
}
