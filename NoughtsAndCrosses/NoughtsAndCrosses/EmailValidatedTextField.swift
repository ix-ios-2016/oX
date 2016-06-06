//
//  EmailValidatedTextField.swift
//  NoughtsAndCrosses
//
//  Created by Chris Motz on 6/1/16.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import UIKit

class EmailValidatedTextField: UITextField, UITextFieldDelegate {
    
    var imageView: UIImageView = UIImageView()

    
    override func drawRect(rect: CGRect) {
        imageView = UIImageView(frame: CGRectMake(self.frame.width-30, 5, 22, 22))
        addSubview(imageView)
        self.delegate = self
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        updateUI()
        return true
    }
    
    func valid() -> Bool {
        print("Validating email: \(self.text!)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
        return emailTest.evaluateWithObject(self.text!)
    }
    
    func updateUI() {
        if (valid()) {
            imageView.image = UIImage(named: "input_valid")
        }   else {
            imageView.image = UIImage(named: "input_invalid")
        }
    }
    
    func validate() -> Bool {
        self.updateUI()
        return self.valid()
    }

    
}
