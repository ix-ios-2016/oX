//
//  EmailValidatedTextField.swift
//  NoughtsAndCrosses
//
//  Created by Kasra Koushan on 2016-06-01.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import UIKit

class EmailValidatedTextField: UITextField, UITextFieldDelegate {
    
    var imageView: UIImageView = UIImageView()

    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        self.imageView = UIImageView(frame: CGRectMake(self.frame.width-30, 5, 22, 22))
        self.addSubview(self.imageView)
        
        // set the delegate of the text field to be itself
        self.delegate = self

    }
    
    func valid() -> Bool {
        print("Trying to validate email: \(self.text!)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluateWithObject(self.text!)
    }
    
    func updateUI() {
        if self.valid() {
            self.imageView.image = UIImage(named: "input_valid")
        } else {
            self.imageView.image = UIImage(named: "input_invalid")
        }
    }
    
    func validate() -> Bool {
        self.updateUI()
        return self.valid()
    }
    
    // delegate function
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if string == "" { // backspace
            textField.text! = textField.text!.substringToIndex(textField.text!.endIndex.predecessor())
        }
        else {
            textField.text! += string
        }
        print("String to add: \(string)")
        self.updateUI()
        return false
    }

}
