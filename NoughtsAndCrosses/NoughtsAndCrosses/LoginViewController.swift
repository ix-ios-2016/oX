//
//  LoginViewController.swift
//  NoughtsAndCrosses
//
//  Created by Alexander Ge on 6/1/16.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    
    @IBOutlet weak var emailField: EmailValidatedTextField!
        
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var userInputTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.title = "Login"
        
        /*
        emailField.delegate = self
        passwordField.delegate = self
        userInputTextField.delegate = self
 */
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    /*
    var message = ""
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool
    {
        
        if (string == "")
        {
            message.removeAtIndex(message.endIndex.predecessor())
        }
        else
        {
            message = message + string
        }
        print(message)
        return true
    }
    */

    @IBAction func loginButtonTapped(sender: UIButton)
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























