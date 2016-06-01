//
//  EmailValidatedTextField.swift
//  NoughtsAndCrosses
//
//  Created by Alyssa Porto on 6/1/16.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import UIKit

class EmailValidatedTextField: UITextField, UITextFieldDelegate {
    
    var imageView: UIImageView!
    
    override func drawRect(rect: CGRect) {
        imageView = UIImageView(frame: CGRectMake(self.frame.width-30, 5, 22, 22))
        self.addSubview(imageView)
        print("drawRect")
        self.delegate = self
    }
    
    func valid() -> Bool {
        print("Validating email: \(self.text)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        print(emailTest.evaluateWithObject(self.text!))
        return emailTest.evaluateWithObject(self.text!)
    }
    
    func updateUI() {
        print("updateUI")
        if self.valid() {
            imageView.image = UIImage(named: "input_valid")
        } else {
            imageView.image = UIImage(named: "input_invalid")
        }
        
    }
    
    func validate() -> Bool {
        print("validate")
        self.updateUI()
        return self.valid()
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if string == "" {
            textField.text!.removeAtIndex(textField.text!.endIndex.predecessor())
        } else {
            textField.text = textField.text! + string
        }
        self.updateUI()
        return false
    }

    
}
