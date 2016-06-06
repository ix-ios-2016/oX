//
//  RegisterViewController.swift
//  NoughtsAndCrosses
//
//  Created by Kasra Koushan on 2016-05-31.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    // email and password fields
    @IBOutlet var emailField: EmailValidatedTextField!
    @IBOutlet var passwordField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Register"

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // action for the register button
    @IBAction func registerButtonTapped(sender: UIButton) {
        let email = emailField.text
        let password = passwordField.text
        
        if self.emailField.valid() {
            // register user in the UserController class
            UserController.sharedInstance.registerUser(email!,password: password!, presentingViewController: self, viewControllerCompletionFunction: {(user,message) in self.registrationComplete(user,message:message)})
        }
        
    }
    
    
    // function to execute after registration is completed
    func registrationComplete(user:User?,message:String?) {
        if user != nil {
            // go to game view
            let alert = UIAlertController(title:"Registration Successful", message:"You will now be logged in", preferredStyle: UIAlertControllerStyle.Alert)
            let action = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: {(action) in
                //when the user clicks "Ok", do the following
                let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                appDelegate.navigateToLoggedInNavigationController()
            })
            alert.addAction(action)
            self.presentViewController(alert, animated: true, completion: nil)
        } else if message != nil {
            // display an alert with the returned message
            // create alert controller and OK action
            let alertController = UIAlertController(title: "Error", message: message!, preferredStyle: .Alert)
            let OKAction = UIAlertAction(title: "OK", style: .Default) {_ in }
            // add OK action to alert controller
            alertController.addAction(OKAction)
            // display alert
            self.presentViewController(alertController, animated: true, completion: nil)
            
        }

    }

}
