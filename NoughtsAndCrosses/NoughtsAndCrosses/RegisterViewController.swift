//
//  RegisterViewController.swift
//  NoughtsAndCrosses
//
//  Created by Salomon serfati on 5/31/16.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var emailField: EmailValidatedTextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var registerLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Register"
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func registerButtonTapped(sender: UIButton) {
        let email = emailField.text!
        let password = passwordField.text!
        
        let (failureMessage, user) = UserController.sharedInstance.registerUser(email,newPassword: password)
        
        if emailField.validate(){
            if user != nil {
                print("The Register was Successful")
                registerLabel.text = "You have been registered!"
                let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                NSUserDefaults.standardUserDefaults().setValue("TRUE", forKey: "userIsLoggedIn")
                appDelegate.returnToOxGameNavigation()
                
            } else if failureMessage != nil {
                print("registration failed: " + failureMessage!)
                registerLabel.text = "registration failed: " + failureMessage!
                
            }
        }
        
    }
   
    
    
}