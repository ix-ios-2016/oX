//
//  EmailValidatedTextField.swift
//  NoughtsAndCrosses
//
//  Created by Eden Mekonnen on 6/6/16.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import UIKit

class EmailValidatedTextField:UITextField, UITextFieldDelegate {
    var ImageView : UIImageView = UIImageView()
    
    func textField (textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        self.updateUI()
        return false
    }
    
    func valid ()->Bool {
        print("email from the text field")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluateWithObject(self.text!)
    }
    
    func updateUI() {
        if (self.valid()) {
                ImageView.image = UIImage(named:"input_valid")
    }
        else {
            ImageView.image = UIImage(named:"input_invalid")
        
    }
    
     func drawRect(rect: CGRect) {
        var imageView = UIImageView(frame: CGRectMake(self.frame.width-30, 5, 22, 22))
        self.addSubview(imageView)
        self.delegate = self
        
        
        func validate() -> Bool {
            self.updateUI()
            return self.valid()
        }
            
}
            
        
        
}
}
