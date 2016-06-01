//
//  RegistrationViewController.swift
//  NoughtsAndCrosses
//
//  Created by Alexander Ge on 6/1/16.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController {

    
    
    @IBOutlet weak var emailField: EmailValidatedTextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.title = "Register"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    @IBAction func registrationButtonTapped(sender: UIButton)
    {
        
        
        let email = emailField.text!
        let password = passwordField.text!
        
        if (!emailField.validate())
        {
            
            let alertController = UIAlertController(title: "WARNING", message: "Not a valid email address", preferredStyle: .Alert)
            
            
            let OKAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            
            alertController.addAction(OKAction)
            
            self.presentViewController(alertController, animated: true, completion: nil)
            
            return
        }
        
        let (failureMessage, user) = UserController.sharedInstance.registerUser(email, newPassword: password)
        
        
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




















