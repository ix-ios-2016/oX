//
//  LoginViewController.swift
//  NoughtsAndCrosses
//
//  Created by Serene Mirza on 5/31/16.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    
    
    @IBOutlet weak var emailField: EmailValidatedTextField!
    
    
    @IBOutlet weak var passwordField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Login"

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func loginButtonTapped(sender: UIButton) {
        UserController.sharedInstance.registerUser(emailField.text!, password: passwordField.text!, presentingViewController: self, viewControllerCompletionFunction: {(user,message) in self.loginComplete(user,message:message)})
        
    }
    
    func loginComplete(user: User?, message:String?) {
        if (message == nil) {
            //login user
            print("User logged in in login view")
            appDelegate.navigateToBoardViewController()
            
            //store the persistant value in harddrive
            //(this way user will not need to log in each time unless logged out)
            NSUserDefaults.standardUserDefaults().setValue("TRUE", forKey: "userIsLoggedIn")
        }
        else {
            //show error alert
            let alertController = UIAlertController(title: "Error", message: "\(message!)", preferredStyle: .Alert)
            let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in }
            alertController.addAction(cancelAction)
            let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in }
            alertController.addAction(OKAction)
            self.presentViewController(alertController, animated: true) {}
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
