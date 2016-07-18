//
//  LandingViewController.swift
//  Onboarding
//
//  Created by Ryan Davey on 5/31/16.
//  Copyright © 2016 Ryan Davey. All rights reserved.
//

import UIKit

class LandingViewController: UIViewController {
    
    
    @IBAction func loginButtonTapped(sender: AnyObject) {
        let lvc = LoginViewController(nibName: "LoginViewController",bundle:nil)
        self.navigationController?.pushViewController(lvc,animated:true)
        print("login button tapped")
    }
    
    
    @IBAction func registerButtonTapped(sender: AnyObject) {
        let lvc = RegistrationViewController(nibName: "RegistrationViewController",bundle:nil)
        self.navigationController?.pushViewController(lvc,animated:true)
        print("register button tapped")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Auth Menu"
        let _ = ClosureExperiment()
        // Do any additional setup after loading the view.
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
