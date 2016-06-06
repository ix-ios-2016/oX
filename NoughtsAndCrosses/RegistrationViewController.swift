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
    
    func registrationComplete(user: User?, message: String?) {
        //new registration code
        if user != nil{
            let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            appDelegate.navigateToBoardNavigationController()
        }
        if message != nil{
            Failure.text = message
            print("\(message)")
        }
       
    }
    
    
    @IBAction func RegisterButtontapped(sender: UIButton) {
        
        let email = emailField.text
        let password = passwordField.text
        UserController.sharedInstance.registerUser(email!, password: password!, viewControllerCompletionFunction: {(user,message) in self.registrationComplete(user,message:message)})
        
        
        // Validate the email
        if(!emailField.validate()){
            emailField.updateUI()
            return
        }
        
//        if (user != nil) {
//            print("User registered view registration view")
//        }
//        if (failure_message != nil){
//            Failure.text = failure_message
//            print("\(failure_message)")
//        }

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
