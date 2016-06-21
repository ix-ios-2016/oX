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
    
    let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Log In"
        emailField.delegate = self
        passwordField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        return true
    }
    
    @IBAction func loginButtonTapped(sender: AnyObject) {
        UserController.sharedInstance.loginUser(emailField.text!, password: passwordField.text!, presentingViewController: self, viewControllerCompletionFunction: {(user,message) in self.loginCallComplete(user,message:message)})
        
    }
    
    func loginCallComplete(user: User?, message:String?) {
        if (message == nil) {
            appDelegate.navigateToLoggedInNavigationController()
            NSUserDefaults.standardUserDefaults().setValue("TRUE", forKey: "userIsLoggedIn")
        } else {
            let alertController = UIAlertController(title: "Error", message: "\(message!)", preferredStyle: .Alert)
            let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in }
            alertController.addAction(cancelAction)
            let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in }
            alertController.addAction(OKAction)
            self.presentViewController(alertController, animated: true) {}
        }
    }

}