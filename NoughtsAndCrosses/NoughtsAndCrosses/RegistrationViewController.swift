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
    

    func registrationComplete(user:User?,message:String?) {
        
        if let _ = user   {
            
            //successfully registered
            let alert = UIAlertController(title:"Registration Successful", message:"You will now be logged in", preferredStyle: UIAlertControllerStyle.Alert)
            let action = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: {(action) in
                //when the user clicks "Ok", do the following
                let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                appDelegate.navigateToBoardNavigationController()
            })
            alert.addAction(action)
            self.presentViewController(alert, animated: true, completion: nil)
            
        }   else    {
            
            //registration failed
            let alert = UIAlertController(title:"Registration Failed", message:message!, preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: {
                
            })
            
        }
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
        
        UserController.sharedInstance.registerUser(email,password: password, presentingViewController: self, viewControllerCompletionFunction: {(user,message) in self.registrationComplete(user,message:message)})
        

        
        /*
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
 */

    }
    
    
    
    
    
    
    
    
    
    
    
    
    
}




















