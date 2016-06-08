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
    
    // decide whether or not to log user in
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
            
            UserController.sharedInstance.loginUser(email!, password: password!, presentingViewController: self, viewControllerCompletionFunction: {(user,message) in self.loginComplete(user,message:message)})
            
        }
        else {
            
            let alert = UIAlertController(title: "Login Failed", message: "Please provide username and password", preferredStyle: UIAlertControllerStyle.Alert)
            let closeAction = UIAlertAction(title: "Close", style: UIAlertActionStyle.Cancel, handler: nil)
            alert.addAction(closeAction)
            self.presentViewController(alert, animated: true, completion: nil)
            
        }
        
    }
    
    
    func loginComplete(user: User?, message: String?) {
        
        if let _ = user {
            let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            appDelegate.authenticationNavigationController?.popViewControllerAnimated(false)
            let alert = UIAlertController(title: "Login Successful", message: "You will now be logged in", preferredStyle: UIAlertControllerStyle.Alert)
            let closeAction = UIAlertAction(title: "Close", style: UIAlertActionStyle.Cancel) {
                action -> Void in
                appDelegate.authenticationNavigationController?.popViewControllerAnimated(true)
            }
            alert.addAction(closeAction)
            self.presentViewController(alert, animated: true, completion: nil)
            appDelegate.navigateToGame()
        }
        else if let message = message {
            let alert = UIAlertController(title: "Login Failed", message: message, preferredStyle: UIAlertControllerStyle.Alert)
            let closeAction = UIAlertAction(title: "Close", style: UIAlertActionStyle.Cancel, handler: nil)
            alert.addAction(closeAction)
            self.presentViewController(alert, animated: true, completion: nil)
        }
        else {
            
        }
        
    }

}
