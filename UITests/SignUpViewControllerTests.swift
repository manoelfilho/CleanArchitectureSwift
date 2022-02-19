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

}

extension SignUpViewControllerTests {
    func makeSut() -> SignUpViewController {
        let sb = UIStoryboard(name: "SignUp", bundle: Bundle(for: SignUpViewController.self))
        let sut = sb.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        sut.loadViewIfNeeded() //Forca a chamada do ViewDidLoad do UIVieController
        return sut
    }
}
