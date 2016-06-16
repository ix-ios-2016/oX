//
//  LoginViewController.swift
//  NoughtsAndCrosses
//
//  Created by Ingrid Polk on 5/31/16.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var userNameField: EmailValidatedTextField!
  
    
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
    
    func loginComplete(user:User?, message:String?) {
        if user != nil {
            print("User logged in view login view")
            let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            appDelegate.navigateToLoggedInNavigationController()
            //user logged in
            NSUserDefaults.standardUserDefaults().setValue("TRUE", forKey: "userIsLoggedIn") // set a value in the hard drive
        } else if message != nil {
            print(message)
            let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .Alert)
            let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in
                // ...
            }
            alertController.addAction(cancelAction)
            let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
                // ...
            }
            alertController.addAction(OKAction)
            self.presentViewController(alertController, animated: true) {
                // ...
            }
        }
    }
    
    @IBAction func loginButtonTapped(sender: UIButton) {
        let userName = userNameField.text!
        let passwordName = passwordField.text!
        UserController.sharedInstance.loginUser(userName,password: passwordName, presentingViewController: self, viewControllerCompletionFunction: {(user,message) in self.loginComplete(user,message:message)})

    }
}
