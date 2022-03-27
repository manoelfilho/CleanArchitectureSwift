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
    
    public init(validation: Validation){
        self.validation = validation
    }
    
    public func login(viewModel: LoginViewModel){
        _ = validation.validate(data: viewModel.toJson())
    }
    
}
