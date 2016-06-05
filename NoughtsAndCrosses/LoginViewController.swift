//
//  LoginViewController.swift
// 
//
//  Created by Justin on 5/31/16.
//  Copyright © 2016 Justin. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var Failure: UILabel!
    
    @IBOutlet weak var email: EmailValidatedTextField!
    @IBOutlet weak var password: UITextField!
    
    
    @IBAction func LoginButtonTapped(sender: UIButton) {
        
        let emailGiven = email.text
        let passwordGiven = password.text
        let (failure_message, user) = UserController.sharedInstance.loginUser(emailGiven!, suppliedPassword: passwordGiven!)
        
        // Validate the email
        if(!email.validate()){
            email.updateUI()
            return
        }

        
        if (user != nil) {
            print("User registered view registration view")
            
            // Store user
//            NSUserDefaults.standardUserDefaults().setValue("TRUE", forKey: "userIsLoggedIn")
            
            // Move to the game
            let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            appDelegate.navigateToBoardNavigationController()
            

        }
        if (failure_message != nil){
            Failure.text = failure_message
            print("\(failure_message)")
        }

    }
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Login"
//        self.view.backgroundColor = UIColor.blueColor()
        // Do any additional setup after loading the view.
        
        email.delegate = self
        password.delegate = self
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        if(textField == email){
            print("email field just had a keystroke")
            print("textfield.text: \(email.text)")
            print("string: \(string)")
        }
        else if (textField == password){
            print("password field just had a keystroke")
            print("textfield.text: \(password.text)")
            print("string: \(string)")
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
