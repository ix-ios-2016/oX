//
//  EmailValidatedTextField.swift
//  NoughtsAndCrosses
//
//  Created by Erik Roberts on 6/1/16.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import UIKit

class EmailValidatedTextField: UITextField , UITextFieldDelegate {
    //inherits all of the UITextField elements so it is still technically a UITextField. That's why
    var imageView : UIImageView = UIImageView()
    
    override func drawRect (rect : CGRect) {
        
        self.delegate = self
        
        imageView = UIImageView(frame: CGRectMake(self.frame.width-30, 5, 22, 22))
        //imageView.image = UIImage(named: "input_valid") //(named: "input_valid")
        self.addSubview(imageView)
        
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if (string == "") {
            
            var substring = (textField.text! as! NSString).substringToIndex(textField.text!.characters.count-1)
            
            textField.text = substring
            updateUI()
            
            return false
        }   else    {
            print(self.text)
            
            //print("\(textField.text) string param \(string)")
            textField.text = textField.text! + string
            
            updateUI()
            
            return false
        }
        
        
            
       
    }

    func valid() -> Bool {
        print ("Validaing email: \(self.text!)")
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluateWithObject(self.text!)
        
    }
    
    func updateUI () {
       
        if (valid()){
            imageView.image = UIImage (named : "input_valid")
        } else {
            imageView.image = UIImage (named : "input_invalid")
        }
    }
    func validate() -> Bool {
        updateUI()
        
        return self.valid()
    
}
}