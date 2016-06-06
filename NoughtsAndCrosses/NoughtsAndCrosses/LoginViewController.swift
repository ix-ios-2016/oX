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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func loginButtonTapped(sender: UIButton) {
        let emailSupplied = emailField.text!
        //let emailSupplied = String(UITextField.textInRange(emailField))
        let passwordSupplied = passwordField.text!
        
        UserController.sharedInstance.loginUser(emailSupplied, password: passwordSupplied, presentingViewController: nil , viewControllerCompletionFunction: {(user,message) in self.loginCallComplete(user!, message: message)})
        
        //        If one is not present, check to see if a failure message is present and then print    the failure message.

        }
        
        //print("Login Button Tapped")
    
    func loginCallComplete(user : User? , message : String?) {
        //new registration code
        
        
        
//        if (user != nil) {
//            
//            print (user)
//            
//            let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate //as! casts this returned value to type AppDelegate
//            
//            appDelegate.navigateToGame()
//            //navigateToLoggedInNavigationController
//            
//            //This is how we store something in the harddrive
//            NSUserDefaults.standardUserDefaults().setValue("True" , forKey: "userIsLoggedIn")
//        } else {
//            //if let temp2 = failure_message { //temp2 is NOT optional. If it exists, now we can use it
//            //    print (temp2)
//            }
//        
//    }

    }
}

   

//}

