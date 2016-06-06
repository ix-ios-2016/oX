//
//  RegisterViewController.swift
//  NoughtsAndCrosses
//
//  Created by Eden Mekonnen on 6/6/16.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet var passwordField: UITextField!
    
    @IBOutlet var emailField: UITextField!
    
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
        var password = passwordField.text!
        var username = emailField.text!
        let (failure_message, user) = UserController.sharedInstance.registerUser(username, newPassword: password)
        
        if let user = user {
            print("User registered in registration view")
        } else {
            print("User failed to register")

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