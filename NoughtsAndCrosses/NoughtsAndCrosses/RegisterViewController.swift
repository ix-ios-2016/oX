//
//  RegisterViewController.swift
//  OnboardingDemo
//
//  Created by Luke Petruzzi on 5/31/16.
//  Copyright © 2016 Luke Petruzzi. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    // all Outlets
    @IBOutlet weak var emailField: EmailValidatedTextField!
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
    
    // Handle when the registerButton is tapped
    @IBAction func registerUser(sender: UIButton) {
        // get user's email and pass
        let email = self.emailField.text
        let password = self.passwordField.text
        
        // only using one instance of UserController
        let userController = UserController.sharedInstance
        
        // Both fields are non-empty and the email is valid
        if email != "" && password != "" && emailField.validate()
        {
            let (failure_message, user) = userController.registerUser(email!, newPassword: password!)
            
            if user != nil{
                print("User registered view registration view")
            }
            else if failure_message != nil {
                let failAlert = UIAlertController(title: "Failure", message:
                    failure_message, preferredStyle: UIAlertControllerStyle.Alert)
                let okButton = UIAlertAction(title: "Okay", style: .Default, handler: nil)
                failAlert.addAction(okButton)
                
                // Present the message
                self.presentViewController(failAlert, animated: true, completion: nil)
            }
        }
        else
        {
            let failAlert = UIAlertController(title: "Failure", message:
                "One or more fields are empty \nOR\nYour email is invalid", preferredStyle: UIAlertControllerStyle.Alert)
            let okButton = UIAlertAction(title: "Okay", style: .Default, handler: nil)
            failAlert.addAction(okButton)
            
            // Present the message
            self.presentViewController(failAlert, animated: true, completion: nil)
        }
    }

    
    
}
