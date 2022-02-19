//
//  UITests.swift
//  UITests
//
//  Created by Manoel Filho on 19/02/22.
//

import XCTest
import UIKit
@testable import UI

class SignUpViewControllerTests: XCTestCase {

    func test_loading_is_hidden_on_start(){
        
        let sb = UIStoryboard(name: "SignUp", bundle: Bundle(for: SignUpViewController.self))
        let sut = sb.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        sut.loadViewIfNeeded() //Forca a chamada do ViewDidLoad do UIVieController
        XCTAssertEqual(sut.loadingIndicator?.isAnimating, false)
    
    }

}
