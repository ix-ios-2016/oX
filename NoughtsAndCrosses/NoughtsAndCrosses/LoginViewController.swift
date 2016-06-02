//
//  LoginViewController.swift
//  NoughtsAndCrosses
//
//  Created by Kasra Koushan on 2016-05-31.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    
    @IBOutlet var emailField: EmailValidatedTextField!
    @IBOutlet var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Login"
        
//        self.emailField.delegate = self
//        self.passwordField.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
//        if (textField == self.emailField) {
//            print("EMAIL FIELD")
//        } else if (textField == self.passwordField) {
//            print("PASSWORD FIELD")
//        } else {
//            print("UNKNOWN FIELD")
//        }
//        print("Current text: \(textField.text!)")
//        print("Typed text: \(string)")
//        
//        return true
//    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    @IBAction func loginButtonTapped(sender: UIButton) {
        if self.emailField.validate() {
            let (failureMessage, user) = UserController.sharedInstance.loginUser(emailField.text!, suppliedPassword: passwordField.text!)
            if user != nil {
                let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                appDelegate.navigateToGame()
                // save log in data
            } else if failureMessage != nil {
                let alertController = UIAlertController(title: "Could not log in",
                                                        message: failureMessage, preferredStyle: .Alert)
                let OKAction = UIAlertAction(title: "OK", style: .Default) { _ in}
                alertController.addAction(OKAction)
                self.presentViewController(alertController, animated: true, completion: nil)
            }
        }
        
    }
    
    

}
