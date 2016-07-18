//
//  LoginViewController.swift
//  Onboarding
//
//  Created by Ryan Davey on 5/31/16.
//  Copyright © 2016 Ryan Davey. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailField: EmailValidatedTextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var userInputTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Login"
        
        emailField.delegate = self
        passwordField.delegate = self
        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func loginButtonTapped(sender: UIButton) {
        let email = emailField.text
        let password = passwordField.text
        
        if (emailField.validate()) {

            UserController.sharedInstance.loginUser(email!,password:password!,presentingViewController: self, viewControllerCompletionFunction:{(user,message) in self.loginComplete(user, message:message)})
        }
    }
    
    func loginComplete(user: User?, message: String?){
        if let _ = user {
            print("User logged in ")
            let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            NSUserDefaults.standardUserDefaults().setValue("TRUE", forKey: "userIsLoggedIn")
            appDelegate.navigateToLoggedInNavigationController()

        }
        else if message != nil {
            print(message)
        }
    }
    
        
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if textField == emailField{
            print(string)
        }
        else if textField == passwordField {
            print(string)
        }
        else {
            print(string)
        }
        return true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
