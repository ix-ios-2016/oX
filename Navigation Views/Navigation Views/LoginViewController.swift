//
//  LoginViewController.swift
//  Navigation Views
//
//  Created by Salomon serfati on 5/31/16.
//  Copyright © 2016 Salomon Serfati. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var errorMessage: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Login"

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginButtonTapped(sender: UIButton) {
        print("Login 2")
        
        let email = emailField.text!
        let password = passwordField.text!
        
        let (failureMessage, user) = UserController.sharedInstance.loginUser(email, suppliedPassword: password)
        if user != nil {
            let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            appDelegate.navigateToLoggedInNavigationController()
            
            print("User logged in")
        } else if failureMessage != nil {
            errorMessage.text = "Login failed: " + failureMessage!
            
        }
        
        
        
    }


}
