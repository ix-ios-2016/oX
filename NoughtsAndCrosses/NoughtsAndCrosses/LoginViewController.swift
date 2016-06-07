//
//  LoginViewController.swift
//  Assigment 2A
//
//  Created by Rachel on 5/31/16.
//  Copyright © 2016 Rachel Katz. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailField: EmailValidatedTextField!
    @IBOutlet weak var passwordField: UITextField!


    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Login"
        
        emailField.delegate = self
        passwordField.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        //print(string)
        if( textField == emailField ){
            //print("email field was updated: " + emailField.text! + string)
        }
        return true
    }
    
    @IBAction func loginButtonTapped(sender: UIButton) {
        let email = emailField.text!
        let password = passwordField.text!
        
        if !emailField.validate() {
            return
        }
        
        UserController.sharedInstance.loginUser(email, password: password, presentingViewController: nil, viewControllerCompletionFunction: {(user,message) in self.loginCallComplete(user,message:message)})
        
        
        
        
    }
    func loginCallComplete(user: User?, message: String?){
        
        if let _ = user {
            let alert = UIAlertController(title: "Login Sucessful", message: "You will now be logged in", preferredStyle: UIAlertControllerStyle.Alert)
            let action = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: {(action) in
                let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                appDelegate.navigateToBoardNavigationController()
            
            })
            alert.addAction(action)
            self.presentViewController(alert, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Login Failed", message: message!, preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.Default, handler: nil ))
            self.presentViewController(alert, animated: true, completion: {
        
             })
    
        }
        
    }
}
