//
//  LoginViewController.swift
//  NoughtsAndCrosses
//
//  Created by Chris Motz on 6/1/16.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Log In"

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var emailTextField: EmailValidatedTextField!
    @IBOutlet weak var passwordTextField: UITextField!

    @IBAction func logInButtonTapped(sender: AnyObject) {
        print("Login here!")
        
        if (emailTextField.valid()) {
        
            let username = self.emailTextField.text
            let password = self.passwordTextField.text
        
            let (failureMessage, user) = UserController.sharedInstance.loginUser(username!, suppliedPassword: password!)
        
            if (user != nil) {
                print("User registered in registration view")
                let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                appDelegate.navigateToBoardViewController()
                // at this point we are happy to login the user, so let's store that persistent valaue
                NSUserDefaults.standardUserDefaults().setValue("TRUE", forKey: "userIsLoggenIn")
            }   else {
                    if (failureMessage != nil) {
                        print(failureMessage)
                }
            }
            emailTextField.validate()
        } else {
            emailTextField.updateUI()
        }
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


