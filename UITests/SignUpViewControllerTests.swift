//
//  UITests.swift
//  UITests
//
//  Created by Manoel Filho on 19/02/22.
//

import XCTest
import UIKit
import Presenter
@testable import UI

class SignUpViewControllerTests: XCTestCase {

    func test_loading_is_hidden_on_start(){
        XCTAssertEqual(makeSut().loadingIndicator?.isAnimating, false)
    }
    
    func test_sut_implements_loadingview(){
        XCTAssertNotNil(makeSut() as LoadingView)
    }
    
    func test_sut_implements_alertview(){
        XCTAssertNotNil(makeSut() as AlertView)
    }
    
    func test_save_button_calls_signup_on_tap(){
        var signUpViewModel: SignUpViewModel?
        let sut = makeSut(signUpSpy: { signUpViewModel = $0 })
        sut.saveButton?.simulateTap()
        
        let username = sut.usernameTextField.text
        let email = sut.emailTextField.text
        let password = sut.passwordTextField.text
        
        XCTAssertEqual(signUpViewModel, SignUpViewModel(username: username, email: email, password: password))
    }

}

extension SignUpViewControllerTests {
    func makeSut(signUpSpy: ((SignUpViewModel) -> Void)? = nil) -> SignUpViewController {
        let sb = UIStoryboard(name: "SignUp", bundle: Bundle(for: SignUpViewController.self))
        let sut = sb.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        
        sut.signUp = signUpSpy
        
        sut.loadViewIfNeeded() //Forca a chamada do ViewDidLoad do UIVieController
        return sut
    }
}

extension UIControl {
    func simulate(event: UIControl.Event){
        allTargets.forEach { target in
            actions(forTarget: target, forControlEvent: event)?.forEach { action in
                (target as NSObject).perform(Selector(action))
            }
        }
    }
    func simulateTap(){
        simulate(event: .touchUpInside)
    }
}
