//
//  SignupMapper.swift
//  Presenter
//
//  Created by Manoel Filho on 19/02/22.
//

import Foundation
import Domain

public final class SignupMapper {
    static func toAddAccountModel(viewModel: SignUpViewModel) -> AddAccountModel {
        return AddAccountModel(confirmed: viewModel.confirmed!, blocked: viewModel.blocked!, username: viewModel.username!, email: viewModel.email!, password: viewModel.password!, role: viewModel.role!)
    }
}
