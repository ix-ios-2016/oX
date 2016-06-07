//
//  LoginViewController.swift
//  NoughtsAndCrosses
//
//  Created by Alyssa Porto on 5/31/16.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailField: EmailValidatedTextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var failureDisplay: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Log In View"
        emailField.delegate = self
        passwordField.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if textField == emailField {
            print("emailField text: \(emailField.text!)")
        } else if textField == passwordField {
            print("password text: \(passwordField.text!)")
        }
        print("string: \(string)")
        return true
    }
    
    @IBAction func loginButtonTapped(sender: AnyObject) {
        if emailField.valid() {
            let email = emailField.text!
            let password = passwordField.text!
            UserController.sharedInstance.loginUser(email, password: password, presentingViewController: nil, viewControllerCompletionFunction: {(user, message) in self.loginCallComplete(user,message:message)})
            /*
            if (user != nil) {
                print("User registered view registration view")
                let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                appDelegate.navigateToLoggedInNavigationController()
                failureDisplay.text = ""
                NSUserDefaults.standardUserDefaults().setValue("TRUE", forKey: "userIsLoggedIn")
            } else {
                if (failureMessage != nil) {
                    failureDisplay.text = failureMessage
                }
            emailField.validate()
            }
            */
        } else {
            failureDisplay.text = "Invalid Email"
        }
    }
    
    func loginCallComplete(user:User?, message:String?) {
        // We're getting this
    }

}