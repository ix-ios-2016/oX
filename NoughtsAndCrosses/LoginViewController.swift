//
//  LoginViewController.swift
//  NoughtsAndCrosses
//
//  Created by Alyssa Porto on 5/31/16.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var failureDisplay: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Log In View"

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginButtonTapped(sender: AnyObject) {
        let email = emailField.text
        let password = passwordField.text
        let (failureMessage, user) = UserController.sharedInstance.loginUser(email!, suppliedPassword: password!)
        if (user != nil) {
            print("User registered view registration view")
            let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            appDelegate.navigateToLoggedInNavigationController()
            failureDisplay.text = ""
        } else {
            if (failureMessage != nil) {
                failureDisplay.text = failureMessage
            }
        }
    }

}
