import Foundation
import UIKit
import SwiftUI

public class RoundedTextField: UITextField {
    
    let padding = UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 25)

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    private func setup(){
        layer.cornerRadius = 25
        layer.borderColor = Color("BorderInput").cgColor
        layer.borderWidth = 0.1
    }
}
