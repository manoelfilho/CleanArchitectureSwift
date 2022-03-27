//
//  SignupViewController.swift
//  UI
//
//  Created by Manoel Filho on 19/02/22.
//

import Foundation
import UIKit
import Presenter
import SwiftUI

public final class LoginViewController: UIViewController, Storyboarded {
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var loginButton: UIButton!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure(){
        hideKeyboardOnTap()
    }
    
}
