//
//  AlertViewSpy.swift
//  PresenterTests
//
//  Created by Manoel Filho on 19/02/22.
//

import Foundation
import Presenter

class AlertViewSpy: AlertView {
    var viewModel: AlertViewModel?
    var emit: ((AlertViewModel) -> Void)?
    func observe(completion: @escaping (AlertViewModel) -> Void){
        self.emit = completion
    }
    func showMessage(viewModel: AlertViewModel) {
        self.emit?(viewModel)
    }
}
