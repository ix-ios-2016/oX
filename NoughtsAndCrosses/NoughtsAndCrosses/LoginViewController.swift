//
//  LoginViewController.swift
//  NoughtsAndCrosses
//
//  Created by Eden Mekonnen on 6/6/16.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet var usernameField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "login"

        // Do any additional setup after loading the view.
    }

    @IBOutlet var passwordFIeld: UITextField!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginButtonTapped(sender: UIButton) {
        var password = passwordFIeld.text!
        var username = usernameField.text!
        let (failure_message, user) = UserController.sharedInstance.loginUser(username, suppliedPassword: password)
        if let user = user {
            print("User logged in ")
            let appdelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            appdelegate.navigateToBoardViewController()
        } else {
            print("User failed to login")
            
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
