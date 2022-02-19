//
//  SignupViewController.swift
//  UI
//
//  Created by Manoel Filho on 19/02/22.
//

import Foundation
import UIKit
import Presenter

final class SignUpViewController: UIViewController, Storyboarded {
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var signUp: ((SignUpViewModel) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    private func configure(){
        saveButton.layer.cornerRadius = 5
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        hideKeyboardOnTap()
    }
    
    @objc private func saveButtonTapped(){
        let viewModel = SignUpViewModel(username: self.usernameTextField.text, email: self.emailTextField.text, password: self.passwordTextField.text)
        signUp?(viewModel)
    }
    
}


extension SignUpViewController: LoadingView {
    func display(viewModel: LoadingViewModel) {
        if viewModel.isLoading {
            view.isUserInteractionEnabled = false //desabilita a interacão com a tela quando o loading está ativo
            loadingIndicator.startAnimating()
        } else {
            loadingIndicator.stopAnimating()
        }
    }
}

extension SignUpViewController: AlertView {
    func showMessage(viewModel: AlertViewModel) {
        let alert = UIAlertController(title: viewModel.title, message: viewModel.message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
