//
//  RegistrationViewController.swift
//  NoughtsAndCrosses
//
//  Created by Ingrid Polk on 5/31/16.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController {

    @IBOutlet weak var userNameField: EmailValidatedTextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func registrationComplete(user: User?, message:String?) {
        if !userNameField.validate(){
            return
            
        } else if message != nil {
            
            print(message)
            
            let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .Alert)
            let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in
                // ...
            }
            alertController.addAction(cancelAction)
            let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
                // ...
            }
            alertController.addAction(OKAction)
            self.presentViewController(alertController, animated: true) {
                // ...
            }
            return
        } else {
            
            let alertController = UIAlertController(title: "Success", message: "User registered", preferredStyle: .Alert)
            let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in
                // ...
            }
            alertController.addAction(cancelAction)
            let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
                let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                
                NSUserDefaults.standardUserDefaults().setValue("TRUE", forKey: "userIsLoggedIn")
                
                appDelegate.navigateToLoggedInNavigationController()
            }
            alertController.addAction(OKAction)
            self.presentViewController(alertController, animated: true) {
                // ...
            }
    }
    }
    
    @IBAction func registerButtonTapped(sender: UIButton) {
        let userName = userNameField.text
        let passwordName = passwordField.text
        UserController.sharedInstance.registerUser(userName!,password: passwordName!, presentingViewController: self, viewControllerCompletionFunction: {(user,message) in self.registrationComplete(user,message:message)})

        
    }


}
