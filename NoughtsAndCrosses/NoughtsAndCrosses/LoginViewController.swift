//
//  LoginViewController.swift
//  NoughtsAndCrosses
//
//  Created by Salomon serfati on 5/31/16.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailField: EmailValidatedTextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Login"
        emailField.delegate = self
        passwordField.delegate = self

        // Do any additional setup after loading the view.
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if textField == emailField {
            print("Email Field: \(textField.text! + string)")
            
        } else if textField == passwordField {
            print("Password Field: \(textField.text! + string)")
        }
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func loginButtonTapped(sender: UIButton) {
        let email = emailField.text!
        let password = passwordField.text!
        let (failureMessage, user) = UserController.sharedInstance.loginUser(email, suppliedPassword: password)
        if emailField.validate(){
        if user != nil {
            print("User is logged in")
            let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            
            appDelegate.returnToOxGameNavigation()
            
        } else if failureMessage != nil {
            print("Login failed: " + failureMessage!)
            loginLabel.text = "Login failed: " + failureMessage!
            
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

}
