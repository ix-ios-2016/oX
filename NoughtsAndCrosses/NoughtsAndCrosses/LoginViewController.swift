//
//  LoginViewController.swift
//  NoughtsAndCrosses
//
//  Created by Kasra Koushan on 2016-05-31.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    // the email and password fields
    @IBOutlet var emailField: EmailValidatedTextField!
    @IBOutlet var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Login"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // action for the login button
    @IBAction func loginButtonTapped(sender: UIButton) {
        if self.emailField.valid() {
            UserController.sharedInstance.loginUser(emailField.text!, password: passwordField.text!, presentingViewController: self,
                                                    viewControllerCompletionFunction: {(user, message) in self.loginComplete(user, message: message)})
        }
        
    }
    
    // function to execute after login is completed
    func loginComplete(user: User?, message: String?) {
        if user != nil {
            // go to game view
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            appDelegate.navigateToLoggedInNavigationController()
        } else if message != nil {
            // display an alert with the provided message
            // create alert controller and OK action
            let alertController = UIAlertController(title: "Error", message: message!, preferredStyle: .Alert)
            let OKAction = UIAlertAction(title: "OK", style: .Default) {_ in }
            // add OK action to alert controller
            alertController.addAction(OKAction)
            // display alert
            self.presentViewController(alertController, animated: true, completion: nil)
            
        }
    }
    
    

}
