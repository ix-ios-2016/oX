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
        
        // Both fields are non-empty and the email is valid
        if email != "" && password != "" && emailField.validate()
        {
            //new registration code
            UserController.sharedInstance.registerUser(email!,password: password!, presentingViewController: self, viewControllerCompletionFunction: {(user,message) in
                self.registrationComplete(user, message: message)})
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
    
    func registrationComplete(user:User?, message:String?)
    {
        if user != nil
        {
            print("user in registerViewController: " + String(user?.email))
            
//             present logged in view
//                            let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
//                            appDelegate.navigateToLoggedInViewController()
        }
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
