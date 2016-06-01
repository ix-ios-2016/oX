//
//  LoginViewController.swift
//  NoughtsAndCrosses
//
//  Created by Alexander Ge on 6/1/16.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    
    
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.title = "Login"
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func loginButtonTapped(sender: UIButton)
    {
        
        let email = emailField.text!
        let password = passwordField.text!
        
        let (failureMessage, user) = UserController.sharedInstance.loginUser(email, suppliedPassword: password)
        
        
        if (user != nil)
        {
            
            let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            appDelegate.navigateToBoardNavigationController()
        }
        else if (failureMessage != nil)
        {
            let alertController = UIAlertController(title: "WARNING", message: failureMessage, preferredStyle: .Alert)
            
            
            let OKAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            
            alertController.addAction(OKAction)
            
            self.presentViewController(alertController, animated: true, completion: nil)
        }
        else
        {
            print("failed")
        }

        
        
    }

    
    
    
    
}























