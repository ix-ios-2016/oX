//
//  RegistrationViewController.swift
//  NoughtsAndCrosses
//
//  Created by Justin on 5/31/16.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController {


    @IBOutlet weak var emailField: EmailValidatedTextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var Failure: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Register"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func RegisterButtontapped(sender: UIButton) {
        
        let email = emailField.text
        let password = passwordField.text
        let (failure_message, user) = UserController.sharedInstance.registerUser(email!, newPassword: password!)
        
        
        // Validate the email
        if(!emailField.validate()){
            emailField.updateUI()
            return
        }
        
        if (user != nil) {
            print("User registered view registration view")
        }
        if (failure_message != nil){
            Failure.text = failure_message
            print("\(failure_message)")
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
