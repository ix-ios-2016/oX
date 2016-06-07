//
//  RegistrationViewController.swift
//  NoughtsAndCrosses
//
//  Created by Brian Ge on 5/31/16.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController {

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

    // decide whether or not to register user
    @IBAction func registerButtonTapped(sender: UIButton) {
        
        if !emailField.validate(emailField.text!) {
            let alert = UIAlertController(title: "Registration Failed", message: "Invalid Email", preferredStyle: UIAlertControllerStyle.Alert)
            let closeAction = UIAlertAction(title: "Close", style: UIAlertActionStyle.Cancel, handler: nil)
            alert.addAction(closeAction)
            self.presentViewController(alert, animated: true, completion: nil)
            
            return
        }
        
        let email = emailField.text
        let password = passwordField.text
        
        if email != "" && password != "" {
            
            UserController.sharedInstance.registerUser(email!, password: password!, presentingViewController: self, viewControllerCompletionFunction: {(user,message) in self.registrationComplete(user,message:message)})
            
        }
        else {
            
            let alert = UIAlertController(title: "Registration Failed", message: "Please provide username and password", preferredStyle: UIAlertControllerStyle.Alert)
            let closeAction = UIAlertAction(title: "Close", style: UIAlertActionStyle.Cancel, handler: nil)
            alert.addAction(closeAction)
            self.presentViewController(alert, animated: true, completion: nil)
            
        }
        
    }
    
    func registrationComplete(user: User?, message: String?) {
        
        if let _ = user {
            let alert = UIAlertController(title: "Registration Successful", message: "You will now be logged in", preferredStyle: UIAlertControllerStyle.Alert)
            let closeAction = UIAlertAction(title: "Close", style: UIAlertActionStyle.Cancel, handler: nil)
            alert.addAction(closeAction)
            self.presentViewController(alert, animated: true, completion: nil)
            let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            appDelegate.navigateToGame()
        }
        else if let message = message {
            let alert = UIAlertController(title: "Registration Failed", message: message, preferredStyle: UIAlertControllerStyle.Alert)
            let closeAction = UIAlertAction(title: "Close", style: UIAlertActionStyle.Cancel, handler: nil)
            alert.addAction(closeAction)
            self.presentViewController(alert, animated: true, completion: nil)
        }
        else {
            
        }
        
    }

}
