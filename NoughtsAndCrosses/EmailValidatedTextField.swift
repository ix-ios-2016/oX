//
//  EmailValidatedTextField.swift
//  NoughtsAndCrosses
//
//  Created by Justin on 6/1/16.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import UIKit

class EmailValidatedTextField: UITextField, UITextFieldDelegate {
    
    
    var imageView: UIImageView = UIImageView()
    
    func valid() -> Bool{
        print("Validating email: \(self.text)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluateWithObject(self.text!)
    }
    
    func updateUI(){
        if(valid()){
            imageView.image = UIImage(named: "input_valid")
        }
        else{
            imageView.image = UIImage(named: "image_invalid")
        }
        
    }
    
    func validate() -> Bool{
        return self.valid()
    }
    
    override func drawRect(rect: CGRect) {
        imageView = UIImageView(frame: CGRectMake(self.frame.width-30, 5, 22, 22))
        self.addSubview(imageView)
        self.delegate = self
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool{
        
        print("textfield: \(self.text)")
        print("String: \(string)")
        
        
        if(string == ""){
            textField.text!.removeAtIndex(textField.text!.endIndex.predecessor())
        }
        else{
            textField.text! += string
        }
        self.updateUI()
        return false
    }
    

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
