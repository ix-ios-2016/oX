//
//  LoginViewController.swift
//  NoughtsAndCrosses
//
//  Created by Brian Ge on 5/31/16.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    @IBOutlet weak var emailField: EmailValidatedTextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBAction func loginButtonTapped(sender: UIButton) {
        
        if !emailField.validate(emailField.text!) {
            let alert = UIAlertController(title: "Login Failed", message: "Invalid Email", preferredStyle: UIAlertControllerStyle.Alert)
            let closeAction = UIAlertAction(title: "Close", style: UIAlertActionStyle.Cancel, handler: nil)
            alert.addAction(closeAction)
            self.presentViewController(alert, animated: true, completion: nil)
            
            return
        }
        
        let email = emailField.text
        let password = passwordField.text
        
        if email != "" && password != "" {
            
            let (failureMessage, user) = UserController.sharedInstance.loginUser(email!, suppliedPassword: password!)
            
            if user != nil {
                print("Logged In")
                let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                appDelegate.navigateToGame()
            }
            else if failureMessage != nil {
                let alert = UIAlertController(title: "Login Failed", message: failureMessage, preferredStyle: UIAlertControllerStyle.Alert)
                let closeAction = UIAlertAction(title: "Close", style: UIAlertActionStyle.Cancel, handler: nil)
                alert.addAction(closeAction)
                self.presentViewController(alert, animated: true, completion: nil)
            }
            
        }
        else {
            
            let alert = UIAlertController(title: "Login Failed", message: "Please provide username and password", preferredStyle: UIAlertControllerStyle.Alert)
            let closeAction = UIAlertAction(title: "Close", style: UIAlertActionStyle.Cancel, handler: nil)
            alert.addAction(closeAction)
            self.presentViewController(alert, animated: true, completion: nil)
            
        }
        
    }

}
