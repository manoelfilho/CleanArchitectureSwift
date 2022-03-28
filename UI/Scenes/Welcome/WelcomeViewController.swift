import Foundation
import UIKit
import Presenter

public final class WelcomeViewController: UIViewController, Storyboarded {
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    public var authenticate: (() -> Void)?
    public var signUp: (() -> Void)?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure(){
        loginButton?.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        signUpButton?.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        hideKeyboardOnTap()
    }
    
    @objc private func loginButtonTapped(){
        authenticate?()
    }
    @objc private func signUpButtonTapped(){
        signUp?()
    }
}
