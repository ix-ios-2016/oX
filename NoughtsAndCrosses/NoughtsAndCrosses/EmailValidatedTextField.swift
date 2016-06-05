//
//  EmailValidatedTextField.swift
//  NoughtsAndCrosses
//
//  Created by Brian Ge on 6/1/16.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import UIKit

class EmailValidatedTextField: UITextField, UITextFieldDelegate {
    
    var imageView: UIImageView?
    
    // initialize text field with embedded image view
    override func drawRect(rect: CGRect) {
        
        imageView = UIImageView(frame: CGRectMake(self.frame.width-30, 5, 22, 22))
        imageView!.image = UIImage(named: "AppIcon")
        self.addSubview(imageView!)
        self.delegate = self
        
    }
    
    // check for valid email
    func valid(string: String) -> Bool {
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluateWithObject(string)
    }
    
    
    // update the image view
    func updateUI(string: String) {
        
        if self.valid(string) {
            imageView!.image = UIImage(named: "input_valid")
        }
        else {
            imageView!.image = UIImage(named: "input_invalid")
        }
        
    }
    
    
    // validate email and update image view if necessary
    func validate(string: String) -> Bool {
        
        updateUI(string)
        return valid(string)
        
    }
    
    
    // figure out currently typed string to validate
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        var newString = textField.text!
        
        if string == "" {
            
            newString.removeAtIndex(newString.startIndex.advancedBy(range.location))
            validate(newString)
        }
        else {
            newString.insertContentsOf(string.characters, at: textField.text!.startIndex.advancedBy(range.location))

            validate(newString)
        }
        
        return true
    }
    
    

}
