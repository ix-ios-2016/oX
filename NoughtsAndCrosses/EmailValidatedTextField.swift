//
//  EmailValidatedTextField.swift
//  NoughtsAndCrosses
//
//  Created by Luke Petruzzi on 6/1/16.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import UIKit

class EmailValidatedTextField: UITextField, UITextFieldDelegate {

    // ImageView for the text field
    var imageView = UIImageView()

    override func drawRect(rect: CGRect) {
        
        // set the delegate
        self.delegate = self
        
        //resize view
        imageView = UIImageView(frame: CGRectMake(self.frame.width-20, 10, 12, 12))
        // add the imageView to the textField
        self.addSubview(imageView)
        
    }
    
    // update the UI on every keystroke
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        // make sure the text is fully updated before checking it's valid
        textField.text! = textField.text! + string
        
        // implement backspace
        if string == "" {
            // remove the last character
            textField.text!.removeAtIndex(textField.text!.endIndex.predecessor())
        }
        updateUI()
        return false
    }
    
    // Check that the email is valid
    func valid() -> Bool
    {
        print("Validating email: " + self.text!)
        
        /* In our world, a valid email is at least 1 character, followed by an @, 
         followed by at least one character, followed by a dot followed by at least 
         2 characters. */
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluateWithObject(self.text!)
    }
    
    func updateUI()
    {
        // set the image if the email is valid
        if valid() {
            imageView.image = UIImage(named: "input_valid")
        }
        else {
            imageView.image = UIImage(named: "input_invalid")
        }
    }
    
    // do all the things for the little validation image in the email field
    func validate() -> Bool {
        updateUI()
        return valid()
    }

}
