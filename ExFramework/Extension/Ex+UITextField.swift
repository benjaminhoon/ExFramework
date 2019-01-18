//
//  Ex+UITextField.swift
//  ExFramework
//
//  Created by LJH on 2018. 10. 11..
//  Copyright © 2018년 JH. All rights reserved.
//

private var __maxLengths = [UITextField: Int]()
public extension UITextField{
    
    @IBInspectable public var maxLength: Int {
        get {
            guard let l = __maxLengths[self] else {
                return 150 // (global default-limit. or just, Int.max)
            }
            return l
        }
        set {
            __maxLengths[self] = newValue
            addTarget(self, action: #selector(fix), for: .editingChanged)
        }
    }
    @objc func fix(textField: UITextField) {
        let t = textField.text
        textField.text = t?.safelyLimitedTo(length: maxLength)
    }
    
    
    var isEmpty:Bool{
        get{
            if self.text?.count == 0 {
                self.becomeFirstResponder()
                return true
            }
            return false
        }
    }
    
    var isValidPhoneNumber:Bool{
        get{
            
            return true
        }
    }
}
