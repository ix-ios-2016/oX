 //
//  RegistrationViewController.swift
//  NoughtsAndCrosses
//
//  Created by Erik Roberts on 6/1/16.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController , UITextFieldDelegate {
    
    @IBOutlet weak var emailField: EmailValidatedTextField!
    @IBOutlet weak var passwordField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        emailField.delegate = self
        passwordField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        print("Username Textfield: \(emailField)")
        print("Username String \(string)")
        
//        print("Password Textfield: \(passwordField)")
//        print("Password String \(string)")
        
        return true
    }
    
    @IBAction func registerButtonTapped(sender: UIButton) {
        
        let emailSupplied = emailField.text!
        //let emailSupplied = String(UITextField.textInRange(emailField))
        let passwordSupplied = passwordField.text!
        
        if (!emailField.validate()){
            return
        }
        
        UserController.sharedInstance.registerUser(emailSupplied, password: passwordSupplied, presentingViewController: self , viewControllerCompletionFunction: {(user,message) in self.registrationComplete(user!, message: message)})
        
        addLoadingOverlay()
        
        //        If one is not present, check to see if a failure message is present and then print    the failure message.
        
        //if let _ = user {
            print (user)
            
            
            let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate //as! casts this returned value to type AppDelegate
            NSUserDefaults.standardUserDefaults().setValue("TRUE" , forKey: "userIsLoggedIn")
            appDelegate.navigateToGame()
        //} else {
        //    if let temp2 = failure_message{ //temp2 is NOT optional. If it exists, now we can use it
        //        print (temp2)
            }
        //}
        
    func registrationComplete(user : User , message : String?) {
        //new registration code
        
    }

 }
