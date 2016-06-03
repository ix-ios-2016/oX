//
//  RegisterViewController.swift
//  NoughtsAndCrosses
//
//  Created by Kasra Koushan on 2016-05-31.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func registerButtonTapped(sender: UIButton) {
        let email = emailField.text
        let password = passwordField.text
        
        if self.emailField.validate() {
            var (failureMessage, user) = UserController.sharedInstance.registerUser(email!, newPassword: password!)
            
            if user != nil {
                // create alert controller and OK action
                let alertController = UIAlertController(title: "User registered",
                                                        message: "Your username is \(user!.email). Tap to play.",
                                                        preferredStyle: .Alert)
                let OKAction = UIAlertAction(title: "OK", style: .Default) {_ in }
                // add OK action to alert controller
                alertController.addAction(OKAction)
                // display alert
                self.presentViewController(alertController, animated: true, completion: nil)
                // now try to log in
                (failureMessage, user) = UserController.sharedInstance.loginUser(emailField.text!, suppliedPassword: passwordField.text!)
                if user != nil {
                    let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                    appDelegate.navigateToGame()
                    // save log in data
                } else if failureMessage != nil {
                    let alertController = UIAlertController(title: "Could not log in",
                                                            message: failureMessage, preferredStyle: .Alert)
                    let OKAction = UIAlertAction(title: "OK", style: .Default) { _ in}
                    alertController.addAction(OKAction)
                    self.presentViewController(alertController, animated: true, completion: nil)
                }
            } else if failureMessage != nil {
                // create alert controller and OK action
                let alertController = UIAlertController(title: "Error", message: failureMessage!, preferredStyle: .Alert)
                let OKAction = UIAlertAction(title: "OK", style: .Default) {_ in }
                // add OK action to alert controller
                alertController.addAction(OKAction)
                // display alert
                self.presentViewController(alertController, animated: true, completion: nil)
                
            }
            
        }
        
    }

}
