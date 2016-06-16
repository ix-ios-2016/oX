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
        
        // Validate the email
        if(!email.validate()){
            email.updateUI()
            return
        }
        
         UserController.sharedInstance.loginUser(emailGiven!, password: passwordGiven!, presentingViewController: self, viewControllerCompletionFunction: {(user,message) in self.logInComplete(user,message:message)})

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
    
    func logInComplete (user: User?,message: String?) {
        if let _ = user   {
            
            //successfully login
            let alert = UIAlertController(title:"Login Successful", message:"You will now be logged in", preferredStyle: UIAlertControllerStyle.Alert)
            let action = UIAlertAction(title: "Ok", style:UIAlertActionStyle.Default, handler: {(action) in
                //when the user clicks "Ok", do the following
                let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                appDelegate.navigateToBoardNavigationController()
            })
            alert.addAction(action)
            self.presentViewController(alert, animated: true, completion: nil)
            
        }   else    {
            
            //login failed
            let alert = UIAlertController(title:"Login Failed", message:message!, preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: {
                
            })
            
        }
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
