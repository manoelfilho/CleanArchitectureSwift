//
//  SignupViewModel.swift
//  Presenter
//
//  Created by Manoel Filho on 19/02/22.
//

import Foundation
import Domain

public struct SignUpViewModel: Model {
    
    public var confirmed: Bool?
    public var blocked: Bool?
    public var username: String?
    public var email: String?
    public var password: String?
    public var role: Int?
    
    public init(confirmed: Bool? = true, blocked: Bool? = false, username: String? = nil, email: String? = nil, password: String? = nil, role: Int? = 1){
        self.confirmed = confirmed
        self.blocked = blocked
        self.username = username
        self.email = email
        self.password = password
        self.role = role
    }
    
}
