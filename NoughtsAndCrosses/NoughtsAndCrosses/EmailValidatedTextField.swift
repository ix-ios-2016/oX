//
//  EmailValidatedTextField.swift
//  NoughtsAndCrosses
//
//  Created by Serene Mirza on 6/1/16.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import UIKit

class EmailValidatedTextField: UITextField, UITextFieldDelegate {
    
    var imageView = UIImageView()

    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        self.delegate = self
        imageView = UIImageView(frame: CGRectMake(self.frame.width-30, 5, 22, 22))
        //imageView.image = UIImage(named: "inputField")
        self.addSubview(imageView)
    }
 
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if string != "" {
            self.text?.append(Character(string))
        }
        else {
            print("backspace occured! \(self.text?.substringToIndex((self.text?.endIndex.predecessor())!))")
            self.text = self.text?.substringToIndex((self.text?.endIndex.predecessor())!)
        }
        updateUI()
        return false
    }
    
    func valid() -> Bool {
        print("Validating email: \(self.text!)")
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluateWithObject(self.text!)
    }
    
    func updateUI() {
        if valid() == true {
            imageView.image = UIImage(named: "input_valid")
        }
        else {
            imageView.image = UIImage(named: "input_invalid")
        }
    }
    
    func validate() -> Bool {
        updateUI()
        return valid()
    }

    
    
}
