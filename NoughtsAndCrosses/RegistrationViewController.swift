//
//  RegistrationViewController.swift
//  NoughtsAndCrosses
//
//  Created by Justin on 5/31/16.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController {


    @IBOutlet weak var emailField: EmailValidatedTextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var Failure: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Register"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func registrationComplete(user: User?, message: String?) {
        //new registration code
            if let _ = user   {
                
                //successfully registered
                let alert = UIAlertController(title:"Registration Successful", message:"You will now be logged in", preferredStyle: UIAlertControllerStyle.Alert)
                let action = UIAlertAction(title: "Ok", style:UIAlertActionStyle.Default, handler: {(action) in
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
    
    
    @IBAction func RegisterButtontapped(sender: UIButton) {
        
        let email = emailField.text
        let password = passwordField.text
        UserController.sharedInstance.registerUser(email!, password: password!, presentingViewController: self, viewControllerCompletionFunction: {(user,message) in self.registrationComplete(user,message:message)})
        
        
        // Validate the email
        if(!emailField.validate()){
            emailField.updateUI()
            return
        }
        
    }


}
