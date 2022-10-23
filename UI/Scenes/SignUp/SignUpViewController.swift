import Foundation
import UIKit
import Presenter
import SwiftUI

public final class SignUpViewController: UIViewController, Storyboarded {
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    public var signUp: ((SignUpRequest) -> Void)?
    
    public override func viewDidLoad() {
        super.viewDidLoad()

        configure()
    }
    
    private func configure(){
        usernameTextField.clipsToBounds = true
        emailTextField.clipsToBounds = true
        passwordTextField.clipsToBounds = true
        
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        hideKeyboardOnTap()
    }
    
    @objc private func saveButtonTapped(){
        let viewModel = SignUpRequest(username: self.usernameTextField.text, email: self.emailTextField.text, password: self.passwordTextField.text)
        signUp?(viewModel)
    }
    
}


extension SignUpViewController: LoadingView {
    public func display(viewModel: LoadingViewModel) {
        if viewModel.isLoading {
            view.isUserInteractionEnabled = false //desabilita a interacão com a tela quando o loading está ativo
            loadingIndicator.startAnimating()
        } else {
            view.isUserInteractionEnabled = true
            loadingIndicator.stopAnimating()
        }
    }
}

extension SignUpViewController: AlertView {
    public func showMessage(viewModel: AlertViewModel) {
        let alert = UIAlertController(title: viewModel.title, message: viewModel.message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
