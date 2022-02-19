//
//  UIViewControllerExtensions.swift
//  UI
//
//  Created by Manoel Filho on 19/02/22.
//

import Foundation
import UIKit

extension UIViewController {
    
    func hideKeyboardOnTap(){
        let gesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        gesture.cancelsTouchesInView = false //evita conflito em cliques em tablesViews
        view.addGestureRecognizer(gesture)
    }
    
    @objc private func hideKeyboard(){
        view.endEditing(true) //fecha o teclado
    }
    
}
