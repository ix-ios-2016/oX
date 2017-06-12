//
//  EmailValidatedTextField.swift
//  NoughtsAndCrosses
//
//  Created by Alexander Ge on 6/1/16.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import UIKit

class EmailValidatedTextField: UITextField, UITextFieldDelegate {


    var imageView: UIImageView?
    
    
    override func drawRect(rect: CGRect)
    {
        
        imageView = UIImageView(frame: CGRectMake(self.frame.width-30, 5, 22, 22))
        
        self.addSubview(imageView!)
        self.delegate = self
        
    }
    
    
    // used in valid() and textfield() to print the whole email
    // used in valid() to check against the updated email. no 1 character lag
    var message = ""

    
    func valid() -> Bool
    {
        
        print("Validating email: \(message)")
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluateWithObject(message)

    }
    
    func updateUI()
    {
        
        if (valid())
        {
        
            imageView!.image = UIImage(named: "input_valid")
        
        }
        else
        {
            imageView!.image = UIImage(named: "input_invalid")

        }
    }
    
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool
    {
        
        if (string == "")
        {
            message.removeAtIndex(message.endIndex.predecessor())
        }
        else
        {
            message = message + string
        }
        print(message)
        
        updateUI()
        return true
        
    }
 
    
    func validate() -> Bool
    {
    
        updateUI()
        return valid()
    }
    
    
    
    
    
    
    
}






















