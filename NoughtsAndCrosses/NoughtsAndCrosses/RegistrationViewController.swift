//
//  RegistrationViewController.swift
//  Assigment 2A
//
//  Created by Rachel on 5/31/16.
//  Copyright © 2016 Rachel Katz. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!


    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Register"
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func registerButtonTapped(sender: UIButton) {
        let email = emailField.text!
        let password = passwordField.text!
        let( failMsg , newUser ) = UserController.sharedInstance.registerUser(email, newPassword: password )
        
        if ( newUser != nil ){
            print("User registered view registration view")
            let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            
            appDelegate.navigateToBoardNavigationController()
        }
        else {
            if( failMsg != nil ){
                let alertController = UIAlertController(title: "WARNING", message: failMsg, preferredStyle: .Alert)
                
                let OKAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                
                alertController.addAction(OKAction)
                
                self.presentViewController(alertController, animated: true, completion: nil)
            }
        }
    }
    
//    @IBAction func registerButtonTapped(sender: UIButton) {
//        let email = emailField.text!
//        let password = passwordField.text!
//        let( failMsg , newUser ) = UserController.sharedInstance.registerUser(email, newPassword: password )
//        
//        if ( newUser != nil ){
//            print("User registered view registration view")
//            let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
//            
//            appDelegate.navigateToLoggedInNavigationController()
//        }
//        else {
//            if( failMsg != nil ){
//                let alertController = UIAlertController(title: "WARNING", message: failMsg, preferredStyle: .Alert)
//                
//                let OKAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
//                
//                alertController.addAction(OKAction)
//                
//                self.presentViewController(alertController, animated: true, completion: nil)
//            }
//        }
//        
//        
//    }
    
    
}
