//
//  LandingViewController.swift
//  NoughtsAndCrosses
//
//  Created by Erik Roberts on 5/31/16.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import UIKit

class LandingViewController: UIViewController {

//    @IBOutlet weak var emailField: UITextField!
//    
//    @IBOutlet weak var passwordField: UITextField!
//    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginButtonTapped(sender: UIButton) {
        print ("Login button tapped")
        
        let lvc = LoginViewController(nibName: "LoginViewController", bundle : nil)
        self.navigationController?.pushViewController(lvc, animated: true)
       
           }
    @IBAction func registerButtonTapped(sender: UIButton) {
        
        print ("Register button tapped")

        let rvc = RegistrationViewController(nibName : "RegistrationViewController" , bundle : nil) //nibName must match the view controller's name
        self.navigationController?.pushViewController(rvc , animated: true)
    }
   
}
