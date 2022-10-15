import Foundation
//
//  LoadingViewSpy.swift
//  PresenterTests
//
//  Created by Manoel Filho on 19/02/22.
//

import Foundation
import Presenter

class LoadingViewSpy: LoadingView {
    var emit: ((LoadingViewModel) -> Void)?
    func observe(completion: @escaping (LoadingViewModel) -> Void){
        self.emit = completion
    }
    func display(viewModel: LoadingViewModel) {
        self.emit?(viewModel)
    }
}
