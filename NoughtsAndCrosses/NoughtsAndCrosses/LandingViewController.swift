//
//  LandingViewController.swift
//  NoughtsAndCrosses
//
//  Created by Erik Roberts on 5/31/16.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import UIKit

class LandingViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginButtonTapped(sender: UIButton) {
       
        let emailSupplied = emailField.text!
        //let emailSupplied = String(UITextField.textInRange(emailField))
        let passwordSupplied = passwordField.text!
        
        let (failure_message , user) = UserController.sharedInstance.loginUser(emailSupplied, suppliedPassword: passwordSupplied)
        
        if let tmp = user {
            print (user)
            let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate //as! casts this returned value to type AppDelegate
            
            appDelegate.navigateToGame()
            
        } else if let tmp2 = failure_message {
            print (tmp2)
        }
    }
    @IBAction func registerButtonTapped(sender: UIButton) {
        
        print ("Register button tapped")
        
        let rvc = RegistrationViewController(nibName : "RegistrationViewController" , bundle : nil) //nibName must match the view controller's name
        self.navigationController?.pushViewController(rvc , animated: true)
    }
   
}
