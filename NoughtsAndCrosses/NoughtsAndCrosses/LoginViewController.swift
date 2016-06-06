//
//  LoginViewController.swift
//  OnboardingDemo
//
//  Created by Luke Petruzzi on 5/31/16.
//  Copyright © 2016 Luke Petruzzi. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    // all outlets
    @IBOutlet weak var emailField: EmailValidatedTextField!
    @IBOutlet weak var passwordField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Login"
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginUser(sender: UIButton)
     {
        // get user's email and pass
        let email = self.emailField.text
        let password = self.passwordField.text
        
        if email != "" && password != "" && emailField.validate()
        {
            //new registration code
            UserController.sharedInstance.loginUser(email!, password: password!, presentingViewController: self, viewControllerCompletionFunction: {(user,message) in
                self.loginComplete(user, message: message)})
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
    
    private func loginComplete(user:User?, message:String?)
    {
        // User is good
        if user != nil
        {
            print("User logged in view login view")
            let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            appDelegate.navigateToLoggedInViewController()
        }
            
            // Failure message present
        else if message != nil
        {
            let failAlert = UIAlertController(title: "Failure", message:
                message, preferredStyle: UIAlertControllerStyle.Alert)
            let okButton = UIAlertAction(title: "Okay", style: .Default, handler: nil)
            failAlert.addAction(okButton)
            
            // Present the message
            self.presentViewController(failAlert, animated: true, completion: nil)
        }
        
    }
    
    
}
