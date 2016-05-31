//
//  RegistrationViewController.swift
//  NoughtsAndCrosses
//
//  Created by Brian Ge on 5/31/16.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!

    @IBAction func registerButtonTapped(sender: UIButton) {
        
        let email = emailField.text
        let password = passwordField.text
        
        if email != "" && password != "" {
            
            let (failureMessage, user) = UserController.sharedInstance.registerUser(email!, newPassword: password!)
            
            if user != nil {
                print("Registered")
                let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                appDelegate.navigateToGame()
            }
            else if failureMessage != nil {
                let alert = UIAlertController(title: "Registration Failed", message: failureMessage, preferredStyle: UIAlertControllerStyle.Alert)
                let closeAction = UIAlertAction(title: "Close", style: UIAlertActionStyle.Cancel, handler: nil)
                alert.addAction(closeAction)
                self.presentViewController(alert, animated: true, completion: nil)
            }
            
        }
        else {
            
            let alert = UIAlertController(title: "Registration Failed", message: "Please provide username and password", preferredStyle: UIAlertControllerStyle.Alert)
            let closeAction = UIAlertAction(title: "Close", style: UIAlertActionStyle.Cancel, handler: nil)
            alert.addAction(closeAction)
            self.presentViewController(alert, animated: true, completion: nil)
            
        }
        
    }

}
