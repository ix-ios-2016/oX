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
            
            
            let (failureMessage, user) = UserController.sharedInstance.registerUser(username!, newPassword: password!)
            
            
            if (user != nil) {
                print("User registered in registration view")
                let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                appDelegate.navigateToBoardViewController()
            }   else {
                    if (failureMessage != nil) {
                        print(failureMessage)
                }
            }
            emailTextField.validate()
            print("Register here!")
        } else {
            emailTextField.updateUI()
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
