//
//  RegistrationViewController.swift
//  Navigation Views
//
//  Created by Salomon serfati on 5/31/16.
//  Copyright © 2016 Salomon Serfati. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var errorMessage: UILabel!
    
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
        print("We have a new customer")
        let email = emailField.text!
        let password = passwordField.text!
        
        let (failureMessage, user) = UserController.sharedInstance.registerUser(email,newPassword: password)
        
        if user != nil {
            print("User registered successfully")
        } else if failureMessage != nil {
            errorMessage.text = "registration failed: " + failureMessage!
            
        }
        
       
        
    }
  

}
