//
//  LoginViewController.swift
//  Assigment 2A
//
//  Created by Rachel on 5/31/16.
//  Copyright © 2016 Rachel Katz. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var userInputTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Login"
        
        emailField.delegate = self
        passwordField.delegate = self
        userInputTextField.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        print(string)
        if( textField == emailField ){
            print("email field was updated: " + emailField.text! + string)
        }
        else if ( textField == passwordField ){
            print("password field was updated: \(passwordField.text!)")
        }
        else if( textField == userInputTextField ){
            print("userInputTextField was updated: \(userInputTextField.text!)")
        }
        return true
    }
    
    @IBAction func loginButtonTapped(sender: UIButton) {
        let email = emailField.text!
        let password = passwordField.text!
        
        let ( failureMessage , user ) = UserController.sharedInstance.loginUser(email, suppliedPassword: password )
        
        if let userObject = user  {
            //you have been returned a valid user
            print("user login successful")
            
            let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            
            appDelegate.navigateToBoardNavigationController()
            
        }   else    {
            if let failureMessage = failureMessage   {
                let alertController = UIAlertController(title: "WARNING", message: failureMessage, preferredStyle: .Alert)
                
                let OKAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                
                alertController.addAction(OKAction)
                
                self.presentViewController(alertController, animated: true, completion: nil)
            }
        }

        
        
    }

    
}
