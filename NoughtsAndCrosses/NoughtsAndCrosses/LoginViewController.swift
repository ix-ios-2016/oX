//
//  LoginViewController.swift
//  NoughtsAndCrosses
//
//  Created by Erik Roberts on 6/1/16.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController , UITextFieldDelegate {

    @IBOutlet weak var emailField: EmailValidatedTextField!

    @IBOutlet weak var passwordField: UITextField!
    
    var lastString : String?
    
    var imageView : UIImageView = UIImageView()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        

        emailField.delegate = self
        //passwordField.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        
          self.navigationController?.navigationBarHidden = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func loginButtonTapped(sender: UIButton) {
        let emailSupplied = emailField.text!
        //let emailSupplied = String(UITextField.textInRange(emailField))
        let passwordSupplied = passwordField.text!
        
        UserController.sharedInstance.loginUser(emailSupplied, password: passwordSupplied, presentingViewController: self, viewControllerCompletionFunction: {(user,message) in self.loginCallComplete(user, message: message)})
        
        //        If one is not present, check to see if a failure message is present and then print    the failure message.

        }
    
    func loginCallComplete(user : User? , message : String?) {
            
        if let _ = user   {
                
            //successfully logged in
            let alert = UIAlertController(title:"Login Successful", message:"You will now be logged in", preferredStyle: UIAlertControllerStyle.Alert)
            let action = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: {(action) in
            //when the user clicks "Ok", do the following
            let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                appDelegate.navigateToGame()
            })
            alert.addAction(action)
            self.presentViewController(alert, animated: true, completion: nil)
                
            } else  {
                
                //registration failed
                let alert = UIAlertController(title:"Login Failed", message:message!, preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: {
                    
                })
                
            }
        }

}


   

//}

