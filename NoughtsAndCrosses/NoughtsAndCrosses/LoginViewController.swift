//
//  LoginViewController.swift
//  NoughtsAndCrosses
//
//  Created by Erik Roberts on 6/1/16.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginButtonTapped(sender: UIButton) {
        let emailSupplied = emailField.text!
        //let emailSupplied = String(UITextField.textInRange(emailField))
        let passwordSupplied = passwordField.text!
        
        let (failure_message , user) = UserController.sharedInstance.loginUser(emailSupplied, suppliedPassword: passwordSupplied)
        
        //        If one is not present, check to see if a failure message is present and then print    the failure message.
        
        if let _ = user {
            print (user)
            
            let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate //as! casts this returned value to type AppDelegate
            
            appDelegate.navigateToGame()
            //navigateToLoggedInNavigationController
        } else {
            if let temp2 = failure_message{ //temp2 is NOT optional. If it exists, now we can use it
                print (temp2)
            }
        }
        
        //print("Login Button Tapped")
    }

}


