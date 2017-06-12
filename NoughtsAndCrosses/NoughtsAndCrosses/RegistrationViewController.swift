//
//  RegistrationViewController.swift
//  NoughtsAndCrosses
//
//  Created by Chris Motz on 6/1/16.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Register"


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var emailTextField: EmailValidatedTextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func registrationButtonTapped(sender: AnyObject) {

        
        if (emailTextField.valid()) {
            
            let username = emailTextField.text
            let password = passwordTextField.text
            
            
            //new registration code
            UserController.sharedInstance.registerUser(username!,password: password!, presentingViewController: self, viewControllerCompletionFunction: {(user,message) in self.registrationComplete(user,message:message)})
            
        
            emailTextField.validate()
            print("Register here!")
        } else {
            emailTextField.updateUI()
        }
    }
    
    func registrationComplete(user:User?,message:String?) {
        
        if let _ = user   {
            
            //successfully registered
            let alert = UIAlertController(title:"Registration Successful", message:"You will now be logged in", preferredStyle: UIAlertControllerStyle.Alert)
            let action = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: {(action) in
                //when the user clicks "Ok", do the following
                let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                appDelegate.navigateToBoardViewController()
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

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
