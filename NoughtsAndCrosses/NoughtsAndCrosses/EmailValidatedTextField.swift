//
//  EmailValidatedTextField.swift
//  NoughtsAndCrosses
//
//  Created by Eden Mekonnen on 6/6/16.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import UIKit

class EmailValidatedTextField:UITextField {
    var ImageView : UIImageView = UIImageView()
    
    
    func valid ()->Bool {
        return true
        print("email from the text field")
    }
    
    func updateUI() {
    
    }
    
    override func drawRect(rect: CGRect) {
        var imageView = UIImageView(frame: CGRectMake(self.frame.width-30, 5, 22, 22))
        self.addSubview(imageView)
        
}
    
}