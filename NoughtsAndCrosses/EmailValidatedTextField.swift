//
//  EmailValidatedTextField.swift
//  NoughtsAndCrosses
//
//  Created by Rachel on 6/1/16.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import UIKit

class EmailValidatedTextField: UITextField, UITextFieldDelegate {
    var imageView: UIImageView = UIImageView()
    var message = ""
    
    
    override func drawRect(rect: CGRect) {
        self.delegate = self
        imageView = UIImageView(frame: CGRectMake(self.frame.width-30, 5, 22, 22))
        self.addSubview(imageView)
    }
    
//    Create a function called valid that takes no params, and returns a boolean. For now, always return true.
    private func valid() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluateWithObject(message)
    }
//    Create a function called updateUI that takes no params and returns no value. Leave the body blank for now.
    func updateUI() {
        if ( self.valid() ){
            imageView.image = UIImage(  named: "input_valid" )
        }
        else {
            imageView.image = UIImage( named: "input_invalid")
        }
        
    }
    
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if ( string == "" ){
            message.removeAtIndex(message.endIndex.predecessor())
        }
        message  = message + string
        updateUI()
        return true
    }

    
    
    //Add a third function called validate that calls updateUI and returns the value of the valid function.
    func validate() -> Bool {
        self.updateUI()
        return self.valid()
    }


    

}
