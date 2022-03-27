import Foundation
import UIKit
import Presenter

class WelcomeViewController: UIViewController, Storyboarded {
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    public var login: (() -> Void)?
    public var signUp: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure(){
        loginButton?.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        signUpButton?.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        hideKeyboardOnTap()
    }
    
    @objc private func loginButtonTapped(){
        login?()
    }
    @objc private func signUpButtonTapped(){
        signUp?()
    }
}
