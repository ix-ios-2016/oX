//
//  RegisterViewController.swift
//  NoughtsAndCrosses
//
//  Created by Salomon serfati on 5/31/16.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Register"

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func registerButtonTapped(sender: UIButton) {
        let email = emailField.text!
        let password = passwordField.text!
        
        var (failureMessage, user) = UserController.sharedInstance.registerUser(email,newPassword: password)
        
        if user != nil {
            print("The Register was Successful")
            
        } else if failureMessage != nil {
            print("registration failed: " + failureMessage!)
            
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
